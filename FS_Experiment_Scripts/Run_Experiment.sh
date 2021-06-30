PR=$1
WL=$2
N=$3
R=$4
SIZE=$5
nice ./../build/${PR}/gem5.opt --outdir=./../Experiment_Results/${PR}/${WL}_${N}_${R}_${SIZE}_results ../configs/example/fs.py --ruby --cpu-type TimingSimpleCPU --kernel=/home/theo/gem5_copy/full_system_images/binaries/x86_64-vmlinux-5.4.49 --disk=/home/theo/gem5_copy/full_system_images/disks/parsec --num-cpus=$N --num-dirs=$N --network=garnet2.0 --topology=Mesh_XY --mesh-rows=$R --script=./Backend_Scripts/run_${WL}_${SIZE}_${N}
