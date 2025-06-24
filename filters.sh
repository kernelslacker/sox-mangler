#!/bin/bash

case "$(($RANDOM % 3))" in
0)	FILTER="band"
	;;
1)	FILTER="lowpass"
	;;
2)	FILTER="highpass"
	;;
esac


CUTOFF=$(($RANDOM % 22 + 1))
if [ "$(($RANDOM % 2))" == "0" ]; then 
  CUTOFF=$(($CUTOFF * 100))
else
  CUTOFF=$(($CUTOFF * 1000))
fi

WIDTH=$((($RANDOM % 4 + 1) * 100))

ARGS="$FILTER $CUTOFF $WIDTH""h"

echo $ARGS
