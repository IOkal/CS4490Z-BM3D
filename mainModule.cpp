#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string.h>

#include "bm3d.h"
#include "utilities.h"
#include "module1.h"

#define YUV       0
#define YCBCR     1
#define OPP       2
#define RGB       3
#define DCT       4
#define BIOR      5
#define HADAMARD  6
#define NONE      7

using namespace std;

/**
 * @file   module1.cpp
 * @brief  Executable file to generate histograms based on BM3d Patches
 *
 * @author IYAD OKAL <iokal@uwo.ca>
 * ORIGINAL REPO: Marc Lebrun <marc.lebrun@cmla.ens-cachan.fr>
 */


int main(int argc, char **argv)
{
    //! Check if there is the right call for the algorithm
	if (argc < 4){
        cout << "Usage: ./Module1 {image.png} tau_2d_hard tau_2d_wien color_space" << endl;
        return EXIT_FAILURE;
    }
    
    // if (argc < 14)
	// {
	// 	cout << "usage: BM3D image sigma noisy basic denoised difference bias \
    //              difference_bias computeBias tau_2d_hard useSD_hard \
    //              tau_2d_wien useSD_wien color_space" << endl;
	// 	return EXIT_FAILURE;
	// }

	//! Declarations
	vector<float> img;
    unsigned width, height, chnls;

    //! Load image
	if(load_image(argv[1], img, &width, &height, &chnls) != EXIT_SUCCESS)
        return EXIT_FAILURE;

	//! Variables initialization
	const unsigned tau_2D_hard  = (strcmp(argv[2], "dct" ) == 0 ? DCT :
                                  (strcmp(argv[2], "bior") == 0 ? BIOR : NONE));
    if (tau_2D_hard == NONE)
    {
        cout << "tau_2d_hard is not known. Choice is :" << endl;
        cout << " -dct" << endl;
        cout << " -bior" << endl;
        return EXIT_FAILURE;
    }
	const unsigned tau_2D_wien  = (strcmp(argv[3], "dct" ) == 0 ? DCT :
                                  (strcmp(argv[3], "bior") == 0 ? BIOR : NONE));
    if (tau_2D_wien == NONE)
    {
        cout << "tau_2d_wien is not known. Choice is :" << endl;
        cout << " -dct" << endl;
        cout << " -bior" << endl;
        return EXIT_FAILURE;
    };
	const unsigned color_space  = (strcmp(argv[4], "rgb"  ) == 0 ? RGB   :
                                  (strcmp(argv[4], "yuv"  ) == 0 ? YUV   :
                                  (strcmp(argv[4], "ycbcr") == 0 ? YCBCR :
                                  (strcmp(argv[4], "opp"  ) == 0 ? OPP   : NONE))));
    if (color_space == NONE)
    {
        cout << "color_space is not known. Choice is :" << endl;
        cout << " -rgb" << endl;
        cout << " -yuv" << endl;
        cout << " -opp" << endl;
        cout << " -ycbcr" << endl;
        return EXIT_FAILURE;
    };
	unsigned       wh           = (unsigned) width * height;
	unsigned       whc          = (unsigned) wh * chnls;

    //! Running BM3D module that finds similar patches and orders them
    if (run_module(img, width, height, chnls, tau_2D_hard, tau_2D_wien, color_space)!= EXIT_SUCCESS)
        return EXIT_FAILURE;

    //! Denoising
    // if (run_bm3d(fSigma, img_noisy, img_basic, img_denoised, width, height, chnls,
    //              useSD_1, useSD_2, tau_2D_hard, tau_2D_wien, color_space)
    //     != EXIT_SUCCESS)
    //     return EXIT_FAILURE;

    cout << "done." << endl;

	return EXIT_SUCCESS;
}
