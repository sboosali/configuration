#!/bin/bash
set -e

########################################

ARGUMENTS="$@"

########################################

function restart-xbindkeys () {

killall -s1 xbindkeys || true

xbindkeys -f ~/.xbindkeysrc &disown
# xbindkeys -fg ~/.xbindkeysrc.scm &disown 

}

########################################

ln -sf /home/sboo/configuration/xbindkeys/.xbindkeysrc ~/.xbindkeysrc

echo
ls -l --color=auto ~/.xbindkeys*
echo

########################################

restart-xbindkeys

########################################
