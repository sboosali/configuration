#!/bin/env bash

##################################################

# « xbindkeys » command-line completion
#
# GPL-3.0-or-later © 2019 "Sam Boosalis" <samboosalis@gmail.com>

#------------------------------------------------#
# Commentary ------------------------------------#
#------------------------------------------------#

# Examples

# $ xbindkeys <TAB>
#
# ...

#------------------------------------------------#

# Usage...

# $ xbindkeys --help
#
# xbindkeys 1.8.6 by Philippe Brochard
#
# usage: xbindkeys [options]
#   where options are:
#
#   -V, --version           Print version and exit
#   -d, --defaults          Print a default rc file
#  -dg, --defaults-guile    Print a default guile configuration file
#   -f, --file              Use an alternative rc file
#  -fg, --file-guile        Use an alternative guile configuration file
#   -p, --poll-rc           Poll the rc/guile configs for updates
#   -h, --help              This help!
#   -X, --display           Set X display to use
#   -v, --verbose           More information on xbindkeys when it run
#   -s, --show              Show the actual keybinding
#   -k, --key               Identify one key pressed
#  -mk, --multikey          Identify multi key pressed
#   -g, --geometry          size and position of window open with -k|-mk option
#   -n, --nodaemon          don't start as daemon

#------------------------------------------------#
# Code ------------------------------------------#
#------------------------------------------------#

_xbindkeys_options=( )

_xbindkeys_options+=( "-h"  "--help" )
_xbindkeys_options+=( "-V"  "--version" )
_xbindkeys_options+=( "-d"  "--defaults" )
_xbindkeys_options+=( "-dg" "--defaults-guile" )
_xbindkeys_options+=( "-f"  "--file" )
_xbindkeys_options+=( "-fg" "--file-guile" )
_xbindkeys_options+=( "-p"  "--poll-rc" )
_xbindkeys_options+=( "-X"  "--display" )
_xbindkeys_options+=( "-v"  "--verbose" )
_xbindkeys_options+=( "-s"  "--show" )
_xbindkeys_options+=( "-k"  "--key" )
_xbindkeys_options+=( "-mk" "--multikey" )
_xbindkeys_options+=( "-g"  "--geometry" )
_xbindkeys_options+=( "-n"  "--nodaemon" )

#------------------------------------------------#

#echo "${_xbindkeys_options[*]}"

complete -W "${_xbindkeys_options[*]}" xbindkeys
