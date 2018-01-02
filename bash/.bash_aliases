#!/bin/sh
# alias =''
alias aliases="source ~/.bash_aliases"
# alias aliases="source ~/.aliases"
alias profile="source ~/.profile"

# eDP-1-1 is name of the laptop screen (the first field)
# "Why is it called eDP? bcause it is an embedded display port style adapter, and not a video graphics array style one."
# 0x42 is the Identifier from `xrandr --verbose`
# alias red="xrandr --output 0x42 --crtc 0 --gamma "
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1" # restore default
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1"
alias red="redshift -O 1000" # one-shot, 1000K
alias un-red="redshift -x" # 
alias orange="redshift -O 2000" # one-shot

# Natural Language Commands

alias list="ls -1aFG"
alias remove="rm -f"
alias show="cat"
alias get="git"
alias grab="grep"
alias processes="ps aux"
# "ps -A -o \"command, pid, %mem, %cpu, user, start, \" "
# pstree
#alias processes="ps -cax -o \"command, pid, %mem, %cpu, user, start, \" "

# fish

# alias fishing="Max ~/.config/fish/config.fish"


# Emacs
# make bash function
# alias edit="emacsclient  --alternate-editor '/Applications/Server.app/Contents/MacOS/Emacs'  $argv"
# alias emacsserver="/Applications/Server.app/Contents/MacOS/Emacs --daemon=eserver"

# built-ins

alias c=cd
alias cd~="cd ~"
alias cd-="cd -"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."
alias cd.......="cd ../../../../../.."

alias ls="ls -aFG"
alias l="ls | cat"

alias rm="rm -f"
alias rmr="rm -rf"
alias rmt="rm -f *~ .*~ \#*\# .\#* matlab_crash_dump.* java.log.* *.pyc *.class __pycache__/*.pyc *.agdai *.hi *.hout *.o"

alias c7="chmod 700"

alias _ps="ps -A -o \"command, pid, %mem, %cpu, user, start, \" "

# programming languages

alias ip="ipython"
alias p="python3"
alias p3="python3"
alias p2="python2.7"

# alias pl="prolog -q -t 'main.' -s"

# working

alias r="grep -E --color=auto -i"

alias g="git"
alias gl="git status"
alias dif="git diff"
alias ga="git amend"
alias gorc="git status --porcelain | cut -d ' ' -f 2 | tr '\n' ' '"
#alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
#alias e="/usr/bin/emacs -nw"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# local config overrides global config
# if [ -f ~/config/local/.aliases ]
# then source ~/config/local/.aliases
# fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
