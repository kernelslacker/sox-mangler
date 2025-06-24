#!/bin/bash

ARGS="pad 1 10 gain -h "

REV=0

if [ "$(($RANDOM % 2))" == "0" ]; then
  ARGS="$ARGS reverse"
  REV=1
fi

ARGS="$ARGS reverb"

if [ "$(($RANDOM % 2))" == "0" ]; then
	ARGS="$ARGS -w"
fi

if [ "$(($RANDOM % 2))" == "0" ]; then
	REVERBERANCE=100
else
	REVERBERANCE=$(($RANDOM % 50 + 25))
fi
ARGS="$ARGS $REVERBERANCE"

DAMP=$(($RANDOM % 99 + 1))
ARGS="$ARGS $DAMP"

SCALE=$(($RANDOM % 99 + 1))
ARGS="$ARGS $SCALE"

DEPTH=$(($RANDOM % 99 + 1))
ARGS="$ARGS $DEPTH"

PREDELAY=$(($RANDOM % 9 + 1))
ARGS="$ARGS $PREDELAY""0"

ARGS="$ARGS gain -r norm "
#ARGS="$ARGS silence 1 5 0%"
#ARGS="$ARGS reverse silence 1 5 0% reverse"

if [ $REV -eq 1 ]; then
	ARGS="$ARGS reverse"
fi

echo $ARGS
