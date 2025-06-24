#!/bin/bash
# $1 src
# $2 dst

BASEDIR=$(basename $(echo $0))
DIR=$(echo $0 | sed 's/'$BASEDIR'//g')

if [ -z "$DIR" ]; then
  DIR="./"
fi

. $DIR/ops.sh
init_ops

SR=$(soxi "$1" | grep Sample\ Rate | awk '{ print $4 }')

MINS=$(soxi "$1" | grep Duration | sed 's/:0/:/g' | sed 's/:/\ /g' | sed 's/\./\ /g' | awk '{ print $3 }')
SECS=$(soxi "$1" | grep Duration | sed 's/:0/:/g' | sed 's/:/\ /g' | sed 's/\./\ /g' | awk '{ print $4 }')
LEN=$((($MINS * 60) + $SECS + 1))

echo file: $1 is $MINS mins and $SECS secs

DOCHOP=0
LENMAX=10
if [ $LEN -gt $LENMAX ]; then
  echo "File is more than $LENMAX seconds long ("$LEN" secs). Taking a segment."
  STARTSEC=$(($RANDOM % $LEN))
  REMAIN=$(($LEN - $STARTSEC))
  END=$(($RANDOM % $REMAIN))

  case "$(($RANDOM % 3))" in
  0) ENDSEC=$(($STARTSEC + $END))
     ;;
  1) ENDSEC=$(($STARTSEC + 1))
     ;;
  2) ENDSEC=$STARTSEC.1
     ;;
  esac

  echo Chopping from $STARTSEC to $ENDSEC

  DOCHOP=1
fi

OPS=$(($RANDOM % 5))

if [ $DOCHOP -eq 1 ]; then
  ARGS="trim $STARTSEC $ENDSEC "
fi

for i in $(seq 0 $OPS)
do
	CMD=${cmds[$(($RANDOM % $NR_CMDS))]}
	S=$(($RANDOM % 3))
	for s in $(seq 0 $S)
	do
          T=$(eval "$DIR$CMD $LEN")
	  ARGS="$ARGS $T"
        done
done

echo $ARGS

timeout -k 30s 15m \
    sox --multi-threaded -S "$1" -b 24 "$2" \
        $ARGS norm -3 \
	compand 0.3,1 6:-70,-60,-20 -5 -90 0.2 \
	silence 1 0.1 0.1% reverse silence 1 0.1 0.1% reverse

# TODO use remix instead of channels
#    sox --multi-threaded -S "$1" "$2" $ARGS norm -3 channels 2 \

FN=$(echo "$2" | sed 's/\.wav$//')
#echo "$ARGS" > "$FN.txt"

if [ ! -f "$2" ]; then
  exit
fi
