for PROTO in "j-msi-r" "j-msi-z" ; do
#for PROTO in "msioptimnetwork-recycle" "msioptimnetwork-z" "unordered-msi-req-recycle" "unordered-msi-req-z" ; do
#for PROTO in "8x8-msioptimnetwork-recycle" "8x8-msioptimnetwork-z" "8x8-unordered-msi-req-recycle" "8x8-unordered-msi-req-z" ; do
#for PROTO in "8x8-jason" ; do
#for PROTO in "8x8-msioptimnetwork-z" ; do
#for PROTO in "unordered-msi-req-recycle" "unordered-msi-req-z" ; do
#for PROTO in "msioptimnetwork-recycle" "msioptimnetwork-z" ; do
#for PROTO in "msioptimnetwork-z" ; do
#for PROTO in "ord-mi" "ord-msi" "ord-mesi" ; do
for i in "6" "7" "8" "9" "10" ; do
    for WORKLOAD in "cholesky" "lu_cb" ; do
        echo "Starting $PROTO, $WORKLOAD" ;
        nice screen -dmS $i-$PROTO-splash2x-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh splash2x.$WORKLOAD 4 2 simsmall ; exec /bin/bash" ;
    #    nice screen -dmS $PROTO-splash2x-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh splash2x.$WORKLOAD 64 8 simsmall ; exec /bin/bash" ;
        sleep 1 ;
    done
    for WORKLOAD in "bodytrack" "freqmine" "swaptions" ; do
        echo "Starting $PROTO, $WORKLOAD" ;
        nice screen -dmS $i-$PROTO-parsec-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh $WORKLOAD 4 2 simsmall ; exec /bin/bash" ;
    #    nice screen -dmS $PROTO-parsec-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh $WORKLOAD 64 8 simsmall ; exec /bin/bash" ;
        sleep 1 ;
    done
    #WORKLOAD="bodytrack"
    #for i in {1..5} ; do
    #    echo "Starting bodytrack $PROTO, $i"
    #    nice screen -dmS $i-$PROTO-parsec-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh $WORKLOAD 16 4 simsmall $i ; exec /bin/bash" ;
    #    sleep 1 ;
    #    #nice screen -r $i-$PROTO-parsec-$WORKLOAD-simsmall-kernel
    #done
done
done
