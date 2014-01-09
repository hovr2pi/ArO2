#!/bin/bash
#SBATCH -J MCSCF                   # job name
#SBATCH -o slurm.o%j       # output and error file name (%j expands to jobID)
#SBATCH -n 1           # total number of mpi tasks requested
#SBATCH -N 1         # total number of nodes
#SBATCH -p normal # queue (partition) -- normal, development, etc.
#SBATCH -t 24:00:00        # run time (hh:mm:ss) - 1.5 hours
#SBATCH -A A-cmkv11 

#set -x


LD_LIBRARY_PATH=/opt/apps/intel/13/composer_xe_2013.2.146/mkl/lib/intel64:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/intel64/:$LD_LIBRARY_PATH

# lets do this on $SCRATCH

WORKDIR=$SCRATCH/ArO2
mkdir -p $WORKDIR && cd $WORKDIR

cp -r $WORK/repos/ArO2/calcs/* .
cp -r $WORK/projects/ArO2/geoms .

for i in `seq -w 00001 02159`
do
	./mcscf_stampede.sh $i
done

