#for PROTO in "j-msi-r" "j-msi-z" ; do
for PROTO in "ord-msi" ; do
for i in "1" "2" "3" "4" "5" ; do # "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" ; do
    for WORKLOAD in "cholesky" "lu_cb" ; do
        echo "Starting $PROTO, $WORKLOAD" ;
        nice screen -r $i-$PROTO-splash2x-$WORKLOAD-simsmall-kernel 
    done
    for WORKLOAD in "bodytrack" "freqmine" "swaptions" ; do
        echo "Starting $PROTO, $WORKLOAD" ;
        nice screen -r $i-$PROTO-parsec-$WORKLOAD-simsmall-kernel 
    done
done
done
