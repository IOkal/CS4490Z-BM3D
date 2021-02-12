#include <iostream>
#include <algorithm>
#include <math.h>

#include "module1.h"
#include "utilities.h"
#include "lib_transforms.h"

#define SQRT2     1.414213562373095
#define SQRT2_INV 0.7071067811865475
#define YUV       0
#define YCBCR     1
#define OPP       2
#define RGB       3
#define DCT       4
#define BIOR      5
#define HADAMARD  6

using namespace std;

int run_module(
    std::vector<float> &img
,   const unsigned width
,   const unsigned height
,   const unsigned chnls
,   const unsigned tau_2D_hard
,   const unsigned tau_2D_wien
,   const unsigned color_space
){
    // NOTE: Sigma = 0 since we're not adding any noise. This would be moved if we decide to add noise.
    const float sigma = 0;
    
    //! Parameters    
    const unsigned nHard = 16; //! Half size of the search window
    const unsigned nWien = 16; //! Half size of the search window
    const unsigned kHard = (tau_2D_hard == BIOR || sigma < 40.f ? 8 : 12); //! Must be a power of 2 if tau_2D_hard == BIOR
    const unsigned kWien = (tau_2D_wien == BIOR || sigma < 40.f ? 8 : 12); //! Must be a power of 2 if tau_2D_wien == BIOR
    const unsigned NHard = 16; //! Must be a power of 2
    const unsigned NWien = 32; //! Must be a power of 2
    const unsigned pHard = 3;
    const unsigned pWien = 3;

    //! Transformation to YUV color space
    if (color_space_transform(img, color_space, width, height, chnls, true)
        != EXIT_SUCCESS) return EXIT_FAILURE;

    unsigned nb_threads = 1;
    cout << endl << "Number of threads which will be used: 1" << nb_threads;

    //! Allocate plan for FFTW library
    fftwf_plan plan_2d_for_1[nb_threads];
    fftwf_plan plan_2d_for_2[nb_threads];
    fftwf_plan plan_2d_inv[nb_threads];

    //! In the simple case
    if (nb_threads == 1)
    {
        //! Add boundaries and symetrize them
        const unsigned h_b = height + 2 * nHard;
        const unsigned w_b = width  + 2 * nHard;

        vector<float> img_sym;
        symetrize(img, img_sym, width, height, chnls, nHard);

        //! Allocating Plan for FFTW process
        if (tau_2D_hard == DCT)
        {
            const unsigned nb_cols = ind_size(w_b - kHard + 1, nHard, pHard);
            allocate_plan_2d(&plan_2d_for_1[0], kHard, FFTW_REDFT10,
                                                        w_b * (2 * nHard + 1) * chnls);
            allocate_plan_2d(&plan_2d_for_2[0], kHard, FFTW_REDFT10,
                                                        w_b * pHard * chnls);
            allocate_plan_2d(&plan_2d_inv  [0], kHard, FFTW_REDFT01,
                                                        NHard * nb_cols * chnls);
        }

        //! Creating Patches / Groups of patches
        cout << "step 1..." << endl;

        create_patches(img_sym, w_b, h_b, chnls, nHard,
                      kHard, NHard, pHard, color_space, tau_2D_hard,
                      &plan_2d_for_1[0], &plan_2d_for_2[0], &plan_2d_inv[0]);

        // bm3d_1st_step(sigma, img_sym_noisy, img_sym_basic, w_b, h_b, chnls, nHard,
        //               kHard, NHard, pHard, useSD_h, color_space, tau_2D_hard,
        //               &plan_2d_for_1[0], &plan_2d_for_2[0], &plan_2d_inv[0]);
        cout << "done." << endl;
    }
    
    fftwf_cleanup();

    return EXIT_SUCCESS;
}

