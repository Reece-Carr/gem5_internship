WORKLOAD=$1
#for PROTO in "MI_EXAMPLE" "JASON_MSI_STANDARD_DMA" "ORD_MSI" "ORD_MESI" "ORD_MOSI" "MSI_UNORDERED_REQUESTOR_ACKS" "MSI_UNORDERED_INVS_ACK" "MSIOPTIMNETWORK" ; do
#for PROTO in "ORD_MSI" "MSI_UNORDERED_REQUESTOR_ACKS" "MSI_UNORDERED_INVS_ACK" "MSIOPTIMNETWORK" ; do
#for PROTO in "MSI_UNORDERED_REQUESTOR_ACKS" "MSI_UNORDERED_INVS_ACK" ; do
for PROTO in "ORD_MSI" "ORD_MOSI" ; do
##for PROTO in "MI_EXAMPLE" ; do
    echo "$PROTO, $WORKLOAD"
    screen -dmS $WORKLOAD-$PROTO bash -c "bash $WORKLOAD-in-se.sh $PROTO ; exec /bin/bash" ;  # Note: exec /bin/bash prevents screen from exiting upon sim completion
    sleep 1 ;
#for i in {1..5} ; do
#    echo "$i, $PROTO, $WORKLOAD"
#    screen -dmS $i-$WORKLOAD-$PROTO bash -c "bash $WORKLOAD-in-se.sh $PROTO $i ; exec /bin/bash" ;
#    sleep 1 ;
#done
done
