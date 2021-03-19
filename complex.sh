#!/bin/bash

make
./BM3Ddenoising complex-512x512.png 0 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
cp ./angs.png complex-iyad-sigma0/.
cp ./mags.png complex-iyad-sigma0/.
cp ./Gx.png complex-iyad-sigma0/.
cp ./Gy.png complex-iyad-sigma0/.

./BM3Ddenoising complex-512x512.png 1 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
cp ./angs.png complex-iyad-sigma1/.
cp ./mags.png complex-iyad-sigma1/.
cp ./Gx.png complex-iyad-sigma1/.
cp ./Gy.png complex-iyad-sigma1/.
cp ./ImNoisy.png complex-iyad-sigma1/.
cp ./ImDiff.png complex-iyad-sigma1/.
cp ./ImDenoised.png complex-iyad-sigma1/.
cp ./ImBasic.png complex-iyad-sigma1/.
cp ./measures.txt complex-iyad-sigma1/.

./BM3Ddenoising complex-512x512.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
cp ./angs.png complex-iyad-sigma10/.
cp ./mags.png complex-iyad-sigma10/.
cp ./Gx.png complex-iyad-sigma10/.
cp ./Gy.png complex-iyad-sigma10/.
cp ./ImNoisy.png complex-iyad-sigma10/.
cp ./ImDiff.png complex-iyad-sigma10/.
cp ./ImDenoised.png complex-iyad-sigma10/.
cp ./ImBasic.png complex-iyad-sigma10/.
cp ./measures.txt complex-iyad-sigma10/.

./BM3Ddenoising complex-512x512.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
cp ./angs.png complex-iyad-sigma30/.
cp ./mags.png complex-iyad-sigma30/.
cp ./Gx.png complex-iyad-sigma30/.
cp ./Gy.png complex-iyad-sigma30/.
cp ./ImNoisy.png complex-iyad-sigma30/.
cp ./ImDiff.png complex-iyad-sigma30/.
cp ./ImDenoised.png complex-iyad-sigma30/.
cp ./ImBasic.png complex-iyad-sigma30/.
cp ./measures.txt complex-iyad-sigma30/.

rm angs.png
rm mags.png
rm Gx.png
rm Gy.png
rm ImNoisy.png
rm ImDiff.png
rm ImDenoised.png
rm ImBasic.png