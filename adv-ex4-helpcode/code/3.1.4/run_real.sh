#change the following paths:

SNIPER_EXE=/home/chronis/sniper-7.3/run-sniper
SNIPER_CONFIG=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/ask4.cfg
OUTPUT_DIR_BASE=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs
LOCKS_DIR=/home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/locks
MAKE_DIR=home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode


declare -a modes=(TAS_CAS TAS_TS TTAS_CAS TTAS_TS MUTEX)
declare -a grainsizes=(1 10 100)
declare -a nthreads=(1 2)

mkdir /home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.1.4

for MODE in "${modes[@]}";do

mkfile_mode="-D${MODE}"
sed_cmd="sed -i '8s/.*/LFLAG ?= ${mkfile_mode} /' ${MAKE_DIR}/Makefile"
/bin/bash -c "${sed_cmd}"
/bin/bash -c "make clean;"
/bin/bash -c "make;"

echo ${MODE} >> ${OUTPUT_DIR_BASE}/3.1.4/GRAIN_${GRAINSIZE}/real_system_times.txt

	for GRAINSIZE in "${grainsizes[@]}";do
		mkdir /home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.1.4/GRAIN_${GRAINSIZE}
		for n in "${nthreads[@]}"; do
			COMB2_OUTDIR=$(printf "GRAIN_%d.threads_%02d-%s" $GRAINSIZE $n $MODE) 
			mkdir /home/chronis/Projects/advcomparch/parsec-3.0/adv-ex4-helpcode/outputs/3.1.4/GRAIN_${GRAINSIZE}/${COMB2_OUTDIR}
			NTHREADS="${n}"		
			CMD="${LOCKS_DIR} $NTHREADS 60000000 $GRAINSIZE"
			echo "${CMD}"
			echo "-------------------------------"		
			echo "number of threads:${NTHREADS}"
			echo "grainsize:${GRAINSIZE}"		
			echo "-------------------------------"
			  
			OUTDIR="${OUTPUT_DIR_BASE}/3.1.4/GRAIN_${GRAINSIZE}/${COMB2_OUTDIR}"
			/bin/bash -c "${CMD} >> ${OUTDIR}/real_system_times.txt" 
		done
		
	done
done


