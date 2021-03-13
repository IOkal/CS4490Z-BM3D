#!/bin/bash

rm -r outputs/peppers-iyad-sigma1/*
rm -r outputs/peppers-iyad-sigma10/*
rm -r outputs/peppers-iyad-sigma30/*
rm -r outputs/peppers-iyad-sigma0/*

make

./BM3Ddenoising peppers.png 0 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/peppers-iyad-sigma0/.
mv ./mags.png outputs/peppers-iyad-sigma0/.
mv ./Gx.png outputs/peppers-iyad-sigma0/.
mv ./Gy.png outputs/peppers-iyad-sigma0/.
mv ./ImNoisy.png outputs/peppers-iyad-sigma0/.
mv ./ImDiff.png outputs/peppers-iyad-sigma0/.
mv ./ImDenoised.png outputs/peppers-iyad-sigma0/.
mv ./ImBasic.png outputs/peppers-iyad-sigma0/.
mv ./measures.txt outputs/peppers-iyad-sigma0/.

./BM3Ddenoising peppers.png 1 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/peppers-iyad-sigma1/.
mv ./mags.png outputs/peppers-iyad-sigma1/.
mv ./Gx.png outputs/peppers-iyad-sigma1/.
mv ./Gy.png outputs/peppers-iyad-sigma1/.
mv ./ImNoisy.png outputs/peppers-iyad-sigma1/.
mv ./ImDiff.png outputs/peppers-iyad-sigma1/.
mv ./ImDenoised.png outputs/peppers-iyad-sigma1/.
mv ./ImBasic.png outputs/peppers-iyad-sigma1/.
mv ./measures.txt outputs/peppers-iyad-sigma1/.

./BM3Ddenoising peppers.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/peppers-iyad-sigma10/.
mv ./mags.png outputs/peppers-iyad-sigma10/.
mv ./Gx.png outputs/peppers-iyad-sigma10/.
mv ./Gy.png outputs/peppers-iyad-sigma10/.
mv ./ImNoisy.png outputs/peppers-iyad-sigma10/.
mv ./ImDiff.png outputs/peppers-iyad-sigma10/.
mv ./ImDenoised.png outputs/peppers-iyad-sigma10/.
mv ./ImBasic.png outputs/peppers-iyad-sigma10/.
mv ./measures.txt outputs/peppers-iyad-sigma10/.

./BM3Ddenoising peppers.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/peppers-iyad-sigma30/.
mv ./mags.png outputs/peppers-iyad-sigma30/.
mv ./Gx.png outputs/peppers-iyad-sigma30/.
mv ./Gy.png outputs/peppers-iyad-sigma30/.
mv ./ImNoisy.png outputs/peppers-iyad-sigma30/.
mv ./ImDiff.png outputs/peppers-iyad-sigma30/.
mv ./ImDenoised.png outputs/peppers-iyad-sigma30/.
mv ./ImBasic.png outputs/peppers-iyad-sigma30/.
mv ./measures.txt outputs/peppers-iyad-sigma30/.    