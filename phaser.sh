#!/bin/bash

ARGS="phaser 0.6 0.6 $(($RANDOM % 4 + 1)) 0.$(($RANDOM % 25 + 1))"

if [ "$(($RANDOM % 2))" == "0" ]; then
	ARGS="$ARGS $(($RANDOM % 2)).$(($RANDOM % 9 + 1))"
else
	ARGS="$ARGS 2"
fi

if [ "$(($RANDOM % 2))" == "0" ]; then
	ARGS="$ARGS -s"
else
	ARGS="$ARGS -t"
fi

echo $ARGS
