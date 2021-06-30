#!/bin/bash

N_THREADS=4
P_PATH=~/parsec-benchmark

### SPLASH2X.RADIX ###
SIMSMALL="-r4096 -n4194304 -m214748364"
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/ext/splash2x/kernels/radix/inst/amd64-linux.gcc/bin/radix" --options="-p$N_THREADS $SIMSMALL"
../build/$1/gem5.opt --outdir=../Experiment_Results/$1/radix-se-$1 ../configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/kernels/radix/inst/amd64-linux.gcc/bin/radix" --options="-p64 $SIMSMALL"
