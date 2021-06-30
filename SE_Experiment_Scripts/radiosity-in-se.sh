#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark
SIMSMALL="-bf 1.5e-1 -batch -room"

### SPLASH2X.OCEAN_CP ###
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/ext/splash2x/apps/radiosity/inst/amd64-linux.gcc/bin/radiosity" --options="$SIMSMALL -p $N_THREADS"

# 8x8
#build/$1/gem5.opt configs/example/se.py --num-cpus=64 --num-dirs=64 --network=garnet2.0 --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/apps/radiosity/inst/amd64-linux.gcc/bin/radiosity" --options="$SIMSMALL -p 63"
../build/$1/gem5.opt --outdir=../Experiment_Results/$1/radiosity-se-$1 ../configs/example/se.py --mem-size="4096MB" --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/apps/radiosity/inst/amd64-linux.gcc/bin/radiosity" --options="$SIMSMALL -p 64"
