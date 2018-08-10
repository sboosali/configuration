#!/bin/bash
set -e
########################################

XMODMAP_FILE=./xmodmap/set-capslock-to-control.xmodmap

########################################

xmodmap -e "${XMODMAP_FILE}"

########################################
# NOTES
#
# 
########################################