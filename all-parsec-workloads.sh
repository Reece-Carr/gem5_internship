#for PROTO in "ord-msi" "ord-mosi" "ord-mesi" ; do
#for PROTO in "ord-mi" ; do
#for PROTO in "ord-msi" ; do
#for PROTO in "mesi-two-level" ; do
#for PROTO in "jason-msi-standard-dma" ; do
#for PROTO in "jason-msi-standard-dma" "ord-msi" "msioptimnetwork" "unordered-msi-invs" "unordered-msi-req" ; do
#for PROTO in "ord-msi" "msioptimnetwork" "unordered-msi-invs" "unordered-msi-req" ; do
for PROTO in "msioptimnetwork" ; do
    #for WORKLOAD in "blackscholes" "bodytrack" "canneal" "dedup" "facesim" "ferret" "fluidanimate" "freqmine" "raytrace" "streamcluster" "swaptions" "vips" "x264" ; do
    #for WORKLOAD in "blackscholes" "bodytrack" "canneal" "dedup" "ferret" "fluidanimate" "freqmine" "raytrace" "streamcluster" "swaptions" "vips" ; do
    #for WORKLOAD in "dedup" ; do
    for WORKLOAD in "vips" ; do
        #echo "Starting $PROTO, $WORKLOAD" ;
        #nice screen -dmS $PROTO-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh $WORKLOAD 4 2 simsmall ; exec /bin/bash" ;
        nice screen -dmS testkernel bash -c "bash testkernel.sh $WORKLOAD 4 2 simsmall ; exec /bin/bash" ;
        sleep 1 ;
    done
done
