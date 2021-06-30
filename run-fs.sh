# nice build/X86_MSI/gem5.opt --debug-flags=Ruby,ProtocolTrace configs/example/fs.py --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9.smp --disk=${M5_PATH}disks/linux-x86.img
# nice build/X86_MSI/gem5.opt --debug-flags=ProtocolTrace configs/example/fs.py --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9.smp --disk=${M5_PATH}disks/linux-x86.img
#nice build/X86_MSI/gem5.opt configs/example/fs.py --mem-size=8192MB --mem-channels=4 --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9 --disk=${M5_PATH}disks/linux-x86.img
#nice build/X86_MSI/gem5.opt configs/example/fs.py --mem-size=4096MB --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9 --disk=${M5_PATH}disks/linux-x86.img
# nice build/X86_MSI/gem5.opt --debug-flags=RubyNetwork configs/example/fs.py --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9 --disk=${M5_PATH}disks/linux-x86.img >> nbn_tempf

#for FLAG in "ProtocolTrace" "RubyCache" "RubyCacheTrace" "RubyDma" "RubyGenerated" "RubyPort" "RubyPrefetcher" "RubyQueue" "RubySequencer" "RubySystem" "RubyTester" "RubyStats" "RubyResourceStalls" ; do
#  echo "Starting test for ${FLAG}"
#  nice build/X86_MSI/gem5.opt --debug-flags=$FLAG configs/example/fs.py --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9 --disk=${M5_PATH}disks/linux-x86.img > tempf
#  tail -100000 tempf > ${FLAG}_trace
#  rm tempf
#done 
#build/PUREMSI/gem5.opt configs/example/fs.py --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9 --disk=${M5_PATH}disks/linux-x86.img
build/PUREMSI/gem5.opt configs/example/fs.py -n 3 --ruby --kernel=${M5_PATH}binaries/x86_64-vmlinux-2.6.22.9.smp --disk=${M5_PATH}disks/linux-x86.img
