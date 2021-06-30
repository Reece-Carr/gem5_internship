#!/bin/bash

P_PATH=/home/theo/parsec-benchmark

### SPLASH2X.FFT ###
SIMSMALL="-m20"
build/$1/gem5.opt --outdir=fft-se-$1 configs/example/se.py --num-cpus=4 --num-dirs=4 --ruby --network=garnet2.0 --topology=Mesh_XY --mesh-rows=2 --cpu-type TimingSimpleCPU --cmd="$P_PATH/ext/splash2x/kernels/fft/inst/amd64-linux.gcc/bin/fft" --options="$SIMSMALL -p4"
