##################################################
{ pkgs
}:

##################################################
let

NIX_PROFILE = "$HOME/.nix-profile";

#TODO terminfo = ''${pkgs.terminfo}/...'';

in
##################################################
''
#-----------------------------------------------#
# terminfo -------------------------------------#
#-----------------------------------------------#

export TERMINFO_DIRS="${NIX_PROFILE}/share/terminfo":/lib/terminfo

#-----------------------------------------------#
''

# ^ « tput » needs « terminfo » to identity « $TERM »
# (i.e. the current terminal).

# ^ TODO :"$TERMINFO"
# ^ TODO :"$TERMINFO" as sessionVariables that interpolates `{pkgs.termite}/share/terminfo`
# ^ TODO « "./home-path/share/terminfo/x/xterm-termite" »

