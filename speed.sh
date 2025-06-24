#!/bin/bash

if [ "$(($RANDOM % 2))" == "0" ]; then
	ARGS="speed $(($RANDOM % 3 + 1))"
else
	ARGS="speed 0.$(($RANDOM % 10 + 1))"
fi

echo $ARGS
