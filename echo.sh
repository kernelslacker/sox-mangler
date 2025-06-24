#!/bin/bash

ARGS="echo 0.8 0.7"

N=$(($RANDOM % 6 + 1))
for i in $(seq 1 $N)
do
	ARGS="$ARGS $(($RANDOM % 2000 + 100)) 0.$(($RANDOM % 25))"
done

echo $ARGS
