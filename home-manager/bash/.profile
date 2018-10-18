########################################

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# ^ include `.bashr `if:
# * the file exists;
# * we're running bash;

########################################

export NIX_ENV_RC="$HOME"/.nix-profile/etc/profile.d/nix.sh

if   [ -e "${NIX_ENV_RC}" ]
then . "${NIX_ENV_RC}"
fi

# ^ `nix-env`
# 

########################################

export HOME_MANAGER_RC="$HOME"/.nix-profile/etc/profile.d/hm-session-vars.sh

if   [ -e "${HOME_MANAGER_RC}" ]
then . "${HOME_MANAGER_RC}"
fi

# ^ `home-manager`
# 

########################################

if   ! pgrep -x "ssh-agent" > /dev/null
then eval "$(ssh-agent -s)"
fi


########################################


