##################################################
{ pkgs

#, sboo

}:
##################################################
{

 #################################################

 ".aliases".source          = ../../../bash/aliases;
 ".bash_aliases".source     = ../../../bash/bash_aliases;
 ".bash_definitions".source = ../../../bash/bash_definitions;
 ".bash_settings".source    = ../../../bash/bash_settings;

 #################################################

 ".local/share/applications/emacs.desktop".source = ../../../desktop-entry-files/emacs.desktop;

 #################################################

 

 #################################################

#".xinitrc".source = ../../../x11/xinitrc;

}
##################################################