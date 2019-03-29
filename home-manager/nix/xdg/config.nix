##################################################
{ sboo
, applications
, xdgUtilities
}:

##################################################
let
#------------------------------------------------#

xbindkeys   = "xbindkeys";
xbindkeysrc = xdgUtilities.asXdgConfigPath "xbindkeys/xbindkeysrc.scm";

# xbindkeysrc = xdgUtilities.asXdgConfigPath "xbindkeys/.xbindkeysrc"
# xbindkeysrc = xdgUtilities.asXdgConfigPath "xbindkeys/xbindkeysrc.scm"

#------------------------------------------------#
in
##################################################
{
  #----------------------------#

 "nix/nix.conf".source = ../../configs/nix.conf;

  #----------------------------#

 "xfce4/terminal/terminalrc".source = if sboo.dark
    then ../../../submodules/xfce4-terminal-colors-solarized/dark-high-contrast/terminalrc
    else ../../../submodules/xfce4-terminal-colors-solarized/light/terminalrc;

  #----------------------------#

 "cabal/config".text                 = import ../cabal/cabal-global.project.nix {};
#"stack/config.yaml".source = ../../../stack/config.yaml; #TODO

  #----------------------------#

 "xbindkeys/xbindkeysrc.scm".source   = ../../../xbindkeys/test.scm;
 "xbindkeys/xbindkeysrc.scm".onChange = ''
    
         # Whether « ${xbindkeys} » is installed:
    
    if   [ -x "$(command -v ${xbindkeys})" ]
    then
    
         # Whether « ${xbindkeys} » is running:
    
    if   pgrep -x "xbindkeys" > /dev/null
    
    then # Reload the config:
    
         kill -s1 $(pgrep "xbindkeys")
    
    else # Start the daemon:
    
         ${xbindkeys} --poll-rc -fg ${xbindkeysrc}
    
    fi
    fi
    
    # ^ Start the « xbindkeys » daemon in the background.
    
    # ^ « --poll-rc » means: reload the config whenever it changes.
    
    # ^ « -fg _ » means: load the given config (a Guile File).
    # By default, the config is at « ~/.xbindkeysrc »,
    # which we've overriden to be under « $XDG_CONFIG_HOME ».
  '';

  #----------------------------#

 "gtk-3.0/settings.ini".source       = ../../gtk/3/settings.ini;
 "gtk-3.0/bookmarks".source          = ../../gtk/3/bookmarks;
 "gtk-2.0/gtkfilechooser.ini".source = ../../gtk/2/gtkfilechooser.ini;

  #----------------------------#

 "autostart/dropbox.desktop".source  = ../../desktop/dropbox.desktop;
 "autostart/firefox.desktop".source  = ../../desktop/firefox.desktop;
#TODO "autostart/terminal.desktop".source  = ../../desktop/terminal.desktop;
#"autostart/.desktop".source  = ../../desktop/.desktop;

  # ^ All desktop-entry-files under « ~/.config/autostart/ » are launched upon first login.

  #----------------------------#

#------------------------------------------------#
} // (if applications.emacs.autostart then {

  "autostart/emacs.desktop".text = applications.emacs.desktop;

#------------------------------------------------#
} else {}) // {

}
##################################################

#"xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" = ../../../xfce4/xsettings.xml;

#TODO onChange
