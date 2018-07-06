#!/bin/bash
#set -e

# this file is "impure";
# it has effects like overwriting environment variables, spawning daemons, calling `shopt`, etc

# TODO rm /usr/games /usr/local/games /snap/bin #LOL Ubuntu

# guard executions on whether the executable's present
# 
# if [ -x "$(command -v EXECUTABLE)" ]; then
#  
# fi

########################################
# NIX/NIXPKGS SETTINGS

export NIX_PATH="nixpkgs=$HOME/nixpkgs:nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"

# export NIX_PATH="nixpkgs=$HOME/nixpkgs:$NIX_PATH"


########################################
## IMPORTS

if [ -f .git-prompt.sh ]; then
  # shellcheck disable=SC1091 
  source .git-prompt.sh
fi

########################################
## RE-SETTINGS

# clear
PROMPT_COMMAND=""

########################################
## LOCALE SETTINGS

LANGUAGE=en_US
LANG=en_US.UTF-8

#TODO LC_ALL=en_US
# ^ see <https://askubuntu.com/questions/114759/warning-setlocale-lc-all-cannot-change-locale>
# $ sudo update-locale LC_ALL=en_US

########################################
## BASH COMPLETION SETTINGS

for COMPLETION in ~/.nix-profile/etc/bash_completion.d/*
do
    source "$COMPLETION" || true
done

####################

# don't wildcard the larger directory, whitelist instead.
#NOTE too many errors from the completion-scripts of hundreds of random executable's.

##COMPLETION_SCRIPTS=~/.nix-profile/share/bash-completion/completions/*

COMPLETION_DIRECTORY=~/.nix-profile/share/bash-completion/completions

for COMPLETION in "$COMPLETION_DIRECTORY"/{sudo,find,export,declare,ssh-add,ssh-keygen,xmodmap,xrandr,dconf,curl,ping,dd,gzip,rsync,kill,htop,pkill,pgrep,iconv,dot,feh}
do
    source "$COMPLETION" || true
done

### {sudo,find,ls,export,declare,git,ghc,ghcjs,cabal,clang,gcc,g++,ssh,ssh-add,ssh-keygen,xmodmap,xrandr,xbindkeys,dconf,curl,ping,dd,tar,gzip,7z,rsync,htop,pkill,pgrep,pandoc,iconv,dot,nano,emacs,emacsclient,feh,}

####################

# $ source "$(dirname $(readlink $(which git)))/"../share/git/contrib/completion/git-completion.bash || true
# ^ custom subdirectory, for `git`.
#
# e.g. /nix/store/*git*/bin/../share/git/contrib/completion/git-completion.bash
# i.e.
# e.g. /nix/store/*git*/share/git/contrib/completion/git-completion.bash
# i.e.
# e.g. _/share/git/contrib/completion/git-completion.bash
#
# e.g. ~/.nix-profile/share/bash-completion/completions/ghc
#
#
#


########################################
## EDITOR SETTINGS

# NOTE
# "The editor used to edit the commit log message will be chosen
#    from the GIT_EDITOR environment variable, the core.editor configuration
#    variable, the VISUAL environment variable, or the EDITOR environment
#    variable (in that order)."

if [ -x "$(command -v emacsclient)" ]; then
 export GIT_EDITOR=emacsclient
 export VISUAL=emacsclient
 export EDITOR=emacsclient
fi

########################################
## MISCELLANEOUS SETTINGS 

export BROWSER=firefox

########################################
## PATH SETTINGS

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# `stack` installs executables here
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi



# # the relative binary directory for nix-build
# # WARNING a relative path, for a more convenient `nix-build`
# export PATH=./result/bin:$PATH

########################################
## HISTORY SETTINGS

# don't put duplicate lines or lines starting with space in the history.
# HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1 # infinite # orig 1000
HISTFILESIZE=-1 # infinite # orig 2000
# export HISTFILESIZE=HISTSIZE=
HISTFILE=~/.bash_history_eternal # any `bash --norc` will truncate the default history file
PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND} ;}history -a; history -c; history -r; "
# PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

# NOTE
# the PROMPT_COMMAND is run before each prompt is shown, and before PS1 is computed
# history -a write history to HISTFILE after each command (the default is only on exit, it's kept in memory until)
# history -r read current history in HISTORY after each command (to be available to the current shell)
# history -c clears the current shell's current history

# PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND} ;}history -a; history -c; history -r;"
# make sure PROMPT_COMMAND isn't null (why?)

#########################################
## UBUNTU BASHRC DEFAULT SETTINGS

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# the focus in a terminal window
# should be on the output of commands, not on the prompt

# # if this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then

    if   test -r ~/.dircolors
    then eval "$(dircolors -b ~/.dircolors)"
    else eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091,SC1094
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    . /etc/bash_completion
  fi
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

########################################
## PROMPT SETTINGS

# https://stackoverflow.com/a/26759734/1337806
my_set_branch () {
 # if present and executable
 if [ -x "$(command -v __git_ps1)" ]; then
   BRANCH="$(__git_ps1 \(%s\))"
   # echo $BRANCH
 fi

# unless empty or unset
# shellcheck disable=SC2154 
# if [ -z "$__git_ps1" ]; then
}

my_prompt_command () {
 my_set_branch
}

PROMPT_COMMAND="my_prompt_command; $PROMPT_COMMAND"

# function my_get_branch {
#  # unless empty or unset
#  if [ -z "$__git_ps1" ]; then
#    "$(__git_ps1 \(%s\))"
#  fi
# }

#NOTE

# this sets the prompt to show the current directory
# later settings should preserve this as an infix:
#     PS1="...${PS1}..."

# GREEN="\\[$(tput setaf 2)\\]"
YELLOW="\\[$(tput setaf 3)\\]"
RESET="\\[$(tput sgr0)\\]"
PS1="\\n\${BRANCH}${YELLOW}\\w${RESET}\$ "

# PS1="\n(${GREEN}\u${RESET})${YELLOW}\w${RESET}\$ "
# PS1="\n(${GREEN}\u${RESET})${GREEN}\w${RESET}\$ "
# export PS1="\[\e]0;\w\a\]$PS1"

#NOTE
# under a darkroom'd monitor, yellow is visible while green is faint
# \${BRANCH}, with an escaped "$" via "\${...}, is a delayed substition

# e.g.
# GREEN="\[$(tput setaf 2)\]"
# RESET="\[$(tput sgr0)\]"
# export PS1="\n${GREEN}\w${RESET}\$ "

#NOTE `PROMPT_COMMAND` is faster than `PS1`

# # if this is an xterm, set the title to the `pwd`
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

### (too slow)
# # show current branch when in git repo (or descendent thereof)
# if [ -x "$(command -v git-radar)" ]; then
#   export PS1="\W\$(git-radar --bash --fetch) "
# fi

# NOTE
# `-x FILE` tests if the FILE is executable
# `command` is POSIX, and thus most portable

# NOTE
# requires `git-radar`

#NOTE
  # --fetch  # Fetches your repo asynchronously in the background every 5 mins
  # --bash   # Output prompt using Bash style color characters

# source ~/bin/git-prompt.sh
# PS1='\w$(__git_ps1 " (%s)") \$ '
# PS1="\n$PS1"

#########################################