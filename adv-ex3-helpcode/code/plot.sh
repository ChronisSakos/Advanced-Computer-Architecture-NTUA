#!/bin/bash


ACA_PATH=~/Projects/advcomparch
PAR_PATH=${ACA_PATH}/parsec-3.0       

WRK_PATH=${PAR_PATH}/adv-ex3-helpcode
OUT_PATH=${WRK_PATH}/outputs

# Benchmark array
declare -a BenchArray=(
        "gcc"
        "mcf"
        "zeusmp"
        "cactusADM"
        "gobmk"
        "sjeng"
        "GemsFDTD"
        )

# Loop through the available benchmarks & create the graphs
for bench in "${BenchArray[@]}"; do
    python area_mcpat.py ${OUT_PATH}/${bench}/${bench}*
done


