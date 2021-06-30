import sys
dir = sys.argv[1]
bench = sys.argv[2]
size = sys.argv[3]
n = sys.argv[4] # number of threads
"""
This method creates a script in dir which will be eventually
passed to the simulated system (to run a specific benchmark
at bootup).
"""
file_name = '{}/run_{}_{}_{}'.format(dir, bench, size, n)
bench_file = open(file_name, 'w+')
bench_file.write('cd /home/gem5/parsec-benchmark\n')
bench_file.write('source env.sh\n')
bench_file.write('parsecmgmt -a run -p \
        {} -c gcc-hooks -i {} -n {}\n'.format(bench, size, n))

# sleeping for sometime makes sure
# that the benchmark's output has been
# printed to the console
bench_file.write('sleep 5 \n')
bench_file.write('m5 exit \n')
bench_file.close()
