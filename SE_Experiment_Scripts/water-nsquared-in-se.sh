#!/bin/bash

N_THREADS=4
P_PATH=~/Documents/parsec-benchmark

### PARSEC.SWAPTIONS ###
#SIMSMALL="-ns 16 -sm 10000"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/ext/splash2x/apps/water_nsquared/inst/amd64-linux.gcc/bin/water_nsquared" --options="$SIMSMALL -nt $N_THREADS"

# 8x8
SIMSMALL="$P_PATH/ext/splash2x/apps/water_nsquared/run/input_64"
../build/$1/gem5.opt --outdir=../Experiment_Results/$1/water-nsquared-se-$1 ../configs/example/se.py --num-cpus=64 --num-dirs=64 --network=garnet2.0 --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/apps/water_nsquared/inst/amd64-linux.gcc/bin/water_nsquared" --options="64" < $SIMSMALL 
