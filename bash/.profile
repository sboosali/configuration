#!/bin/bash

##################################################
##################################################
## Nix

if [ -f  "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

##################################################
##################################################
## Aliases (Shell-general)

alias sb="(cd ~ && source .bashrc)"

if [ -f  ~/.aliases ]; then
  source ~/.aliases
fi

##################################################
##################################################
## Definitions (Bash-only)

if [ -f  ~/.bash_definitions.sh ]; then
  source ~/.bash_definitions.sh
fi

##################################################
##################################################
# Effects ########################################
##################################################

# launching these services are in `.profile`,
# because we want to launch them only once.

#-----------------------------------------------#
# xbindkeys ------------------------------------#
#-----------------------------------------------#

if [ -x "$(command -v xbindkeys)" ]; then
    #TODO AND IF X11 IS ON
    xbindkeys --poll-rc
    # xbindkeys -p -fg .xbindkeysrc.scm
fi

#-----------------------------------------------#
# ssh-agent ------------------------------------#
#-----------------------------------------------#

if [ -x "$(command -v ssh-agent)" ]; then
    eval "$(ssh-agent -s)"
    # ^ Start the ssh-agent in the background.
fi

##################################################
##################################################