#!/bin/bash

if [ "$(($RANDOM % 2))" == "0" ]; then
	ARGS="tempo -m 0.$(($RANDOM % 9 + 1))"
else
	ARGS="tempo -m 1.$(($RANDOM % 9 + 1))"
fi

echo $ARGS
