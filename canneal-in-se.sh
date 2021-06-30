#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark
SIMSMALL="10000 2000 $P_PATH/pkgs/kernels/canneal/run/100000.nets 32"

### SPLASH2X.LU_CB ###
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/pkgs/kernels/canneal/inst/amd64-linux.gcc/bin/canneal" --options="$N_THREADS $SIMSMALL"

# 8x8
build/$1/gem5.opt --outdir=canneal-se-$1 configs/example/se.py --mem-size="4096MB" --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/kernels/canneal/inst/amd64-linux.gcc/bin/canneal" --options="64 $SIMSMALL"
