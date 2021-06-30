PORT=3456
for PROTO in "msi" "mosi" "mesi" "not" ; do
#for PROTO in "not" ; do
    for WORKLOAD in "radix" "lu" "fft" "cholesky" "water-spatial" "water-nsquared" "volrend" "raytrace" "radiosity" "ocean" "fmm" "barnes" ; do
    #for WORKLOAD in "volrend" ; do
        echo "$PROTO, $WORKLOAD" ;
        screen -dmS $PROTO-$WORKLOAD-kernel bash -c "bash $PROTO-generated-kernel.sh ; exec /bin/bash" ;
        sleep 5 ;
        screen -dmS $PROTO-$WORKLOAD-telnet bash -c "telnet localhost $PORT ; exec /bin/bash" ;
        screen -r $PROTO-$WORKLOAD-telnet ;
        PORT=$((PORT+1)) ;
    done
done
