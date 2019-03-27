#!/bin/env bash

##################################################

# « emacsclient » command-line completion
#
# GPL-3.0-or-later © 2019 "Sam Boosalis" <samboosalis@gmail.com>

##################################################
# Examples:

# $ emacsclient <TAB>
#
# -V
# --version
# -H
# --help   
# -nw
# -t
# --tty
# -c
# --create-frame   
# -F
# --frame-parameters
# -e
# --eval   
# -n
# --no-wait
# -q
# --quiet
# -u
# --suppress-output
# -d
# --display
# --parent
# -s
# -socket-name
# -f
# --server-file
# -a
# --alternate-editor
# -T
# --tramp
#

##################################################
# Code:

complete -W "-V --version -H --help -nw -t --tty -c --create-frame -F --frame-parameters -e --eval -n --no-wait -q --quiet -u --suppress-output -d --display --parent -s -socket-name -f --server-file -a --alternate-editor -T --tramp" emacsclient