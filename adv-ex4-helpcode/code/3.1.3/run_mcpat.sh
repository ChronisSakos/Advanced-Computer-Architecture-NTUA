#!/bin/bash

## Example of usage: ./run_sniper.sh MUTEX

MCPAT_EXE=/home/chronis/sniper-7.3/tools/advcomparch_mcpat.py
INPUT_DIR="/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.1"
OUTPUT_DIR_BASE="/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.2"
POW=power
POW_EXE=power.total.out

for thr in 1 2 4 8 16; do
for gr in 1 10 100; do
	outDir=$(printf "GRAIN_%d.threads_%02d-%s" $gr $thr $@)

	outDir2=$(printf "GRAIN_%d" $gr) 
	outDir="${INPUT_DIR}/${outDir2}/${outDir}"
	sniper_cmd="${MCPAT_EXE} -d ${outDir} -t total -o ${outDir}/${POW} > ${outDir}/${POW_EXE}"
	echo \"$sniper_cmd\"
	/bin/bash -c "$sniper_cmd"
done
done


