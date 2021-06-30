#!/bin/bash

N_THREADS=4
PATH=~/parsec-benchmark

### SPLASH2X.LU_CB ###
SIMSMALL="$PATH/pkgs/apps/bodytrack/run/sequenceB_1 4 1 1000 5 0"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$PATH/pkgs/apps/bodytrack/inst/amd64-linux.gcc-pthreads/bin/bodytrack" --options="$SIMSMALL $N_THREADS"

# 8x8
../build/$1/gem5.opt --outdir=../Experiment_Results/$1/bodytrack-se-$1 ../configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$PATH/pkgs/apps/bodytrack/inst/amd64-linux.gcc/bin/bodytrack" --options="$SIMSMALL 64"
