#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark
SIMSMALL="10 20 32 4096 4096 1000 none $P_PATH/pkgs/kernels/streamcluster/run/output.txt"

### SPLASH2X.LU_CB ###
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/pkgs/kernels/streamcluster/inst/amd64-linux.gcc/bin/streamcluster" --options="$SIMSMALL $N_THREADS"

# 8x8
#build/$1/gem5.opt configs/example/se.py --num-cpus=64 --num-dirs=64 --network=garnet2.0 --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/kernels/streamcluster/inst/amd64-linux.gcc/bin/streamcluster" --options="$SIMSMALL 63"
build/$1/gem5.opt --outdir=streamcluster-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/kernels/streamcluster/inst/amd64-linux.gcc/bin/streamcluster" --options="$SIMSMALL 64"
