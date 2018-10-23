##################################################
{ pkgs
, xdg
, sboo

, bashUtilities
}:

##################################################

bashUtilities.concatBashScripts

    [ (builtins.readFile ../../bash/profile.sh)

       ###########################################

      (builtins.readFile ../../../bash/aliases)
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)

       ###########################################

       # ''
       # #-----------------------------------------------#
       # # xbindkeys ------------------------------------#
       # #-----------------------------------------------#

       # if [ -x "$(command -v ${pkgs.xbindkeys}/bin/xbindkeys)" ] 
       #    #TODO and if x11 is active
       # then

       # if   ! pgrep -x "xbindkeys" > /dev/null
       # then "${pkgs.xbindkeys}/bin/xbindkeys" --poll-rc -f "${xdg.configHome}/xbindkeys/.xbindkeysrc"
       # fi

       #     # ^ Start the « xbindkeys » daemon in the background.

       #     # ^ « --poll-rc » means: reload the config whenever it changes.

       #     # ^ « -f _ » means: load the given config ("rc") file.
       #     # By default, the config is at « ~/.xbindkeysrc », 
       #     # which we've overriden to be under (one of) « $XDG_CONFIG_DIRS ».

       # fi
       # ''

       ###########################################

       ''
       #-----------------------------------------------#
       # ssh-agent ------------------------------------#
       #-----------------------------------------------#

       if [ -x "$(command -v ${pkgs.openssh}/bin/ssh-agent)" ]
       then

       if   ! pgrep -x "ssh-agent" > /dev/null
       then eval "$(${pkgs.openssh}/bin/ssh-agent -s)"
       fi

           # ^ Start the « ssh-agent » in the background.

           if [ -f "~/.ssh/${sboo.keys.github}" ]
           then
               "${pkgs.openssh}/bin/ssh-add" ~/.ssh/${sboo.keys.github}
           fi

           # ^ Register my GitHub (@sboosali) key, via « ssh-agent ».
       fi
       ''

       ###########################################
]

# ^ TODO 
# profileExtra = ''
#   if ! pgrep -x "gpg-agent" > /dev/null; then
#       ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
#   fi
# '';

##################################################
