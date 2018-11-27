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

 ".fonts".source    = ../../../fonts;
 ".fonts".recursive = true;

 #################################################

 ".ghci".source = ../../haskell/dot-ghci.hs;

 #################################################

 ".stack/config.yaml".source = ../../../stack/config.yaml;

 #################################################

# ".xinitrc".source     = ./xinitrc.nix;
# ".xinitrc".executable = true;

 #################################################

# ".nix-channels".source = ../nix-channels.txt;

 #################################################

}
##################################################