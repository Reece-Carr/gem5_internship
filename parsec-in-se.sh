#!/bin/bash

N_THREADS=4
PATH=/home/theo/parsec-benchmark
#build/$1/gem5.opt configs/example/se.py -n $((N_THREADS+1)) --ruby --cmd="cd $PATH ; bash env.sh ; parsecmgmt -a run -p blackscholes -c gcc-hooks -i simsmall -n 4"
#build/$1/gem5.opt configs/example/se.py -n $((N_THREADS+1)) --ruby --cmd="/bin/bash" --options="$PATH/bin/parsecmgmt -a run -p ferret -c gcc-hooks -i simsmall -n 4"
#build/$1/gem5.opt configs/example/se.py -n $((N_THREADS+1)) --ruby --cmd="cd $PATH ; bash env.sh"

# ferret
#build/$1/gem5.opt configs/example/se.py -n 5 --ruby --cmd="$PATH/pkgs/apps/ferret/inst/amd64-linux.gcc-hooks/bin/ferret" --options="corel lsh queries 10 20 4 output.txt"
#build/$1/gem5.opt configs/example/se.py -n 5 --ruby --cmd="$PATH/pkgs/apps/ferret/inst/amd64-linux.gcc-pthreads/bin/ferret" --options="$PATH/pkgs/apps/ferret/run/corel lsh $PATH/pkgs/apps/ferret/run/queries 10 20 4 output.txt"
#build/$1/gem5.opt configs/example/se.py -n 5 --ruby --cmd="$PATH/pkgs/apps/ferret/inst/amd64-linux.gcc-pthreads/bin/ferret" --options="$PATH/pkgs/apps/ferret/run/corel lsh $PATH/pkgs/apps/ferret/run/queries 5 5 4 output.txt"
#echo "$PATH/ext/splash2x/kernels/cholesky/run/tk14.O"
#build/$1/gem5.opt configs/example/se.py -n 5 --ruby --cmd="$PATH/ext/splash2x/kernels/cholesky/inst/amd64-linux.gcc-pthreads/bin/cholesky" --options="-p4 < $PATH/ext/splash2x/kernels/cholesky/run/tk14.O"

### SPLASH2X.FFT ###
SIMSMALL="-m20"
build/$1/gem5.opt configs/example/se.py -n 5 --ruby --cmd="$PATH/ext/splash2x/kernels/fft/inst/amd64-linux.gcc-pthreads/bin/fft" --options="$SIMSMALL -p4"

#
## freqmine
#export OMP_NUM_THREADS=${N_THREADS}
#build/$1/gem5.opt configs/example/se.py -n 5 --ruby --cmd="$PATH/pkgs/apps/freqmine/inst/amd64-linux.gcc-hooks/bin/freqmine" --options="kosarak_250k.dat 220"
