#for WORKLOAD in "blackscholes" "bodytrack" "canneal" "dedup" "facesim" "ferret" "fluidanimate" "freqmine" "raytrace" "streamcluster" "swaptions" "vips" "x264" ; do
    #for PROTO in "ord-msi" "ord-mesi" "ord-mosi" ; do
    for PROTO in "ord-msi" "unordered-msi-req" "unordered-msi-invs" "msioptimnetwork" ; do
        #screen -r $PROTO-$WORKLOAD-simsmall-kernel
        screen -r $PROTO-$1-simsmall-kernel
    done
#done
