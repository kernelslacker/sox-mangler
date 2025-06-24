#!/bin/bash

SHIFT=$(($RANDOM % 3986 + 1))

if [ "$(($RANDOM % 2))" == "0" ]; then
  ARGS="pitch -$SHIFT"
else
  ARGS="pitch $SHIFT"
fi

echo $ARGS
