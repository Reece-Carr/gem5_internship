#!/bin/bash

N_THREADS=4
PATH=~/parsec-benchmark

### SPLASH2X.LU_CB ###
/home/theo/parsec-benchmark/pkgs/apps/ferret/inst/amd64-linux.gcc-pthreads/bin/ferret corel lsh queries 10 20 6 output.txt
SIMSMALL="$PATH/pkgs/apps/ferret/run/corel lsh $PATH/pkgs/apps/ferret/run/queries 10 20"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$PATH/pkgs/apps/ferret/inst/amd64-linux.gcc-pthreads/bin/ferret" --options="$SIMSMALL $N_THREADS $PATH/pkgs/apps/ferret/run/output.txt"

# 8x8
../build/$1/gem5.opt --outdir=../Experiment_Results/$1/ferret-se-$1 ../configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$PATH/pkgs/apps/ferret/inst/amd64-linux.gcc/bin/ferret" --options="$SIMSMALL 64 $PATH/pkgs/apps/ferret/run/output.txt"
