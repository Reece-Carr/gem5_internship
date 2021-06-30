#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark

### PARSEC.SWAPTIONS ###
#SIMSMALL="-ns 16 -sm 10000"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/ext/splash2x/apps/water_spatial/inst/amd64-linux.gcc/bin/water_spatial" --options="$SIMSMALL -nt $N_THREADS"

# 8x8
SIMSMALL="$P_PATH/ext/splash2x/apps/water_spatial/run/input_64"
build/$1/gem5.opt --outdir=water_spatial-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/apps/water_spatial/inst/amd64-linux.gcc/bin/water_spatial" --options="64" < $SIMSMALL 
