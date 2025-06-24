#!/bin/bash

DRATE=$(($RANDOM % 200 + 1))
URATE=$(($RANDOM % 20 + 1))

if [ "$(($RANDOM % 2))" == "0" ]; then
  ARGS="downsample $DRATE upsample $URATE"
else
#  ROUNDS=$(($RANDOM % 2 + 1))
#  for i in $(seq 1 $ROUNDS)
#  do
    ARGS="$ARGS downsample"
#  done
fi

echo $ARGS
