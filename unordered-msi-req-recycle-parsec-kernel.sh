WL=$1
N=$2
R=$3
SIZE=$4
nice ./build/MSI_UNORDERED_REQUESTOR_ACKS_2/gem5.opt --outdir=unord_msi_req_${WL}_results configs/example/fs.py --ruby --cpu-type X86KvmCPU --kernel=/home/theo/gem5_copy/full_system_images/binaries/x86_64-vmlinux-5.4.49 --disk=/home/theo/gem5_copy/full_system_images/disks/parsec --num-cpus=$N --num-dirs=$N --network=garnet2.0 --topology=Mesh_XY --mesh-rows=$R --script=/home/theo/gem5_copy/run_${WL}_${SIZE}_${N}
