##################################################
{ pkgs

#, sboo
, xdg
}:
##################################################
{

 #-----------------------------#

#TODO#
# ".xinitrc".source     = import ./xinitrc.nix { inherit pkgs xdg; };
# ".xinitrc".executable = true;

#TODO#
# ".Xmodmap".source     = import ./xmodmap.nix { inherit pkgs xdg; };

 #-----------------------------#

 ".aliases".source          = ../../../bash/aliases;
 ".bash_aliases".source     = ../../../bash/bash_aliases;
 ".bash_definitions".source = ../../../bash/bash_definitions;
 ".bash_settings".source    = ../../../bash/bash_settings;

 #-----------------------------#

 ".fonts".source    = ../../../fonts;
 ".fonts".recursive = true;

 #-----------------------------#

 ".ghci".source = ../../haskell/dot-ghci.hs;

 #-----------------------------#

 ".stack/config.yaml".source = ../../../stack/config.yaml;

 #-----------------------------#

# ".nix-channels".source = ../nix-channels.txt;

 #-----------------------------#

# TODO for VirtualBox, create the shared folder:
 "guests/Windows10Dragon15/README.md".source = ../../../virtual-machines/Windows10Dragon15/files/README.md;

 #-----------------------------#

# ".mozilla/firefox/profiles.ini".source = ../../mozilla/firefox/profiles.ini;

 #-----------------------------#

 #-----------------------------#

}
##################################################