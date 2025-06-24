#!/bin/bash

ARGS="chorus"

# gain in/out
ARGS="$ARGS 0.1 0.1"

N=$(($RANDOM % 7 + 1))

for i in $(seq 1 $N)
do

	# delay (20ms -> 100ms)
	DELAY=$(($RANDOM % 9 + 2))
	ARGS="$ARGS $DELAY""0 "

	DECAY=$(($RANDOM % 100 + 1))
	ARGS="$ARGS 0.$DECAY"

	SPEED=$(($RANDOM % 100 + 1))
	ARGS="$ARGS 0.$SPEED"

	DEPTH=$(($RANDOM % 5 + 1))
	ARGS="$ARGS $DEPTH"

	# shape
	if [ "$(($RANDOM % 2))" == "0" ]; then
		ARGS="$ARGS -s"
	else
		ARGS="$ARGS -t"
	fi
done

echo $ARGS
