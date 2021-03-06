##################################################
{ pkgs
, xdg
}:

# X11-Specific Initialization

##################################################
let
#-----------------------------------------------#

xbindkeys = ''${pkgs.xbindkeys}/bin/xbindkeys'';

#-----------------------------------------------#

xbindkeysrc = ''${xdg.configHome}/xbindkeys/.xbindkeysrc'';

#-----------------------------------------------#
in
##################################################

''
#-----------------------------------------------#
# X11 ------------------------------------------#
#-----------------------------------------------#

if  [ "_$XDG_SESSION_TYPE" = "_x11" ]

    # ^ Whether X11 is active.
    # i.e. versus Wayland or versus no window manager.

then

    #-----------------------------------------------#
    # xbindkeys ------------------------------------#
    #-----------------------------------------------#

    if [ -x "$(command -v ${xbindkeys})" ]

       # ^ Whether xbindkeys is present and executable.

    then

        if   ! pgrep -x "xbindkeys" > /dev/null

             # ^ Whether xbindkeys is already running.

        then
             if    [[ -f ${xbindkeysrc} && -r ${xbindkeysrc} ]]
             then "${xbindkeys}" --poll-rc --file ${xbindkeysrc}
             fi
        fi

    # ^ Start the « xbindkeys » daemon in the background.

    # ^ « --poll-rc » means: reload the config whenever it changes.

    # ^ « --file _ » means: load the given config ("rc") file.
    # By default, the config is at « ~/.xbindkeysrc »,
    # which we've overriden to be under (one of) « $XDG_CONFIG_DIRS ».

    fi

    #-----------------------------------------------#
    # setxkbmap ------------------------------------#
    #-----------------------------------------------#

    #TODO
fi
''

##################################################