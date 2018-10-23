#!/bin/bash

### -*- mode: conf-unix; -*-

##################################################
## Nix
##################################################

if [ -f  "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

##################################################
# Password
##################################################

function sboo-get-hackage-password () {

  if   [ -z "${SBOO_PASSWORD_HACKAGE+UNSET}" ]
  then # environment-variable is unset:

       PRIVATE="$HOME/Private"

       if   [ -r "$PRIVATE/sboo-password-hackage.txt" ]
       then # file is readable (and exists):

            cat "$PRIVATE/sboo-password-hackage.txt"

       else # file doesn't exist (or isn't readable):

            read -s -p "Hackage Password (for sboo): " SBOO_PASSWORD_HACKAGE
            # ^ 

            (umask 077 ; mkdir "$PRIVATE" && touch "$PRIVATE/sboo-password-hackage.txt")
            # ^ Atomically (?) create a file with non-default permissions (via shell-local `umask`):

            echo "${SBOO_PASSWORD_HACKAGE}" > "$PRIVATE/sboo-password-hackage.txt"

            echo "${SBOO_PASSWORD_HACKAGE}"
       fi

  else # environment-variable is set (even if empty):

       echo "${SBOO_PASSWORD_HACKAGE}"

  fi

}

# ^ where:
#
# * « ${var+x} » — a parameter expansion which evaluates to nothing if var is unset, and substitutes the string x otherwise
#
# * « `test -r FILE` » — `FILE` exists and read permission is granted.
#
# * « `read -s` » — Do not display password on screen (causes input coming from a terminal/keyboard to not be echoed).
# * « `read -p` "Password: " » — Display a prompt.
# * `read`'s positional argument — Bash variable in which your password stored.
# 
# * « `umask 077` » — Any newly-created files can't be read/write/execute by anyone but the owner.
#

##################################################
# 
##################################################







##################################################

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# ^ include `.bashr `if:
# * the file exists;
# * we're running bash;

##################################################

export NIX_ENV_RC="$HOME"/.nix-profile/etc/profile.d/nix.sh

if   [ -e "${NIX_ENV_RC}" ]
then . "${NIX_ENV_RC}"
fi

# ^ `nix-env`
# 

##################################################

export HOME_MANAGER_RC="$HOME"/.nix-profile/etc/profile.d/hm-session-vars.sh

if   [ -e "${HOME_MANAGER_RC}" ]
then . "${HOME_MANAGER_RC}"
fi

# ^ `home-manager`
# 

##################################################

if   ! pgrep -x "ssh-agent" > /dev/null
then eval "$(ssh-agent -s)"
fi

##################################################

#TODO export TERMINFO=/usr/lib/terminfo

##################################################

