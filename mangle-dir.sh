#!/bin/bash

BASEDIR=$(basename $(echo $0))
DIR=$(echo $0 | sed 's/'$BASEDIR'//g')

BASEBASE="$2"

DESTDIR=output/$(date +%Y%m%d)/

mkdir -p "$DESTDIR"

echo $1/*.wav

for SRC in "$1/*.wav"
do
  BASENAME=$(basename "$SRC" | sed 's/\.wav//g')
  DST="$BASEBASE-$(basename "$1")-$BASENAME-$(date +%Y%m%d-%H%M)"

  $DIR/main.sh "$SRC" "$DST.wav"
  echo

  # too small
  if [ -f "$DST.wav" ]; then
    find -size -50k -samefile "$DST.wav" -exec rm -f "{}" \;
  fi

  # too big ?
  if [ -f "$DST.wav" ]; then
    find -size +1G -samefile "$DST.wav" -exec rm -f "{}" \;
  fi

  if [ ! -f "$DST.wav" ]; then
    rm -f "$DST.txt"
  else
    mv -- "$DST.wav" "$DST.txt" "$DESTDIR"
  fi
done
