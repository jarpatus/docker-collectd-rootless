#!/bin/sh
SYSPATH=$1
INTERFACES=$2

while true; do
    for interface in $INTERFACES; do
        RX_BYTES=$(cat $SYSPATH/devices/virtual/net/$interface/statistics/rx_bytes)
        RX_ERRORS=$(cat $SYSPATH/devices/virtual/net/$interface/statistics/rx_errors)
        TX_BYTES=$(cat $SYSPATH/devices/virtual/net/$interface/statistics/tx_bytes)
        TX_ERRORS=$(cat $SYSPATH/devices/virtual/net/$interface/statistics/tx_errors)
        echo "PUTVAL $HOSTNAME/network-$interface/gauge-rx_bytes interval=10 N:$RX_BYTES"
        echo "PUTVAL $HOSTNAME/network-$interface/gauge-rx_errors interval=10 N:$RX_ERRORS"
        echo "PUTVAL $HOSTNAME/network-$interface/gauge-tx_bytes interval=10 N:$TX_BYTES"
        echo "PUTVAL $HOSTNAME/network-$interface/gauge-tx_errors interval=10 N:$TX_ERRORS"
    done
    sleep 10
done
