#!/bin/bash

case "$(($RANDOM % 6))" in 
0)	ARGS="gain -l +1"
	;;
1)	ARGS="gain -1"
	;;
2)	ARGS="gain -h bass +6 gain -r"
	;;
3)	ARGS="gain -h bass +3 gain -r"
	;;
4)	ARGS="gain -h treble +3 gain -r"
	;;
5)	ARGS="gain -l +6"
	;;
esac

echo $ARGS
