#!/bin/bash

########################################

function xcalib-darkroom() {
  xcalib-red
  xcalib-invert
}

function xcalib-red() {
  xcalib -clear
  #xcalib -co 60 -alter
  xcalib -green 0.1 0 1  -alter
  xcalib -blue  0.1 0 1  -alter
  xcalib -red   0.5 1 40 -alter
}

function xcalib-dim() {
  xcalib -clear
  xcalib -co 30 -alter
}

function xcalib-invert() {
  xcalib -i -a
}

########################################

# Usage
if [[ "$1" == "help" || -z "$1" ]]; then
  echo
  echo "$0 help"
  echo "  Display this message."
  echo
  echo "$0 red"
  echo "  Among the screen colors, keep only the red."
  echo
  echo "$0 invert"
  echo "  Invert the colors on the screen."
  echo
  echo "$0 dim"
  echo "  Dim the screen."
  echo
  echo "$0 white"
  echo "  Restore the screen's default colors/brightness."
  echo
  echo "$0 darkroom"
  echo "  Like \`$0 red; $0 invert\`."
  echo
  exit
fi

# Like f.lux's darkroom mode.
if [[ "$1" == "darkroom" ]]; then
  xcalib-red
  xcalib-invert
  exit
fi

# Turn the screen red
if [[ "$1" == "red" ]]; then
  xcalib-red

  if [[ "$1" == "invert" ]]; then
    xcalib-invert
  fi

  exit
fi

# Return to normal settings
if [[ "$1" == "white" ]]; then
  xcalib -clear

  if [[ "$1" == "invert" ]]; then
    xcalib-invert
  fi

  exit
fi

# Make the screen darker
if [[ "$1" == "dim" ]]; then
  xcalib-dim

  if [[ "$1" == "invert" ]]; then
    xcalib-invert
  fi

  exit
fi

########################################
