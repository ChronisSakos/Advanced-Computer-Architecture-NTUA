#!/bin/bash

## Example of usage: ./run_sniper.sh gcc

MCPAT_EXE=/home/chronis/sniper-7.3/tools/advcomparch_mcpat.py
INPUT_DIR="/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex3-helpcode/outputs/finished"
OUTPUT_DIR_BASE="/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex3-helpcode/outputs"
POW=power
POW_EXE=power.total.out
	
for dw in 1 2 4 8 16 32; do
for ws in 16 32 64 96 128 192 256 384; do
	outDir=$(printf "%s.DW_%02d-WS_%03d.out" $@ $dw $ws)
	outDir="${INPUT_DIR}/$@/${outDir}"

	sniper_cmd="${MCPAT_EXE} -d ${outDir} -t total -o ${outDir}/${POW} > ${outDir}/${POW_EXE}"
	echo \"$sniper_cmd\"
	/bin/bash -c "$sniper_cmd"
done
done


