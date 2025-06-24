#!/bin/bash

init_ops()
{
  cmds=(
    "bend.sh"
    "chorus.sh"
    "downsample.sh"
    "echo.sh"
    "echos.sh"
    "filters.sh"
    "gain.sh"
    "overdrive.sh"
    "phaser.sh"
    "pitch.sh"
    "reverb.sh"
    "reverse.sh"
    "speed.sh"
    "stretch.sh"
    "tempo.sh"
    "tremolo.sh"
  )

  NR_CMDS=${#cmds[*]}
}

print_op()
{
  init_ops
  echo ${cmds[$1]}
}
