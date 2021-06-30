WL=$1
N=$2
R=$3
SIZE=$4
nice ./build/MESI_TWO_LEVEL/gem5.opt configs/example/fs.py --ruby --cpu-type X86KvmCPU --kernel=/home/theo/gem5_copy/full_system_images/binaries/x86_64-vmlinux-5.4.49 --disk=/home/theo/gem5_copy/full_system_images/disks/parsec --num-cpus=$N --script=/home/theo/gem5_copy/run_${WL}_${SIZE}_${N}
