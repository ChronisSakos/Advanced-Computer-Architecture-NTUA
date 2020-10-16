#change the following paths:

SNIPER_EXE=/home/chronis/sniper-7.3/run-sniper
SNIPER_CONFIG=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/ask4.cfg
OUTPUT_DIR_BASE=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs
LOCKS_DIR=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/locks


declare -a grainsizes=(1 10 100)




#(ncores l2_shared_cores l3_shared_cores) 
declare -a comb=(1 1 1)
#declare -a comb=(2 2 2)
#declare -a comb=(4 4 4)
#declare -a comb=(8 4 8)
#declare -a comb=(16 1 8)


	for GRAINSIZE in "${grainsizes[@]}";do
		NCORES="${comb[0]}"
		NTHREADS="${comb[0]}"		
		L2_CORES="${comb[1]}"	
		L3_CORES="${comb[2]}"
			echo "-------------------------------"		
			echo "number of threads:${NTHREADS}"
			echo "grainsize:${GRAINSIZE}"	
			echo "-------------------------------"		
			echo

                        COMB2_OUTDIR=$(printf "GRAIN_%d.threads_%02d-%s" $GRAINSIZE $NTHREADS $MODE)   
			OUTDIR="${OUTPUT_DIR_BASE}/3.2/GRAIN_${GRAINSIZE}/${COMB2_OUTDIR}"
			CMD="${SNIPER_EXE} -c ${SNIPER_CONFIG} -n $NCORES -d ${OUTDIR} --roi -g --perf_model/l2_cache/shared_cores=$L2_CORES -g --perf_model/l3_cache/shared_cores=$L3_CORES -- ${LOCKS_DIR} $NTHREADS 1000 $GRAINSIZE"
			#CMD="${LOCKS_DIR} $NTHREADS 100000000 $GRAINSIZE"
			echo "${CMD}"
			/bin/bash -c "$CMD"
		
		
	done


