#!/bin/bash

N_THREADS=4
P_PATH=/home/theo/parsec-benchmark
SIMSMALL="5 $P_PATH/pkgs/apps/fluidanimate/run/in_35K.fluid $P_PATH/pkgs/apps/fluidanimate/run/out.fluid"

### SPLASH2X.LU_CB ###
#build/$1/gem5.opt configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$P_PATH/pkgs/apps/fluidanimate/inst/amd64-linux.gcc/bin/fluidanimate" --options="$N_THREADS $SIMSMALL"

build/$1/gem5.opt --outdir=fluidanimate-se-$1 configs/example/se.py --num-cpus=64 --num-dirs=64 --network=simple --topology=Mesh_XY --mesh-rows=8 --cpu-type TimingSimpleCPU --ruby --cmd="$P_PATH/pkgs/apps/fluidanimate/inst/amd64-linux.gcc/bin/fluidanimate" --options="64 $SIMSMALL"
