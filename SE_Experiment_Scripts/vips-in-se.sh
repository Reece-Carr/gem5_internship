#!/bin/bash

N_THREADS=4
PATH=~/parsec-benchmark

### PARSEC.VIPS ###
SIMSMALL="$PATH/pkgs/apps/vips/run/im_benchmark $PATH/pkgs/apps/vips/run/pomegranate_1600x1200.v $PATH/pkgs/apps/vips/run/output.v"
# VIPS expects the number of threads in an environment variable
# TODO does this work with gem5?
export IM_CONCURRENCY=${NTHREADS}
../build/$1/gem5.opt --outdir=../Experiment_Results/$1/vips-se-$1 ../configs/example/se.py -n $(($N_THREADS+1)) --ruby --cmd="$PATH/pkgs/apps/vips/inst/amd64-linux.gcc-pthreads/bin/vips" --options="$SIMSMALL"
