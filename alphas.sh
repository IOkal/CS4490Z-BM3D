#!/bin/bash

make

echo "" > alpha-outputs.txt

for i in `seq 0 0.1 1`
    do
        # let alpha=${i}/100
        echo "alpha=${i}" >> alpha-outputs.txt
        
        ./BM3Ddenoising lena.png 30 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp ${i}
        echo "sigma=30" >> alpha-outputs.txt
        sed -n '6p' measures.txt >> alpha-outputs.txt

        # ./BM3Ddenoising lena.png 40 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp ${i}
        # echo "sigma=40" >> alpha-outputs.txt
        # sed -n '6p' measures.txt >> alpha-outputs.txt

        # ./BM3Ddenoising lena.png 60 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp ${i}
        # echo "sigma=60" >> alpha-outputs.txt
        # sed -n '6p' measures.txt >> alpha-outputs.txt

        # ./BM3Ddenoising lena.png 80 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp ${i}
        # echo "sigma=80" >> alpha-outputs.txt
        # sed -n '6p' measures.txt >> alpha-outputs.txt

        # ./BM3Ddenoising lena.png 100 ImNoisy.png ImBasic.png ImDenoised.png ImDiff.png ImBias.png ImDiffBias.png 0 dct 1 bior 1 opp ${i}
        # echo "sigma=100" >> alpha-outputs.txt
        # sed -n '6p' measures.txt >> alpha-outputs.txt

        # mv ./measures.txt alphas/sigma100/measures-alpha${i}.txt
done
