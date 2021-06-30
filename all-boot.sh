for PROTO in "ord-mi" "ord-msi" "ord-mesi" ; do
#for PROTO in "ord-mi" ; do
    for i in {1..5} ; do
        echo "Starting $PROTO, $i" ;
        nice screen -dmS $i-$PROTO-boot bash -c "bash $PROTO-boot-kernel.sh $WORKLOAD ; exec /bin/bash" ;
        sleep 1 ;
    done
done
