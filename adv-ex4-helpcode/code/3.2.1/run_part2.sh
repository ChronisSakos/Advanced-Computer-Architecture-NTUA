#change the following paths:

SNIPER_EXE=/home/chronis/sniper-7.3/run-sniper
SNIPER_CONFIG=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/ask4.cfg
OUTPUT_DIR_BASE=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs
LOCKS_DIR=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/locks

MODE=MUTEX

declare -a grainsizes=(1)


#(ncores l2_shared_cores l3_shared_cores) 
#declare -a comb=(4 1 4 4 "shareall")
#declare -a comb=(4 1 1 4 "sharel3")
declare -a comb=(4 1 1 1 "sharenothing") 

	for GRAINSIZE in "${grainsizes[@]}";do
		NCORES="${comb[0]}"
		NTHREADS="${comb[0]}"	
		L1_ICACHE="${comb[1]}"
		L1_DCACHE="${comb[1]}"			
		L2_CORES="${comb[2]}"	
		L3_CORES="${comb[3]}"
		NAME="${comb[4]}"
		
			echo "-------------------------------"		
			echo "number of threads:${NTHREADS}"
			echo "grainsize:${GRAINSIZE}"
			echo "number of cores:${NCORES}"		
			echo "L1 I cores:${L1_ICACHE}"
			echo "L1 D cores:${L1_DCACHE}"
			echo "L2 cores:${L2_CORES}"		
			echo "L3 cores:${L3_CORES}"		
			echo "-------------------------------"		
			echo

                        COMB2_OUTDIR=$(printf "%s.%s" $NAME $MODE)   
			OUTDIR="${OUTPUT_DIR_BASE}/3.2.1/grain1.${COMB2_OUTDIR}"
			CMD="${SNIPER_EXE} -c ${SNIPER_CONFIG} -n $NCORES -d ${OUTDIR} --roi -g --perf_model/l1_icache/shared_cores=$L1_ICACHE -g --perf_model/l1_dcache/shared_cores=$L1_DCACHE -g --perf_model/l2_cache/shared_cores=$L2_CORES -g --perf_model/l3_cache/shared_cores=$L3_CORES -- ${LOCKS_DIR} $NTHREADS 1000 $GRAINSIZE"
			echo "${CMD}"
			/bin/bash -c "$CMD"
		
		
	done


