#!/bin/bash

N_THREADS=4
SIMSMALL="-n514 -e1e-07 -r20000 -t28800"
P_PATH=/home/theo/parsec-benchmark

### SPLASH2X.OCEAN_CP ###
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/ext/splash2x/apps/ocean_cp/inst/amd64-linux.gcc/bin/ocean_cp" --options="$SIMSMALL -p$N_THREADS"

# 8x8
build/$1/gem5.opt --outdir=ocean-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/apps/ocean_cp/inst/amd64-linux.gcc/bin/ocean_cp" --options="$SIMSMALL -p64"
