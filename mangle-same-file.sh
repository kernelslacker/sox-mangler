#!/bin/sh

BASEDIR=$(basename $(echo $0))
DIR=$(echo $0 | sed 's/'$BASEDIR'//g')

FILE="$@"
BASENAME=$(basename "$FILE" | sed 's/\.wav//g')
OLD="$@"

i=1
TODO=100

while [ $i -le $TODO ];
do
  NR=$(seq -w $i $TODO |head -n1)

  NEW="$BASENAME-$NR-$(date +%Y%m%d-%H%M).wav"

  echo mangling "$OLD" to "$NEW"
  $DIR/main.sh "$OLD" "$NEW"

  # too small
  if [ -f "$NEW" ]; then
    find -size -100k -samefile "$NEW" -exec rm -f "{}" \;
  fi

  # too big ?
  if [ -f "$NEW" ]; then
    find -size +1G -samefile "$NEW" -exec rm -f "{}" \;
  fi

  # If we created a new sample, set it as the new old, and move forward.
  if [ -f "$NEW" ]; then
    OLD="$NEW"
    i=$(($i + 1))
  else
    TXT=$(echo "$NEW" | sed 's/wav/txt/')
    rm -f "$TXT"
  fi
  echo
done

DEST=$(date +%Y%m%d-%H%M%S)
mkdir $DEST
mv *.wav *.txt $DEST
