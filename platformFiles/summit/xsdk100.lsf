#!/bin/bash
#BSUB -P csc314
#BSUB -W 2:00
#BSUB -nnodes 1
#BSUB -alloc_flags smt4
#BSUB -J xsdk100
#BSUB -o xsdk100o%J.txt
#BSUB -e xsdk100e%J.txt

projroot=/gpfs/alpine/csc314/scratch/$USER

SPACK_ROOT=${projroot}/xsdk100
export SPACK_ROOT
PATH=${PATH}:${SPACK_ROOT}/bin
export PATH
source ${SPACK_ROOT}/share/spack/setup-env.sh

module unload darshan-runtime
module unload spectrum-mpi
module unload xalt
module unload fftw
module unload xl
module load gcc/11.2

cd $SPACK_ROOT

# Using spack.yaml environment file
spack install > build_log_gcc112.out 2>&1
