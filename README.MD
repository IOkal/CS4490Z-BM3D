# Image Analysis Tools for Image Denoising Techniques

## ABOUT
* Author           : Iyad Okal <iokal@uwo.ca>
* Code Adapted from: Marc Lebrun  <marc.lebrun@cmla.ens-cachan.fr>
* Licence          : GPL v3+, see GPLv3.txt

## OVERVIEW

This source code provides an of the BM3D image denoising.

## Abstract
**Context and Motivation:** Millions of images are captured daily, continually increasing the demand for higher quality images. Based on the capture device, images may be distorted by additive noise, and an image denoising algorithm handles the task of getting more information out of the image.
**Question/problem/Objectives:** Image denoising is done by removing high-frequency noise. Incidentally, this also removes anything in the high-frequency range, creating artifacts as a result. My objective is to distinguish the noise from the information, having the slightest impact on image quality when denoising.
**Principal ideas:** Most image denoising methods work optimally; however, I tweak the algorithms on various images to improve each algorithm in my research. I use additive patch-based algorithms to denoise the images.
**Research approach (or methodology):** I plan to create a tool to analyze image denoising techniques by extracting features from similar patches, where patches are n×n pixels.
**Anticipated contribution (or results):** There is a lack of research into image comparison tools and my research brings forward a different way of looking at image denoising. 
**Anticipated impact of results:** The results will analyze different modifications to the BM3D algorithm to see any possible improvements in image quality.
**Limitations:** I limit my research to only additive noise; otherwise, the scope would be too big.


## UNIX/LINUX/MAC USER GUIDE

The code is only compilable on Unix/Linux and Mac OS. 

## Compilation:
Automated compilation through `make` (NOTE: see the prerequisite section to ensure successful compilation).

## Prerequisites: 
1. libpng library (guide)[https://geeksww.com/tutorials/libraries/libpng/installation/installing_libpng_on_ubuntu_linux.php
]
2. (fftw library)[http://www.fftw.org/download.html].
3. (Optional) OpenMP (This will accelerate runtime)

## Image format:
Only the PNG format is supported. 

## Common Errors:
1. `/usr/bin/ld: cannot find -lfftw3f`
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`collect2: error: ld returned 1 exit status`
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To fix the error: (according to https://ubuntuforums.org/showthread.php?t=1274884) type the command:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `sudo apt-get install fftw3-dev`
 
2. `io_png.c:69:10: fatal error: png.h: No such file or directory`
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Solution, according to https://stackoverflow.com/questions/36674667/png-h-file-not-found-linux:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `sudo apt-get install libpng-dev`

-------------------------------------------------------------------------
Usage:
1. Clone this repository. Enter the directory with `cd CS4490Z-BM3D`. 

2. Compile the source code (on Unix/Linux/Mac OS). 
There are two ways to compile the code. 
(1) RECOMMENDED, with Open Multi-Processing multithread parallelization 
(http://openmp.org/). Roughly speaking, it accelerates the program using the 
multiple processors in the computer. Run:

`make OMP=1`

OR
(2) If the complier does not support OpenMp, run 
make

3. Run BM3D image denoising.
./BM3Ddenoising
The generic way to run the code is:

./BM3Ddenoising cinput.png sigma ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png
ImDiffBias.png computeBias 2DtransformStep1 useSD1 2DtransformStep2 useSD2 ColorSpace

with :
- cinput.png is a noise-free image;
- sigma is the value of the noise which will be added to cinput.png;
- ImNoisy.png will contain the noisy image;
- ImBasic.png will contain the result of the first step of the algorithm;
- ImDenoised.png will contain the final result of the algorithm;
- ImDiff.png will contain the difference between cinput.png and ImDenoised.png;
- ImBias.png will contain the result of the algorithm applied on cinput.png;
- ImDiffBias.png will contain the difference between cinput.png and ImBias.png;
- computeBias : see (3);
- 2DtransformStep1: choice of the 2D transform which will be applied in the first step of the
algorithm. See (4);
- useSD1 : see (1) below;
- 2DtransformStep2: choice of the 2D transform which will be applied in the second step of the
algorithm. See (4);
- useSD2 : see (2);
- ColorSpace : choice of the color space on which the image will be applied. See (5).

There are multiple ways to run the code:
(1) for the first step, users can choose if they prefer to use
standard variation for the weighted aggregation (useSD1 = 1)
(2) for the second step, users can choose if they prefer to use
standard variation for the weighted aggregation (useSD2 = 1)
(3) you can moreover want to compute the bias (algorithm applied to the original
image). To do this, use computeBias = 1.
(4) you can choose the DCT transform or the Bior1.5 transform for the 2D transform
in the step 1 (tau_2D_hard = dct or bior) and/or the step 2. (tau_2d_wien = dct or
bior).
(5) you can choose the colorspace for both steps between : rgb, yuv, ycbcr and opp.
 
Example, run
./BM3Ddenoising cinput.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png
ImDiffBias.png 1 bior 0 dct 1 opp


# ABOUT THIS FILE

The base code was written by Marc Lebrun, modifications and different modules added by Iyad Okal.

Copyright 2011 IPOL Image Processing On Line http://www.ipol.im/

Copying and distribution of this file, with or without modification,
are permitted in any medium without royalty provided the copyright
notice and this notice are preserved.  This file is offered as-is,
without any warranty.
