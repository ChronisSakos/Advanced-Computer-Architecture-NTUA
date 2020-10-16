#!/bin/bash

## Example of usage: ./run_sniper.sh MUTEX

MCPAT_EXE=/home/chronis/sniper-7.3/tools/advcomparch_mcpat.py
INPUT_DIR="/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.2.1"
OUTPUT_DIR_BASE="/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.2"
POW=power
POW_EXE=power.total.out

declare -a topology=(
        "shareall"
        "sharel3"
        "sharenothing"
        )        
declare -a benchmark=(
	"MUTEX"
	"TAS_CAS"
	"TAS_TS"
	"TTAS_CAS"
	"TTAS_TS"
	)        

# Loop through the available benchmarks & create the graphs
for share in "${topology[@]}"; do
for bench in "${benchmark[@]}"; do
	outDir=$(printf "grain1.%s.%s" $share $bench)

	outDir="${INPUT_DIR}/${outDir}"
	sniper_cmd="${MCPAT_EXE} -d ${outDir} -t total -o ${outDir}/${POW} > ${outDir}/${POW_EXE}"
	echo \"$sniper_cmd\"
	/bin/bash -c "$sniper_cmd"
done
done


