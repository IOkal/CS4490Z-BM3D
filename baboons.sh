#!/bin/bash

rm -r outputs/baboon-iyad-sigma1/*
rm -r outputs/baboon-iyad-sigma10/*
rm -r outputs/baboon-iyad-sigma30/*
rm -r outputs/baboon-iyad-sigma0/*

make

./BM3Ddenoising baboon.png 0 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/baboon-iyad-sigma0/.
mv ./mags.png outputs/baboon-iyad-sigma0/.
mv ./Gx.png outputs/baboon-iyad-sigma0/.
mv ./Gy.png outputs/baboon-iyad-sigma0/.

./BM3Ddenoising baboon.png 1 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/baboon-iyad-sigma1/.
mv ./mags.png outputs/baboon-iyad-sigma1/.
mv ./Gx.png outputs/baboon-iyad-sigma1/.
mv ./Gy.png outputs/baboon-iyad-sigma1/.
mv ./ImNoisy.png outputs/baboon-iyad-sigma1/.
mv ./ImDiff.png outputs/baboon-iyad-sigma1/.
mv ./ImDenoised.png outputs/baboon-iyad-sigma1/.
mv ./ImBasic.png outputs/baboon-iyad-sigma1/.
mv ./measures.txt outputs/baboon-iyad-sigma1/.

./BM3Ddenoising baboon.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/baboon-iyad-sigma10/.
mv ./mags.png outputs/baboon-iyad-sigma10/.
mv ./Gx.png outputs/baboon-iyad-sigma10/.
mv ./Gy.png outputs/baboon-iyad-sigma10/.
mv ./ImNoisy.png outputs/baboon-iyad-sigma10/.
mv ./ImDiff.png outputs/baboon-iyad-sigma10/.
mv ./ImDenoised.png outputs/baboon-iyad-sigma10/.
mv ./ImBasic.png outputs/baboon-iyad-sigma10/.
mv ./measures.txt outputs/baboon-iyad-sigma10/.

./BM3Ddenoising baboon.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/baboon-iyad-sigma30/.
mv ./mags.png outputs/baboon-iyad-sigma30/.
mv ./Gx.png outputs/baboon-iyad-sigma30/.
mv ./Gy.png outputs/baboon-iyad-sigma30/.
mv ./ImNoisy.png outputs/baboon-iyad-sigma30/.
mv ./ImDiff.png outputs/baboon-iyad-sigma30/.
mv ./ImDenoised.png outputs/baboon-iyad-sigma30/.
mv ./ImBasic.png outputs/baboon-iyad-sigma30/.
mv ./measures.txt outputs/baboon-iyad-sigma30/.

cp baboon.png outputs/baboon-iyad-sigma0/.
cp baboon.png outputs/baboon-iyad-sigma1/.
cp baboon.png outputs/baboon-iyad-sigma10/.
cp baboon.png outputs/baboon-iyad-sigma30/.