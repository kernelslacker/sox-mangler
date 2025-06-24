#!/bin/bash

ARGS="echos 0.8 0.7 "

NUM_ECHOS=$(($RANDOM % 6 + 1))

for n in $(seq 1 $NUM_ECHOS)
do
	ARGS="$ARGS $(($RANDOM % 2000 + 10)) 0.$(($RANDOM % 25))"
done

echo $ARGS
