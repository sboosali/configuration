#!/bin/bash
set -eu
########################################

FILEPATH=./kde/kcminputrc

LINKPATH="$HOME"/.config/kcminputrc

########################################

ln -sf "$FILEPATH" "$LINKPATH" 

########################################
###NOTES

# `ln -sf` versus `cp`

########################################