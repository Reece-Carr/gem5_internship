#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark

### SPLASH2X.LU_CB ###
SIMSMALL="$P_PATH/pkgs/apps/blackscholes/run/in_4K.txt $P_PATH/pkgs/apps/blackscholes/run/prices.txt"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/pkgs/apps/blackscholes/inst/amd64-linux.gcc/bin/blackscholes" --options="$N_THREADS $SIMSMALL"

# 8x8
build/$1/gem5.opt --outdir=blackscholes-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/apps/blackscholes/inst/amd64-linux.gcc/bin/blackscholes" --options="64 $SIMSMALL"
