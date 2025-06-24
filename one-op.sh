#!/bin/bash
# $1 src
# $2 dst
# $3 opnr (0-15)

BASEDIR=$(basename $(echo $0))
DIR=$(echo $0 | sed 's/'$BASEDIR'//g')

. $DIR/ops.sh
init_ops

SR=$(soxi "$1" | grep Sample\ Rate | awk '{ print $4 }')

MINS=$(soxi "$1" | grep Duration | sed 's/:0/:/g' | sed 's/:/\ /g' | sed 's/\./\ /g' | awk '{ print $3 }')
SECS=$(soxi "$1" | grep Duration | sed 's/:0/:/g' | sed 's/:/\ /g' | sed 's/\./\ /g' | awk '{ print $4 }')
LEN=$((($MINS * 60) + $SECS + 1))

echo file: $1 is $MINS mins and $SECS secs

DOCHOP=0
if [ $LEN -gt 300 ]; then
  echo "File is more than five minutes long ("$LEN" secs). Taking a segment."
  STARTSEC=$(($RANDOM % $LEN))
  REMAIN=$(($LEN - $STARTSEC))
  END=$(($RANDOM % $REMAIN))
  ENDSEC=$(($STARTSEC + $END))
  echo Chopping from $STARTSEC to $ENDSEC

  DOCHOP=1
fi

if [ $DOCHOP -eq 1 ]; then
  ARGS="trim $STARTSEC $ENDSEC "
fi

OPNR=$3
CMD=${cmds[$OPNR]}
T=$(eval "$DIR/$CMD $LEN")
ARGS="$ARGS $T"

echo $ARGS

timeout -k 30s 15m \
    sox --multi-threaded -S "$1" "$2" \
        $ARGS norm -3 \
	compand 0.3,1 6:-70,-60,-20 -5 -90 0.2 \
	silence 1 0.1 0.1% reverse silence 1 0.1 0.1% reverse

# TODO use remix instead of channels
#    sox --multi-threaded -S "$1" "$2" $ARGS norm -3 channels 2 \

FN=$(echo "$2" | sed 's/\.wav$//')
echo "$ARGS" > "$FN.txt"

if [ ! -f "$2" ]; then
  exit
fi

# If we generated a 32bit WAV, we want to downsample it.
# because Live can't read 32bit yet.
RES=$(soxi "$2" | grep Precision | awk '{ print $3 }')
case "$RES" in
32-bit)	R=$RANDOM
	echo "Resampling."
	sox "$2" -b 24 resample-$R.wav
	mv resample-$R.wav "$2"
	;;
esac

echo
