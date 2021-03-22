#!/bin/bash

make
./BM3Ddenoising lena.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./ImDenoised.png alphas/sigma30/ImDenoised-alpha100.png
mv ./measures.txt alphas/sigma30/measures-alpha100.txt

./BM3Ddenoising lena.png 40 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./ImDenoised.png alphas/sigma40/ImDenoised-alpha100.png
mv ./measures.txt alphas/sigma40/measures-alpha100.txt

./BM3Ddenoising lena.png 60 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./ImDenoised.png alphas/sigma60/ImDenoised-alpha100.png
mv ./measures.txt alphas/sigma60/measures-alpha100.txt

./BM3Ddenoising lena.png 80 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./ImDenoised.png alphas/sigma80/ImDenoised-alpha100.png
mv ./measures.txt alphas/sigma80/measures-alpha100.txt

./BM3Ddenoising lena.png 100 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp
mv ./ImDenoised.png alphas/sigma100/ImDenoised-alpha100.png
mv ./measures.txt alphas/sigma100/measures-alpha100.txt