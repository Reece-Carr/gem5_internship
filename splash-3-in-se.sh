#!/bin/bash

# Set up pasths for Splash 3 benchmarks
BASE_PATH="/home/theo/Splash-3/codes"
declare -A BENCHMARK_PATHS
BENCHMARK_PATHS["BARNES"]="${BASE_PATH}/apps/barnes"
BENCHMARK_PATHS["FMM"]="${BASE_PATH}/apps/fmm"
BENCHMARK_PATHS["OCEAN"]="${BASE_PATH}/apps/ocean/non_contiguous_partitions"
BENCHMARK_PATHS["RADIOSITY"]="${BASE_PATH}/apps/radiosity"
BENCHMARK_PATHS["RAYTRACE"]="${BASE_PATH}/apps/raytrace"
BENCHMARK_PATHS["VOLREND"]="${BASE_PATH}/apps/volrend"
BENCHMARK_PATHS["WATER-NSQUARED"]="${BASE_PATH}/apps/water-nsquared"
BENCHMARK_PATHS["WATER_SPATIAL"]="${BASE_PATH}/apps/water-spatial"
BENCHMARK_PATHS["CHOLESKY"]="${BASE_PATH}/kernels/cholesky"
BENCHMARK_PATHS["FFT"]="${BASE_PATH}/kernels/fft"
BENCHMARK_PATHS["LU"]="${BASE_PATH}/kernels/LU"
BENCHMARK_PATHS["RADIX"]="${BASE_PATH}/kernels/radix"


# Set up options for Splash 3 benchmarks
N_THREADS=4
declare -A BENCHMARK_OPTS
BENCHMARK_OPTS["BARNES"]="< ${BENCHMARK_PATHS["BARNES"]}/inputs/n16384-p4"
BENCHMARK_OPTS["FMM"]="< ${BENCHMARK_PATHS["FMM"]}/inputs/inputs/input.4.16384"
BENCHMARK_OPTS["OCEAN"]="-p${N_THREADS} -n18"
BENCHMARK_OPTS["RADIOSITY"]="-p 4 -ae 5000 -bf 0.1 -en 0.05 -room -batch"
BENCHMARK_OPTS["RAYTRACE"]="-p${N_THREADS} -m64 ${BENCHMARK_PATHS["RAYTRACE"]}/inputs/car.env"
BENCHMARK_OPTS["VOLREND"]="${N_THREADS} ${BENCHMARK_PATHS["VOLREND"]}/inputs/head 8"
BENCHMARK_OPTS["WATER-NSQUARED"]="< ${BENCHMARK_PATHS["WATER-NSQUARED"]}/inputs/n512-p4"
BENCHMARK_OPTS["WATER-SPATIAL"]="< ${BENCHMARK_PATHS["WATER-SPATIAL"]}/inputs/n512-p4"
BENCHMARK_OPTS["CHOLESKY"]="-p4 < ${BENCHMARK_PATHS["CHOLESKY"]}/inputs/tk15.o"
BENCHMARK_OPTS["FFT"]="-p4 -m16"
BENCHMARK_OPTS["LU"]="-p4 -n512"
BENCHMARK_OPTS["RADIX"]="-p4 -n1048576"

echo "Finished set up."

# Run the benchmarks 
OUT_FILE_NAME=${1}_BENCHMARK_RESULTS
echo "" > $OUT_FILE_NAME
#for BENCHMARK in "OCEAN" ; do
for BENCHMARK in "BARNES" "FMM" "OCEAN" "RADIOSITY" "RAYTRACE" "VOLREND" "WATER-NSQUARED" "WATER-SPATIAL" "CHOLESKY" "FFT" "LU" "RADIX" ; do
    echo "Starting benchmark $BENCHMARK."
    #build/$1/gem5.opt --debug-flags=RubySystem configs/example/se.py -n $((N_THREADS+1)) --ruby --cmd="${BENCHMARK_PATHS[$BENCHMARK]}/$BENCHMARK" --options="${BENCHMARK_OPTS[$BENCHMARK]}"
    #build/$1/gem5.opt --debug-flags=ProtocolTrace configs/example/se.py -n $((N_THREADS+1)) --ruby --cmd="${BENCHMARK_PATHS[$BENCHMARK]}/$BENCHMARK" --options="${BENCHMARK_OPTS[$BENCHMARK]}" > why
    build/$1/gem5.opt configs/example/se.py -n $((N_THREADS+1)) --ruby --cmd="${BENCHMARK_PATHS[$BENCHMARK]}/$BENCHMARK" --options="${BENCHMARK_OPTS[$BENCHMARK]}"
done
