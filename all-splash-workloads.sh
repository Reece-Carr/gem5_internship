for PROTO in "ord-msi" "msioptimnetwork" "unordered-msi-invs" "unordered-msi-req" ; do
#for PROTO in "msioptimnetwork" ; do
    #for WORKLOAD in "cholesky" "fft" "lu_cb" "lu_ncb" "radix" "barnes" "fmm" "ocean_cp" "ocean_ncp" "radiosity" "raytrace" "volrend" "water_nsquared" "water_spatial" ; do
    for WORKLOAD in "cholesky" "fft" "lu_cb" "lu_ncb" "radix" "barnes"  "ocean_cp" "raytrace" ; do
        echo "Starting $PROTO, $WORKLOAD" ;
        #nice screen -dmS $PROTO-splash2x-$WORKLOAD-simsmall-kernel bash -c "bash $PROTO-parsec-kernel.sh splash2x.$WORKLOAD 4 2 simsmall ; exec /bin/bash" ;
        nice screen -dmS $PROTO-splash2x-$WORKLOAD-simlarge-kernel bash -c "bash $PROTO-parsec-kernel.sh splash2x.$WORKLOAD 4 2 simlarge ; exec /bin/bash" ;
        sleep 1 ;
    done
done
