#ifndef MODULE1_H_INCLUDED
#define MODULE1_H_INCLUDED

#include <fftw3.h>
#include <vector>

/* ---------------
 *  Main Function
 * --------------- */
int run_module(
    std::vector<float> &img
,   const unsigned width
,   const unsigned height
,   const unsigned chnls
,   const unsigned tau_2D_hard
,   const unsigned tau_2D_wien
,   const unsigned color_space
);

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
);

//! HT filtering using Welsh-Hadamard transform (do only
//! third dimension transform, Hard Thresholding
//! and inverse Hadamard transform)
void ht_filtering_hadamard(
    std::vector<float> &group_3D
,   std::vector<float> &tmp
,   const unsigned nSx_r
,   const unsigned kHard
,   const unsigned chnls
,   std::vector<float> const& sigma_table
,   const float lambdaThr3D
,   std::vector<float> &weight_table
,   const bool doWeight
);


//! Process 2D dct of a group of patches
void dct_2d_process(
    std::vector<float> &DCT_table_2D
,   std::vector<float> const& img
,   fftwf_plan * plan_1
,   fftwf_plan * plan_2
,   const unsigned nHW
,   const unsigned width
,   const unsigned height
,   const unsigned chnls
,   const unsigned kHW
,   const unsigned i_r
,   const unsigned step
,   std::vector<float> const& coef_norm
,   const unsigned i_min
,   const unsigned i_max
);

//! Process 2D bior1.5 transform of a group of patches
void bior_2d_process(
    std::vector<float> &bior_table_2D
,   std::vector<float> const& img
,   const unsigned nHW
,   const unsigned width
,   const unsigned height
,   const unsigned chnls
,   const unsigned kHW
,   const unsigned i_r
,   const unsigned step
,   const unsigned i_min
,   const unsigned i_max
,   std::vector<float> &lpd
,   std::vector<float> &hpd
);

void dct_2d_inverse(
    std::vector<float> &group_3D_table
,   const unsigned kHW
,   const unsigned N
,   std::vector<float> const& coef_norm_inv
,   fftwf_plan * plan
);

void bior_2d_inverse(
    std::vector<float> &group_3D_table
,   const unsigned kHW
,   std::vector<float> const& lpr
,   std::vector<float> const& hpr
);

//! Wiener filtering using Welsh-Hadamard transform
void wiener_filtering_hadamard(
    std::vector<float> &group_3D_img
,   std::vector<float> &group_3D_est
,   std::vector<float> &tmp
,   const unsigned nSx_r
,   const unsigned kWien
,   const unsigned chnls
,   std::vector<float> const& sigma_table
,   std::vector<float> &weight_table
,   const bool doWeight
);

//! Apply a bior1.5 spline wavelet on a vector of size N x N.
void bior1_5_transform(
    std::vector<float> const& input
,   std::vector<float> &output
,   const unsigned N
,   std::vector<float> const& bior_table
,   const unsigned d_i
,   const unsigned d_o
,   const unsigned N_i
,   const unsigned N_o
);

void preProcess(
    std::vector<float> &kaiserWindow
,   std::vector<float> &coef_norm
,   std::vector<float> &coef_norm_inv
,   const unsigned kHW
);

void precompute_BM(
    std::vector<std::vector<unsigned> > &patch_table
,   const std::vector<float> &img
,   const unsigned width
,   const unsigned height
,   const unsigned kHW
,   const unsigned NHW
,   const unsigned n
,   const unsigned pHW
,   const float    tauMatch
);

#endif 