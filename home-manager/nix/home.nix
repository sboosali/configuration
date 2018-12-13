# -*- mode: nix -*-

##################################################
# Parameters #####################################
##################################################

{ pkgs

# , haskellPackages   ? (pkgs.haskellPackages)
# , haskellCompilers  ? (pkgs.haskell.compiler)
# 
# , emacsPackages     ? (pkgs.emacs26Packages)
# , melpaPackages     ? (pkgs.emacs26PackagesNg)

, ...
}:

##################################################
# Bootstrap ######################################
##################################################
let

in
##################################################
# Imports ########################################
##################################################
let

inherit (pkgs.stdenv) lib;

##################################################

config = {

 allowUnfree = true; 
 allowBroken = false; 

};

##################################################

overlays = [

];

##################################################

utilities =
  import ./home/utilities.nix
         { inherit lib; };

##################################################

sboo = import ./sboo { inherit (utilities) env; };

##################################################

haskell = import ./haskell { inherit pkgs; };

##################################################

# haskellPackages   = (pkgs.haskellPackages);
# haskellCompilers  = (pkgs.haskell.compiler);

in
##################################################
# The Home-Manager Configuration #################
##################################################

with utilities;

##################################################
let 

configFile = path:

  "${self.xdg.configHome}/${path}";

##################################################

dataFile = path:

  "${self.xdg.dataHome}/${path}";

##################################################

self = rec {

  ################################################

  nixpkgs.config   = config;
  nixpkgs.overlays = overlays; #TODO ../overlays

  ################################################

  home.sessionVariables =
    (import ./home/environment-variables.nix
            { inherit pkgs sboo;
              inherit xdg;
            });

  ################################################

  home.file = (import ./home/files.nix { inherit pkgs; })
          # // (import ./home/auto.nix  { inherit pkgs; })
            ;

  ################################################
  # Programs:

  home.packages = [

    (import ./packages.nix  { inherit pkgs sboo; })
    (import ./libraries.nix { inherit pkgs; })
    haskell.compilers
    haskell.packages

  ];

  ################################################

  home.keyboard.options = [ "ctrl:nocaps" ];

  # ^ « grp:caps_switch »:
  # Caps Lock (while pressed), Alt+Caps Lock does the original capslock action.

  #TODO# home.keyboard.model = "pc104"

  ################################################

  #TODO posthook = '' ${cabal} new-update '';

  ################################################

  programs = import ./programs.nix { inherit pkgs sboo xdg env utilities; };

  ################################################

  services = import ./services.nix { inherit pkgs sboo; };

  ################################################
  # Fonts:

  fonts.fontconfig.enableProfileFonts = true;

  ################################################
  # GTK Appearence/Behavior:

  gtk =
    (import ./gtk { inherit pkgs sboo env;
                  })
     // { enable = false;
        };

  ################################################
  # XDG:

  xdg =
    (import ./xdg { inherit env;
                  })
     // { enable = true;
        };

  ##############################################

};

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

##################################################