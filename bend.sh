#!/bin/bash

LEN=$1

if [ "$LEN" == "" ]; then
  LEN=$(($RANDOM % 1000))
  echo using random length
fi

case "$(($RANDOM % 8))" in
0)
	D1=$(($RANDOM % 100))
	D2=$(($RANDOM % 100))
	D3=$(($RANDOM % 100))
	if [ "$(($RANDOM % 2))" == "0" ]; then
		C1=$(($RANDOM % 1000))
	else
		C1=-$(($RANDOM % 1000))
	fi

	if [ "$(($RANDOM % 2))" == "0" ]; then
		C2=$(($RANDOM % 1000))
	else
		C2=-$(($RANDOM % 1000))
	fi

	if [ "$(($RANDOM % 2))" == "0" ]; then
		C3=$(($RANDOM % 1000))
	else
		C3=-$(($RANDOM % 1000))
	fi

	T1=$(($RANDOM % 50))
	T2=$(($RANDOM % 50))
	T3=$(($RANDOM % 50))
	ARGS="bend -o32 .$D1,$C1,.$T1  .$D2,$C2,.$T2  $D3,$C3,$T3"
	;;

1)	ARGS="bend -o32 0,-520,$LEN"
	;;

2)	ARGS="bend -o32 0,$(($RANDOM % 10000)),$LEN"
	;;

3)	ARGS="bend -o32 0,-$(($RANDOM % 9999 + 1)),$LEN"
	;;

4)	N=$(($RANDOM % 10))
	ARGS="bend -o32"
	for i in $(seq 1 $N)
	do
		D=$(($RANDOM % 100))

		if [ "$(($RANDOM % 2))" == "0" ]; then
			C=$(($RANDOM % 100))
		else
			C=-$(($RANDOM % 99 + 1))
		fi

		T=$(($RANDOM % 50))

		ARGS="$ARGS .$D,$C,.$T "
	done
	;;

# Like 4, but only bend up
5)	N=$(($RANDOM % 10))
	ARGS="bend -o32"
	for i in $(seq 1 $N)
	do
		D=$(($RANDOM % 100))
		C=$(($RANDOM % 100))
		T=$(($RANDOM % 50))

		ARGS="$ARGS .$D,$C,.$T "
	done
	;;

# Like 4, but only bend down 
6)	N=$(($RANDOM % 10))
	ARGS="bend -o32"
	for i in $(seq 1 $N)
	do
		D=$(($RANDOM % 100))
		C=-$(($RANDOM % 99 + 1))
		T=$(($RANDOM % 50))

		ARGS="$ARGS .$D,$C,.$T "
	done
	;;

# const bend, differing starts
7)	N=$(($RANDOM % 10))
	ARGS="bend -o32"
	if [ "$(($RANDOM % 2))" == "0" ]; then
		C=$(($RANDOM % 100))
	else
		C=-$(($RANDOM % 99 + 1))
	fi

	T=$(($RANDOM % 50))

	for i in $(seq 1 $N)
	do
		D=$(($RANDOM % 100))
		ARGS="$ARGS .$D,$C,.$T "
	done
	;;

# rand bend, differing starts
8)	N=$(($RANDOM % 10))
	ARGS="bend -o32"
	T=$(($RANDOM % 50))

	for i in $(seq 1 $N)
	do
		C=$((($RANDOM % 10 + 1) * 100))

		D=$(($RANDOM % 100))
		if [ "$(($RANDOM % 2))" == "0" ]; then
			ARGS="$ARGS .$D,$C,.$T "
		else
			ARGS="$ARGS .$D,-$C,.$T "
		fi
	done
	;;

esac

echo $ARGS
