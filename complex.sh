#!/bin/bash

make
./BM3Ddenoising complex-512x512.png 0 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/complex-iyad-sigma0/.
mv ./mags.png outputs/complex-iyad-sigma0/.
mv ./Gx.png outputs/complex-iyad-sigma0/.
mv ./Gy.png outputs/complex-iyad-sigma0/.

./BM3Ddenoising complex-512x512.png 1 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/complex-iyad-sigma1/.
mv ./mags.png outputs/complex-iyad-sigma1/.
mv ./Gx.png outputs/complex-iyad-sigma1/.
mv ./Gy.png outputs/complex-iyad-sigma1/.
mv ./ImNoisy.png outputs/complex-iyad-sigma1/.
mv ./ImDiff.png outputs/complex-iyad-sigma1/.
mv ./ImDenoised.png outputs/complex-iyad-sigma1/.
mv ./ImBasic.png outputs/complex-iyad-sigma1/.
mv ./measures.txt outputs/complex-iyad-sigma1/.

./BM3Ddenoising complex-512x512.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/complex-iyad-sigma10/.
mv ./mags.png outputs/complex-iyad-sigma10/.
mv ./Gx.png outputs/complex-iyad-sigma10/.
mv ./Gy.png outputs/complex-iyad-sigma10/.
mv ./ImNoisy.png outputs/complex-iyad-sigma10/.
mv ./ImDiff.png outputs/complex-iyad-sigma10/.
mv ./ImDenoised.png outputs/complex-iyad-sigma10/.
mv ./ImBasic.png outputs/complex-iyad-sigma10/.
mv ./measures.txt outputs/complex-iyad-sigma10/.

./BM3Ddenoising complex-512x512.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/complex-iyad-sigma30/.
mv ./mags.png outputs/complex-iyad-sigma30/.
mv ./Gx.png outputs/complex-iyad-sigma30/.
mv ./Gy.png outputs/complex-iyad-sigma30/.
mv ./ImNoisy.png outputs/complex-iyad-sigma30/.
mv ./ImDiff.png outputs/complex-iyad-sigma30/.
mv ./ImDenoised.png outputs/complex-iyad-sigma30/.
mv ./ImBasic.png outputs/complex-iyad-sigma30/.
mv ./measures.txt outputs/complex-iyad-sigma30/.