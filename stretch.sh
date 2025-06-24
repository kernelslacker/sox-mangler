#!/bin/bash

ARGS="stretch"

if [ "$(($RANDOM % 2))" == "0" ]; then
	ARGS="$ARGS 0.$(($RANDOM % 10 + 1))"
else
	ARGS="$ARGS $(($RANDOM % 10 + 1))"
fi

case "$(($RANDOM % 3))" in
0)	;;	# nothing
1)	ARGS="$ARGS $(($RANDOM % 500))"
	;;
2)	ARGS="$ARGS $(($RANDOM % 500)) lin"
	ARGS="$ARGS 0.$(($RANDOM % 10 + 1))"
	ARGS="$ARGS 0.$(($RANDOM % 5))"
	;;
esac

echo $ARGS
