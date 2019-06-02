# -*- mode: nix -*-
##################################################
# Parameters #####################################
##################################################

{ nixpkgs  ? ./nixpkgs
, config   ? {}
, overlays ? []
, pkgs     ? (import nixpkgs { inherit config overlays; })

, platformLinux       ? false
, platformDarwin      ? false

, ...
}:

##################################################
# Constants ######################################
##################################################
let
#-----------------------------------------------#

onlyFiles = true;

#-----------------------------------------------#
in
##################################################
# Imports ########################################
##################################################
let
#-----------------------------------------------#

inherit (pkgs.stdenv) lib;
inherit (pkgs)        stdenv;

#-----------------------------------------------#

utilities =
  import ./home/utilities.nix
         {
           inherit pkgs lib;
         };

#-----------------------------------------------#

sboo = import ./sboo { };

#-----------------------------------------------#

applications = import ./applications {
 #TODO emacs = emacs;
};

#-----------------------------------------------#

enUS      = "en_US";
enUS_UTF8 = "en_US.UTF-8";

#-----------------------------------------------#
in
##################################################
# The Home-Manager Configuration #################
##################################################

with utilities;

##################################################
let
#-----------------------------------------------#

asXdgConfigPath = path:

  let
  path' = builtins.toString path;
  in

  ''${self.xdg.configHome}/${path'}'';

#------------------------------------------------#

asXdgDataPath = path:

  let
  path' = builtins.toString path;
  in

  ''${self.xdg.dataHome}/${path'}'';

#-----------------------------------------------#

asXdgCachePath = path:

  let
  path' = builtins.toString path;
  in

  ''${self.xdg.cacheHome}/${path'}'';

#-----------------------------------------------#

xdgUtilities = {

 inherit asXdgConfigPath asXdgDataPath asXdgCachePath;

};

#-----------------------------------------------#

shell =
  import ./shell
         {
           inherit pkgs lib;
           inherit sboo applications;
           inherit (self) xdg;
         };

#-----------------------------------------------#

self = rec {

  #----------------------------#

  nixpkgs.config   = import ./config;
  nixpkgs.overlays = []; #import ./overlays { whitelist = [ "emacs" ]; };

  # nixpkgs.config   = {};
  # nixpkgs.overlays = [];

  #----------------------------#

  home.sessionVariables = shell.environmentVariables;

  #----------------------------#

  home.file = (import ./home/files.nix { inherit pkgs xdg; })
          # // (import ./home/auto.nix  { inherit pkgs; })
            ;

  #----------------------------#
  # Programs:

  home.packages = [ ];

  #----------------------------#

  #TODO posthook = '' ${cabal} new-update '';

  #----------------------------#

  programs.bash =

    (import ./bash
            {
              inherit pkgs lib;
              inherit sboo xdg applications onlyFiles;
              inherit xdgUtilities;
            })

     // { enable = true;
        };

  #----------------------------#

  manual.html.enable = true;

  #----------------------------#
  # Keyboard:

  home.keyboard = import ./home/keyboard.nix {};

  #----------------------------#
  # GTK Appearence/Behavior:

  gtk =
    (import ./gtk { inherit pkgs sboo;
                  })
     // { enable = false;
        };

  #----------------------------#
  # « X Resources »

  xresources.properties = import ./home/xresources.nix { };

  xresources.extraConfig =

   let
   themePath =
        if   sboo.dark
        then /usr/share/xfce4/terminal/colorschemes/solarized-light.theme
        else /usr/share/xfce4/terminal/colorschemes/solarized-dark.theme;

   themeString =
        if   builtins.pathExists themePath
        then builtins.readFile themePath
        else "";

   in themeString;

 #----------------------------#

  # language.base     = enUS;      # « $LANG »
  # language.address  = enUS_UTF8; # « $LC_ADDRESS »
  # language.monetary = enUS_UTF8; # « $LC_MONETARY »
  # language.paper    = enUS_UTF8; # « $LC_PAPER »
  # language.time     = enUS_UTF8; # « $LC_TIME »

  #----------------------------#
  # XDG:

  xdg =
    (import ./xdg { inherit pkgs lib;
                    inherit sboo applications xdgUtilities;
                  })
     // { enable = true;
        };

  #----------------------------#

};

#-----------------------------------------------#
in
##################################################

self

##################################################
# Notes ##########################################
##################################################

# Installation:
#
# mkdir -p ~/.config/nixpkgs/ && cd ~/.config/nixpkgs/ && ln -sf ~/configuration/home-manager/nix/home.nix home.nix
#

# See:
#
# * https://rycee.gitlab.io/home-manager/options.html
# * https://github.com/rycee/home-manager#readme
# * https://nixos.wiki/wiki/Home_Manager
# * https://rycee.net/posts/2017-07-02-manage-your-home-with-nix.html
# * 

# See:
#
# $ man home-configuration.nix 
# $

# See:
#
# * ../REAMDE.md

#------------------------------------------------#
# EOF -------------------------------------------#
#------------------------------------------------#

# Local Variables:
# compile-command: "home-manager -v -f ~/configuration/home-manager/nix/home-files.nix -A default build"
# End:
