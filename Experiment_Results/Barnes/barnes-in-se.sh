#!/bin/bash

N_THREADS=4
P_PATH=/home/theo/parsec-benchmark

### PARSEC.SWAPTIONS ###
#SIMSMALL="-ns 16 -sm 10000"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/ext/splash2x/apps/barnes/inst/amd64-linux.gcc/bin/barnes" --options="$SIMSMALL -nt $N_THREADS"

# 8x8
SIMSMALL="$P_PATH/ext/splash2x/apps/barnes/run/input_64"
build/$1/gem5.opt --outdir=barnes-se-$1 configs/example/se.py --mem-size="4096MB" --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/apps/barnes/inst/amd64-linux.gcc/bin/barnes" --options="64" < $SIMSMALL 
