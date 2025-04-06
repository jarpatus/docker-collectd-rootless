#!/bin/bash
INTERVAL=10

radeontop -d - -i $INTERVAL | while read -r line; do
  IFS=","; for stat in $line; do
    stat="${stat//%/}"
    stat="${stat//mb/}"
    stat="${stat//ghz/}"
    IFS=" " arr=($stat)
    case "${arr[0]}" in
      "gpu")
        echo "PUTVAL $HOSTNAME/radeon/gauge-${arr[0]}_percentace interval=$INTERVAL N:${arr[1]}"
        ;;
      "vram"|"gtt"|"mclk"|"sclk")
        echo "PUTVAL $HOSTNAME/radeon/gauge-${arr[0]}_percentace interval=$INTERVAL N:${arr[1]}"
        echo "PUTVAL $HOSTNAME/radeon/gauge-${arr[0]}_value interval=$INTERVAL N:${arr[2]}"
        ;;
    esac
  done
done
