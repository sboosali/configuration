# -*- mode: nix -*-

##################################################
# Parameters #####################################
##################################################

{ pkgs ? (import ./nixpkgs {}).pkgs

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
#-----------------------------------------------#

inherit (pkgs.stdenv) lib;

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

emacs = import ./emacs { inherit pkgs; };

#-----------------------------------------------#

haskell = import ./haskell { inherit pkgs; };

#-----------------------------------------------#

# haskellPackages   = (pkgs.haskellPackages);
# haskellCompilers  = (pkgs.haskell.compiler);

#-----------------------------------------------#
in
##################################################
# The Home-Manager Configuration #################
##################################################

with utilities;

##################################################
let 
#-----------------------------------------------#

configFile = path:

  "${self.xdg.configHome}/${path}";

#------------------------------------------------#

dataFile = path:

  "${self.xdg.dataHome}/${path}";

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

  #----------------------------------------------#

  nixpkgs.config   = import ./config;
  nixpkgs.overlays = []; #import ./overlays { whitelist = [ "emacs" ]; };

  # nixpkgs.config   = {};
  # nixpkgs.overlays = [];

  #----------------------------------------------#

  home.sessionVariables = shell.environmentVariables;

  #----------------------------------------------#

  home.file = (import ./home/files.nix { inherit pkgs; })
          # // (import ./home/auto.nix  { inherit pkgs; })
            ;

  #----------------------------------------------#
  # Programs:

  home.packages = [

    (import ./packages.nix  { inherit pkgs sboo; })
    (import ./libraries.nix { inherit pkgs; })
    haskell.compilers
    haskell.packages

  ];

  #----------------------------------------------#

  #TODO posthook = '' ${cabal} new-update '';

  #----------------------------------------------#

  programs = import ./programs.nix {
    inherit pkgs lib sboo xdg applications utilities;
  };

  #----------------------------------------------#

  services = import ./services.nix {
    inherit pkgs sboo;
  };

  #----------------------------------------------#
  # Keyboard:

  home.keyboard = import ./home/keyboard.nix {};

  #----------------------------------------------#
  # Fonts:

  fonts.fontconfig.enableProfileFonts = true;

  #----------------------------------------------#
  # GTK Appearence/Behavior:

  gtk =
    (import ./gtk { inherit pkgs sboo;
                  })
     // { enable = false;
        };

  ##############################################
  # « X Resources »

  xresources.properties =
    (import ./home/xresources.nix {
    });

  #----------------------------------------------#
  # XDG:

  xdg =
    (import ./xdg { inherit sboo applications;
                  })
     // { enable = true;
        };

  #----------------------------------------------#

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

##################################################