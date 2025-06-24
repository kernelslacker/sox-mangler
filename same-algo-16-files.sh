#!/bin/bash

BASEDIR=$(basename $(echo $0))
DIR=$(echo $0 | sed 's/'$BASEDIR'//g')

SR=$(soxi -r "$1")
LEN=$(soxi -D "$1")
echo file: $1 is $SECS secs

DESTBASE=$(echo "$1" | sed 's/\.wav//')

cmds[0]="bend.sh"
cmds[1]="chorus.sh"
cmds[2]="downsample.sh"
cmds[3]="echo.sh"
cmds[4]="echos.sh"
cmds[5]="filters.sh"
cmds[6]="gain.sh"
cmds[7]="overdrive.sh"
cmds[8]="phaser.sh"
cmds[9]="pitch.sh"
cmds[10]="reverb.sh"
cmds[11]="reverse.sh"
cmds[12]="speed.sh"
cmds[13]="stretch.sh"
cmds[14]="tempo.sh"
cmds[15]="tremolo.sh"

NR_CMDS=${#cmds[*]}

CMD=${cmds[$(($RANDOM % $NR_CMDS))]}

for i in $(seq 1 16)
do
	ARGS=$(eval "$DIR$CMD $LEN")
	echo $ARGS
	DEST=$DESTBASE-$i.wav

	timeout -k 30s 15m \
	    sox --multi-threaded -S "$1" "$DEST" $ARGS norm channels 2 \
		compand 0.3,1 6:-70,-60,-20 -5 -90 0.2

	# If we generated a 32bit WAV, we want to downsample it.
	# because Live can't read 32bit yet.
	RES=$(soxi "$DEST" | grep Precision | awk '{ print $3 }')
	case "$RES" in
	32-bit)	R=$RANDOM
		sox "$DEST" -b 24 resample-$R.wav
		mv resample-$R.wav "$DEST"
		;;
	esac
done

# join
mv $DESTBASE-1.wav out.wav

for i in $(seq 2 16)
do
  sox out.wav $DESTBASE-$i.wav new.wav splice -q
  mv new.wav out.wav
  rm -f $DESTBASE-$i.wav
done
mv out.wav output/$(basename $DESTBASE).wav

echo
