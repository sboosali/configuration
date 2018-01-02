#!/bin/bash

#########################################
## 

# if [ -f  .bashrc ]; then
#   source .bashrc
# fi

#########################################
## xbindkeys

# in .profile, because we only want to launch it once

if [ -x "$(command -v xbindkeys)" ]; then
  xbindkeys --poll-rc
# xbindkeys -p -fg .xbindkeysrc.scm
fi

#########################################
## 
