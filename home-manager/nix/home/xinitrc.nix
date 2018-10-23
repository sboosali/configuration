##################################################
{ pkgs
, xdg
}:

##################################################
let

xbindkeys  = ''${pkgs.xbindkeys}/bin/xbindkeys'';
#TODO setxkbmap = ''${pkgs.}/bin/setxkbmap'';

##################################################

xbindkeysrc = ''${xdg.configHome}/xbindkeys/.xbindkeysrc'';

##################################################

startxfce4 = ''/usr/bin/startxfce4'';

# ^ NOTE « startxfce4 » has been installed with
# « sudo apt install xubuntu-desktop », **not** from nixpkgs,

in
##################################################

''
#!/bin/sh
########################################



########################################

setxkbmap -option "ctrl:nocaps" || true

# ^ « ctrl:nocaps »: Use Caps Lock as Control key.

########################################

#TODO {xmodmap} ~/.Xmodmap || true

########################################

if [ -x "$(command -v ${xbindkeys})" ] #TODO and if x11 is active
then

if   ! pgrep -x "xbindkeys" > /dev/null
then "${xbindkeys}" --poll-rc -f "${xbindkeysrc}" || true
fi

# ^ Start the « xbindkeys » daemon in the background.

# ^ « --poll-rc » means: reload the config whenever it changes.

# ^ « -f _ » means: load the given config ("rc") file.
# By default, the config is at « ~/.xbindkeysrc », 
# which we've overriden to be under (one of) « $XDG_CONFIG_DIRS ».

fi

########################################

exec ${startxfce4}

########################################
''