#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark

### PARSEC.SWAPTIONS ###
#SIMSMALL="-ns 16 -sm 10000"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/pkgs/apps/swaptions/inst/amd64-linux.gcc/bin/swaptions" --options="$SIMSMALL -nt $N_THREADS"

# 8x8
SIMSMALL="-ns 256 -sm 10000"  # 256 = 64 * 4
build/$1/gem5.opt --outdir=swaptions-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/apps/swaptions/inst/amd64-linux.gcc/bin/swaptions" --options="$SIMSMALL -nt 64"
