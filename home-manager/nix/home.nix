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

  #TODO# sboo prefix?

  # Personal Configuration:

, minimalInstallation ? null
, maximalInstallation ? null

, platformLinux       ? false
, platformDarwin      ? false

, onlyEmacsPackages   ? false
, onlySystemPrograms  ? false

  # ^ (these booleans are forwarded from attributes in « home-attrs.nix »,
  #    via « home-manager -A ... ».)

#TODO# logic for both « only*{Programs,Libraries} », for testing, and « install*{Programs,Libraries} », for configuration:

# , installEmacsPackages   ? false
# , installSystemPrograms  ? false

, ...
}:

#------------------------------------------------#

##################################################
# Bootstrap ######################################
##################################################
let
#-----------------------------------------------#

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

options = {

  minimal  = nullbool maximalInstallation (nullbool minimalInstallation false);

  platform = if platformLinux then "linux" else if platformDarwin then "darwin" else (stdenv.targetPlatform.parsed.kernel.name or "unspecified");

  libraries = builtins.concat [ (lib.optionals onlyEmacsPackages "emacs")   ]; # TODO installHaskellPrograms
  programs  = builtins.concat [ (lib.optionals onlySystemPrograms "system") ]; # TODO installHaskellLibraries

};

# ^ Personal options.

/* NOTE:

« currentSystem » includes both Operating System and Architecture.

  > builtins.currentSystem
    "x86_64-linux"

« stdenv »'s « .*{build,target}Platform.parsed » has structured-data:

  > stdenv.targetPlatform.parsed.kernel.name
    "linux"

 */

#-----------------------------------------------#

/* Nullable Boolean.
 *
 * Nix « nullbool b x » is like Haskell « maybe x id b »
 *
 */

nullbool = b: x:
  assert (b == null || builtins.isBool b);

  if b != null then b else x;

#-----------------------------------------------#

/* Nullable value.
 *
 * Nix « nullor x y » is like Haskell « maybe y id x »
 *
 */

nullor = x: y:
  assert (x != null && y != null) -> (builtins.typeOf x == builtins.typeOf y);

  if x != null then x else y;

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
    inherit options;
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

  #fonts.fontconfig.enable = true;
  #OBSOLETE:# fonts.fontconfig.enableProfileFonts = true;

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

 systemd.user.startServices = true;

 # ^ 
 #   ① Start all services that are wanted by active targets.
 #   ② Stop obsolete services, from the previous generation.
 #

#systemd.user.timers = { };

# “Definition of systemd per-user timer units.”

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

##################################################