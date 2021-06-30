#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark

### SPLASH2X.LU_CB ###
SIMSMALL="-c -p -v -i $P_PATH/pkgs/kernels/dedup/run/media.dat -o $P_PATH/pkgs/kernels/dedup/run/output.dat.ddp"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/pkgs/kernels/dedup/inst/amd64-linux.gcc-pthreads/bin/dedup" --options="$SIMSMALL -t$N_THREADS"

# 8x8
build/$1/gem5.opt --outdir=dedup-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/kernels/dedup/inst/amd64-linux.gcc/bin/dedup" --options="$SIMSMALL -t64"
