#!/bin/bash

ACA_PATH=~/Projects/advcomparch
PAR_PATH=${ACA_PATH}/parsec-3.0       

WRK_PATH=${PAR_PATH}/adv-ex4-helpcode
OUT_PATH=${WRK_PATH}/outputs/3.1

# Benchmark array
declare -a grainsize=(
        "GRAIN_1"
        "GRAIN_10"
        "GRAIN_100"
        )        

# Loop through the available benchmarks & create the graphs
for grain in "${grainsize[@]}"; do
    python plot_mcpat.py ${OUT_PATH}/${grain}/${grain}*
done

