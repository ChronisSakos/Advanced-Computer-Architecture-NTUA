#!/bin/bash

ACA_PATH=~/Projects/advcomparch
PAR_PATH=${ACA_PATH}/parsec-3.0      


WRK_PATH=${PAR_PATH}/adv-ex4-helpcode
OUT_PATH=${WRK_PATH}/outputs/3.2.1

# Benchmark array
declare -a topology=(
        "grain1"
        )        

# Loop through the available benchmarks & create the graphs
for share in "${topology[@]}"; do
python mcpat2_plot.py ${OUT_PATH}/${share}*
done

