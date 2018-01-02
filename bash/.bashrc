########################################
## NOTES 

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ".bashrc is read by a bash(-compatible) shell that's both interactive and non-login"
# .profile would be read by login shells

# when you run a script, the current shell makes a new shell to run that script in. 
# to exec a script in the current shell, you must source it (i.e. `source ./run.sh`, not `./run.sh`)


########################################
## INITIAL

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

########################################
## IMPORTANT SETTINGS

# nix
if [ -f  "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

########################################
## IMPORTS

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# pure stuff
if [ -f  .bash_definitions.sh ]; then
  source .bash_definitions.sh
fi

# impure stuff
if [ -f  .bash_settings.sh ]; then
  source .bash_settings.sh
fi

#NOTE
# these are relative imports

########################################
## EFFECTS 

echo 'PATH =' $(echo $PATH | tr ':' '\n')
echo
echo "$TERM" # e.g. xterm-256color
echo

########################################
## (AUTO-ADDED...)
