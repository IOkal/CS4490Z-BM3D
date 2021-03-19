#!/bin/bash

rm -r outputs/goldhill-iyad-sigma1/*
rm -r outputs/goldhill-iyad-sigma10/*
rm -r outputs/goldhill-iyad-sigma30/*
rm -r outputs/goldhill-iyad-sigma0/*

make

./BM3Ddenoising goldhill.png 0 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/goldhill-iyad-sigma0/.
mv ./mags.png outputs/goldhill-iyad-sigma0/.
mv ./Gx.png outputs/goldhill-iyad-sigma0/.
mv ./Gy.png outputs/goldhill-iyad-sigma0/.

./BM3Ddenoising goldhill.png 1 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/goldhill-iyad-sigma1/.
mv ./mags.png outputs/goldhill-iyad-sigma1/.
mv ./Gx.png outputs/goldhill-iyad-sigma1/.
mv ./Gy.png outputs/goldhill-iyad-sigma1/.
mv ./ImNoisy.png outputs/goldhill-iyad-sigma1/.
mv ./ImDiff.png outputs/goldhill-iyad-sigma1/.
mv ./ImDenoised.png outputs/goldhill-iyad-sigma1/.
mv ./ImBasic.png outputs/goldhill-iyad-sigma1/.
mv ./measures.txt outputs/goldhill-iyad-sigma1/.

./BM3Ddenoising goldhill.png 10 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/goldhill-iyad-sigma10/.
mv ./mags.png outputs/goldhill-iyad-sigma10/.
mv ./Gx.png outputs/goldhill-iyad-sigma10/.
mv ./Gy.png outputs/goldhill-iyad-sigma10/.
mv ./ImNoisy.png outputs/goldhill-iyad-sigma10/.
mv ./ImDiff.png outputs/goldhill-iyad-sigma10/.
mv ./ImDenoised.png outputs/goldhill-iyad-sigma10/.
mv ./ImBasic.png outputs/goldhill-iyad-sigma10/.
mv ./measures.txt outputs/goldhill-iyad-sigma10/.

./BM3Ddenoising goldhill.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./angs.png outputs/goldhill-iyad-sigma30/.
mv ./mags.png outputs/goldhill-iyad-sigma30/.
mv ./Gx.png outputs/goldhill-iyad-sigma30/.
mv ./Gy.png outputs/goldhill-iyad-sigma30/.
mv ./ImNoisy.png outputs/goldhill-iyad-sigma30/.
mv ./ImDiff.png outputs/goldhill-iyad-sigma30/.
mv ./ImDenoised.png outputs/goldhill-iyad-sigma30/.
mv ./ImBasic.png outputs/goldhill-iyad-sigma30/.
mv ./measures.txt outputs/goldhill-iyad-sigma30/.

cp goldhill.png outputs/goldhill-iyad-sigma0/.
cp goldhill.png outputs/goldhill-iyad-sigma1/.
cp goldhill.png outputs/goldhill-iyad-sigma10/.
cp goldhill.png outputs/goldhill-iyad-sigma30/.