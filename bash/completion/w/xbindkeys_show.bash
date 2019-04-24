#!/bin/env bash

##################################################

# « xbindkeys_show » command-line completion
#
# GPL-3.0-or-later © 2019 "Sam Boosalis" <samboosalis@gmail.com>

#------------------------------------------------#
# Commentary ------------------------------------#
#------------------------------------------------#

# Examples

# $ xbindkeys_show <TAB>
#
# ...

#------------------------------------------------#

# Usage...

# $ xbindkeys_show --help
#
# xbindkeys_show 1.8.6 by Philippe Brochard
#
# Usage: xbindkeys_show [Options]
#   Where options are:
#
#          --help                 this help
#      -f, --file <file>          use <file> as configuration file
#     -fg, --file-guile <file>    use <file> as guile configuration file

#------------------------------------------------#
# Code ------------------------------------------#
#------------------------------------------------#

_xbindkeys_show_options=( )

_xbindkeys_show_options+=(       "--help" )
_xbindkeys_show_options+=( "-f"  "--file" )
_xbindkeys_show_options+=( "-fg" "--file-guile" )

#------------------------------------------------#

complete -W "${_xbindkeys_show_options[*]}" xbindkeys_show
