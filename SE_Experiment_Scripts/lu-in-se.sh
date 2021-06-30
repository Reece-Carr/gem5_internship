#!/bin/bash

P_PATH=/home/theo/parsec-benchmark

### SPLASH2X.LU_CB ###
SIMSMALL="-n512 -b16"
#build/$1/gem5.opt configs/example/se.py --num-cpus=64 --num-dirs=64 --network=garnet2.0 --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/kernels/lu_cb/inst/amd64-linux.gcc/bin/lu_cb" --options="$SIMSMALL -p63"
./../build/$1/gem5.opt --outdir=./../Experiment_Results/$1/lu-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=garnet2.0 --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/ext/splash2x/kernels/lu_cb/inst/amd64-linux.gcc/bin/lu_cb" --options="$SIMSMALL -p64"
