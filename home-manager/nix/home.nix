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

, platformLinux       ? true
, platformDarwin      ? false

, minimalInstallation ? false
, maximalInstallation ? true

, onlyEmacsPackages   ? false
, onlySystemPrograms  ? false

  #TODO# sboo prefix

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

  home.packages = [

    (import ./packages.nix  { inherit pkgs sboo; })
    (import ./libraries.nix { inherit pkgs; })
    haskell.compilers
    haskell.packages

  ];

  #----------------------------#

  #TODO posthook = '' ${cabal} new-update '';

  #----------------------------#

  programs = import ./programs.nix
  {
    inherit pkgs lib;
    inherit sboo xdg applications;
    inherit utilities xdgUtilities;
  };

  #----------------------------#

  services = import ./services.nix {
    inherit pkgs sboo;
  };

  #----------------------------#

  manual.html.enable = true;

  #----------------------------#
  # Keyboard:

  home.keyboard = import ./home/keyboard.nix {};

  #----------------------------#
  # Fonts:

  fonts.fontconfig.enableProfileFonts = true;

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

  # xresources.extraConfig = builtins.readFile (if sboo.dark
  #   then /usr/share/xfce4/terminal/colorschemes/solarized-light.theme
  #   else /usr/share/xfce4/terminal/colorschemes/solarized-dark.theme;
  # );

  # xresources.extraConfig = builtins.readFile (if sboo.dark
  #   then ../../submodules/solarized-xresources/Xresources.dark
  #   else ../../submodules/solarized-xresources/Xresources.light
  # );

 #----------------------------#

  # language.base     = enUS;      # « $LANG »
  # language.address  = enUS_UTF8; # « $LC_ADDRESS »
  # language.monetary = enUS_UTF8; # « $LC_MONETARY »
  # language.paper    = enUS_UTF8; # « $LC_PAPER »
  # language.time     = enUS_UTF8; # « $LC_TIME »

  #----------------------------#
  # XDG:

  xdg =
    (import ./xdg { inherit pkgs;
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

##################################################