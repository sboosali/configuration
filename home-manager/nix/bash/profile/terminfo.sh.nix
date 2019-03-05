##################################################
{ pkgs
, lib

, bashUtilities
}:

##################################################
let
#-----------------------------------------------#

#TODO terminfo = ''${pkgs.terminfo}/...'';

#-----------------------------------------------#

NIX_PROFILE = "$HOME/.nix-profile";

#-----------------------------------------------#

TERMINFO_DIRS = bashUtilities.makePath

  [
    ~/.nix-profile/share/terminfo
    /lib/terminfo
  ];

#-----------------------------------------------#
in
##################################################

''
#-----------------------------------------------#
# terminfo -------------------------------------#
#-----------------------------------------------#

export TERMINFO_DIRS=${TERMINFO_DIRS}

#-----------------------------------------------#
''

# ^ « tput » needs « terminfo » to identity « $TERM »
# (i.e. the current terminal).

# ^ TODO :"$TERMINFO"
# ^ TODO :"$TERMINFO" as sessionVariables that interpolates `{pkgs.termite}/share/terminfo`
# ^ TODO « "./home-path/share/terminfo/x/xterm-termite" »

##################################################