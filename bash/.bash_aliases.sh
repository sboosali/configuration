#!/bin/bash

# NOTE
# these aliases reference `bash` (i.e. non-`sh`) commands,
# and many reference functions defined in `.bash_definitions.sh`.

#########################################

alias t=brush
alias tx=brush-executable

# override the `d*` aliases,
# with `cd` becoming my `cd-ls`.

alias d=cd-ls
alias d-="cd-ls -"
alias d..="cd-ls .."
alias d...="cd-ls ../.."
alias d....="cd-ls ../../.."
alias d.....="cd-ls ../../../.."
alias d......="cd-ls ../../../../.."
alias d.......="cd-ls ../../../../../.."
alias de='cd-ls ~/.emacs.d'
alias dew='cd-ls ~/.emacs.d-windows'
alias dc='cd-ls ~/configuration'
alias dh='cd-ls ~/haskell'
alias dt='cd-ls ~/temporary'
alias db='cd-ls ~/backup'
alias dw='cd-ls ~/Downloads'
alias dm='cd-ls ~/Documents'
alias dn='cd-ls ~/notes'
alias dx='cd-ls ~/nixpkgs'
#alias dnix='cd-ls ~/.nixpkgs'
#alias dn='cd-ls ~/Dropbox/notes'
# alias d='cd-ls '
# alias d='cd-ls '

alias raise-editor="raise-emacs"
alias path=absolute-path

alias screen-invert="xrandr-invert-colors"
alias screen-day="redshift -x ; xrandr-invert-colors"
alias screen-white="redshift -x"
alias screen-red="redshift -x && redshift -O 1000"
alias screen-scarlet="redshift -x && redshift -O 1500"
alias screen-orange="redshift -x && redshift -O 2000"
alias screen-yellow="redshift -x && redshift -O 3000"
alias screen-warm="redshift -x && redshift -O 9000"
# alias red="xrandr --output 0x42 --crtc 0 --gamma "
alias screen-night="screen-brighter--via-xdotool 20 ; redshift -x ; redshift -O 1000 ; xrandr-invert-colors"
alias screen-night-dim="screen-brighter--via-xdotool 20 ; redshift -x ; redshift -O 1000 ; xrandr-invert-colors ; screen-dimmer--via-xdotool 10"
alias screen-dusk="screen-brighter--via-xdotool 20 ; redshift -x ; redshift -O 2000 ; xrandr-invert-colors"

alias xsi=screen-invert # {X}11-{I}nvert
alias xsn=screen-night  # {X}11-{N}ight
alias xsd=screen-day    # {X}11-{D}ay
alias xsu=screen-dusk   # {X}11-D{u}sk
alias xsr=screen-red    # {X}11-{R}ed
alias xsw=screen-white  # {X}11-{W}hite
                        #NOTE# xw=wmctrl
alias xsy=screen-yellow # {X}11-{Y}ellow

alias red="redshift -O 1000" # one-shot, 1000K
alias scarlet="redshift -O 1500" # one-shot
alias orange="redshift -O 2000" # one-shot
alias yellow="redshift -O 3000" # one-shot
alias white="redshift -x" # 
alias un-red="redshift -x" #

#########################################