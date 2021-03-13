#!/bin/bash

rm -r outputs/boat-iyad-sigma1/*
rm -r outputs/boat-iyad-sigma10/*
rm -r outputs/boat-iyad-sigma30/*
rm -r outputs/boat-iyad-sigma0/*

make

./BM3Ddenoising boat.png 0 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/boat-iyad-sigma0/.
mv ./mags.png outputs/boat-iyad-sigma0/.
mv ./Gx.png outputs/boat-iyad-sigma0/.
mv ./Gy.png outputs/boat-iyad-sigma0/.
mv ./ImNoisy.png outputs/boat-iyad-sigma0/.
mv ./ImDiff.png outputs/boat-iyad-sigma0/.
mv ./ImDenoised.png outputs/boat-iyad-sigma0/.
mv ./ImBasic.png outputs/boat-iyad-sigma0/.
mv ./measures.txt outputs/boat-iyad-sigma0/.

./BM3Ddenoising boat.png 1 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/boat-iyad-sigma1/.
mv ./mags.png outputs/boat-iyad-sigma1/.
mv ./Gx.png outputs/boat-iyad-sigma1/.
mv ./Gy.png outputs/boat-iyad-sigma1/.
mv ./ImNoisy.png outputs/boat-iyad-sigma1/.
mv ./ImDiff.png outputs/boat-iyad-sigma1/.
mv ./ImDenoised.png outputs/boat-iyad-sigma1/.
mv ./ImBasic.png outputs/boat-iyad-sigma1/.
mv ./measures.txt outputs/boat-iyad-sigma1/.

./BM3Ddenoising boat.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/boat-iyad-sigma10/.
mv ./mags.png outputs/boat-iyad-sigma10/.
mv ./Gx.png outputs/boat-iyad-sigma10/.
mv ./Gy.png outputs/boat-iyad-sigma10/.
mv ./ImNoisy.png outputs/boat-iyad-sigma10/.
mv ./ImDiff.png outputs/boat-iyad-sigma10/.
mv ./ImDenoised.png outputs/boat-iyad-sigma10/.
mv ./ImBasic.png outputs/boat-iyad-sigma10/.
mv ./measures.txt outputs/boat-iyad-sigma10/.

./BM3Ddenoising boat.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/boat-iyad-sigma30/.
mv ./mags.png outputs/boat-iyad-sigma30/.
mv ./Gx.png outputs/boat-iyad-sigma30/.
mv ./Gy.png outputs/boat-iyad-sigma30/.
mv ./ImNoisy.png outputs/boat-iyad-sigma30/.
mv ./ImDiff.png outputs/boat-iyad-sigma30/.
mv ./ImDenoised.png outputs/boat-iyad-sigma30/.
mv ./ImBasic.png outputs/boat-iyad-sigma30/.
mv ./measures.txt outputs/boat-iyad-sigma30/.