void create_patches(
    std::vector<float> &img
,   const unsigned width
,   const unsigned height
,   const unsigned chnls
,   const unsigned nHard
,   const unsigned kHard
,   const unsigned NHard
,   const unsigned pHard
,   const unsigned color_space
,   const unsigned tau_2D
,   fftwf_plan *  plan_2d_for_1
,   fftwf_plan *  plan_2d_for_2
,   fftwf_plan *  plan_2d_inv
){
    // NOTE: Sigma = 0 since we're not adding any noise. This would be moved if we decide to add noise.
    const float sigma = 0;

    //! Estimatation of sigma on each channel
    vector<float> sigma_table(chnls);
    if (estimate_sigma(sigma, sigma_table, chnls, color_space) != EXIT_SUCCESS)
        return;

    const float    lambdaHard3D = 2.7f;            //! Threshold for Hard Thresholding
    const float    tauMatch = (chnls == 1 ? 3.f : 1.f) * (sigma_table[0] < 35.0f ? 2500 : 5000); //! threshold used to determinate similarity between patches
    
    //! Initialization for convenience
    vector<unsigned> row_ind;
    ind_initialize(row_ind, height - kHard + 1, nHard, pHard);
    vector<unsigned> column_ind;
    ind_initialize(column_ind, width - kHard + 1, nHard, pHard);
    const unsigned kHard_2 = kHard * kHard;
    vector<float> group_3D_table(chnls * kHard_2 * NHard * column_ind.size());
    vector<float> wx_r_table;
    wx_r_table.reserve(chnls * column_ind.size());
    vector<float> hadamard_tmp(NHard);

     //! Preprocessing (KaiserWindow, Threshold, DCT normalization, ...)
    vector<float> kaiser_window(kHard_2);
    vector<float> coef_norm(kHard_2);
    vector<float> coef_norm_inv(kHard_2);
    preProcess(kaiser_window, coef_norm, coef_norm_inv, kHard);

    //! Preprocessing of Bior table
    vector<float> lpd, hpd, lpr, hpr;
    bior15_coef(lpd, hpd, lpr, hpr);

    //! For aggregation part
    vector<float> denominator(width * height * chnls, 0.0f);
    vector<float> numerator  (width * height * chnls, 0.0f);

    //! Precompute Bloc-Matching
    vector<vector<unsigned> > patch_table;
    precompute_BM(patch_table, img, width, height, kHard, NHard, nHard, pHard, tauMatch);

    cout << "Printing patch_table vector after bloc matching" << endl;
    for ( vector<vector<int>>::size_type i = 0; i < patch_table.size(); i++ )
    {
        for ( std::vector<int>::size_type j = 0; j < patch_table[i].size(); j++ )
        {
            std::cout << patch_table[i][j] << ' ';
        }
        std::cout << std::endl;
    }

    //! table_2D[p * N + q + (i * width + j) * kHard_2 + c * (2 * nHard + 1) * width * kHard_2]
    vector<float> table_2D((2 * nHard + 1) * width * chnls * kHard_2, 0.0f);

    //! Loop on i_r
    for (unsigned ind_i = 0; ind_i < row_ind.size(); ind_i++)
    {
        const unsigned i_r = row_ind[ind_i];

        //! Update of table_2D
        if (tau_2D == DCT)
            dct_2d_process(table_2D, img, plan_2d_for_1, plan_2d_for_2, nHard,
                           width, height, chnls, kHard, i_r, pHard, coef_norm,
                           row_ind[0], row_ind.back());
        else if (tau_2D == BIOR)
            bior_2d_process(table_2D, img, nHard, width, height, chnls,
                        kHard, i_r, pHard, row_ind[0], row_ind.back(), lpd, hpd);

        wx_r_table.clear();
        group_3D_table.clear();
 
        //! Loop on j_r
        for (unsigned ind_j = 0; ind_j < column_ind.size(); ind_j++)
        {
            //! Initialization
            const unsigned j_r = column_ind[ind_j];
            const unsigned k_r = i_r * width + j_r;

            //! Number of similar patches
            const unsigned nSx_r = patch_table[k_r].size();

            // printf("Number of patches was: %ui", nSx_r);

            //! Build of the 3D group
            vector<float> group_3D(chnls * nSx_r * kHard_2, 0.0f);
            for (unsigned c = 0; c < chnls; c++)
                for (unsigned n = 0; n < nSx_r; n++)
                {
                    const unsigned ind = patch_table[k_r][n] + (nHard - i_r) * width;
                    for (unsigned k = 0; k < kHard_2; k++)
                        group_3D[n + k * nSx_r + c * kHard_2 * nSx_r] =
                            table_2D[k + ind * kHard_2 + c * kHard_2 * (2 * nHard + 1) * width];
                }

            //! HT filtering of the 3D group
            vector<float> weight_table(chnls);
            ht_filtering_hadamard(group_3D, hadamard_tmp, nSx_r, kHard, chnls, sigma_table,
                                                    lambdaHard3D, weight_table, true);

            //! Save the 3D group. The DCT 2D inverse will be done after.
            for (unsigned c = 0; c < chnls; c++)
                for (unsigned n = 0; n < nSx_r; n++)
                    for (unsigned k = 0; k < kHard_2; k++)
                        group_3D_table.push_back(group_3D[n + k * nSx_r +
                                                                    c * kHard_2 * nSx_r]);

            //! Save weighting
            for (unsigned c = 0; c < chnls; c++)
                wx_r_table.push_back(weight_table[c]);

        } //! End of loop on j_r

        //!  Apply 2D inverse transform
        if (tau_2D == DCT)
            dct_2d_inverse(group_3D_table, kHard, NHard * chnls * column_ind.size(),
                           coef_norm_inv, plan_2d_inv);
        else if (tau_2D == BIOR)
            bior_2d_inverse(group_3D_table, kHard, lpr, hpr);

        //! Registration of the weighted estimation
        unsigned dec = 0;
        for (unsigned ind_j = 0; ind_j < column_ind.size(); ind_j++)
        {
            const unsigned j_r   = column_ind[ind_j];
            const unsigned k_r   = i_r * width + j_r;
            const unsigned nSx_r = patch_table[k_r].size();
            for (unsigned c = 0; c < chnls; c++)
            {
                for (unsigned n = 0; n < nSx_r; n++)
                {
                    const unsigned k = patch_table[k_r][n] + c * width * height;
                    for (unsigned p = 0; p < kHard; p++)
                        for (unsigned q = 0; q < kHard; q++)
                        {
                            const unsigned ind = k + p * width + q;
                            numerator[ind] += kaiser_window[p * kHard + q]
                                            * wx_r_table[c + ind_j * chnls]
                                            * group_3D_table[p * kHard + q + n * kHard_2
                                                  + c * kHard_2 * nSx_r + dec];
                            denominator[ind] += kaiser_window[p * kHard + q]
                                            * wx_r_table[c + ind_j * chnls];
                        }
                }
            }
            dec += nSx_r * chnls * kHard_2;
        }

    } //! End of loop on i_r

    //! Final reconstruction
    for (unsigned k = 0; k < width * height * chnls; k++)
        img_basic[k] = numerator[k] / denominator[k];
}