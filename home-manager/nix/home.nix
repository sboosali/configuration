# -*- mode: nix -*-

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

##################################################
# ①  Input #######################################
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
# ②  Utilities: Imports ##########################
##################################################
let

inherit (pkgs) lib;

##################################################

haskellPackages   = (pkgs.haskellPackages);

haskellCompilers  = (pkgs.haskell.compiler);

in
##################################################
# ② Utilities: Nixpkgs ###########################
##################################################
let

addBuildInputs = extraBuildInputs: package:

  package.overrideAttrs (old:

    {
      buildInputs = old.buildInputs ++ extraBuildInputs;
    });

# ^ e.g.
#
# (addBuildInputs [ pkgs.git ] melpaPackages.magit) 
# 
# equals:
#
# (melpaPackages.magit.overrideAttrs (old: {
#     buildInputs = old.buildInputs ++ [ pkgs.git ];
#  }))
#

##################################################

in
##################################################
# ②  Utilities: sboo #############################
##################################################
let sboo = rec {
##################################################

paths = {

  home-manager = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;

};

##################################################

config = {

 allowUnfree = true; 
 allowBroken = false; 

};

##################################################

overlays = [

];

##################################################

programs = freePrograms
#       ++ unfreePrograms
         ;

##################################################

freePrograms = builtins.concatLists [

  systemPrograms
  haskellPrograms
  haskellCompilerPrograms
  xorgPrograms

];

# systemPrograms ++ haskellPrograms ++ haskellCompilerPrograms ++ xorgPrograms;

##################################################

unfreePrograms = with pkgs; [

 google-chrome

];

##################################################

systemPrograms = with pkgs; [

 bash-completion
 cabal-install
 cabal2nix
 #cask
 colordiff
 #dconf-editor
 dex
 dhall
 #emacs
 #emacs2nix
 #melpa2nix
 expect
 feh
 flac
 fltk
 #fsnotify
 fswatch
 ghc
 gimp
 glib
 gparted
 graphviz
 htop
 imagemagick
 inotify-tools
 jq
 mesa
 ncdu
 #nix
 #nix-derivation-pretty
 nix-prefetch-git
 nox
 pandoc
 pocketsphinx
 postgresql
 qbittorrent
 shellcheck
 signal-desktop
 sox
 stack
 tmux
 tree
 unzip
 #VirtualBox-GuestAdditions
 vlc
 wmctrl
 youtube-dl
 
 xautomation
 #xbacklight
 xbindkeys
 xbrightness
 xcalib
 xclip
 xdg_utils
 xdotool
 #xinput
 xinput_calibrator
 xkbmon
 #xmodmap
 #xprop
 xrandr-invert-colors
 #xsel-unstable
 xtitle
 xvkbd

];

# ^ NOTE we must omit the `programs._` programs:
#
# * emacs26
# * git
# * firefox
# * ...
#
# from the `home.packages = _` programs.
#

########################################

xorgPrograms = with pkgs.xorg; [

 xprop

];

##################################################

haskellPrograms = with haskellPackages; [

 ghcid
 git-annex

];

##################################################

haskellCompilerPrograms = with haskellCompilers; [

 ghcjs

];


##################################################

emacsPackages = epkgs: with epkgs; [

  use-package
  helm

  haskell-mode
  nix-mode

  projectile
  yasnippet

  (addBuildInputs [ pkgs.git ] melpaPackages.magit)

];


##################################################

locations = {

  sanfrancisco.longitude = "38";
  sanfrancisco.latitude  = "122";

  boston.longitude = "42";
  boston.latitude  = "71";

};

##################################################

name = builtins.concatStringsSep " "

  [ "Sam" "Boosalis" ];

email = builtins.concatStringsSep ""

  ["sam" "boosalis" "@" "gmail" "." "com"];

# ^ TODO obfuscate more.

##################################################
};

in
##################################################
{
##################################################
# ③  Packages ####################################
##################################################

home.packages = sboo.programs;

##################################################

nixpkgs.config   = sboo.config;
nixpkgs.overlays = sboo.overlays;

##################################################
# ④  Programs ####################################
##################################################

programs.emacs = {
  enable = true;

  extraPackages = sboo.emacsPackages;
};

##############################################

programs.home-manager = {
  enable = true;

  path = sboo.paths.home-manager;
};

# ^ 
# 
# default `programs.home-manager.path` = ''"$HOME"/.config/nixpkgs/home-manager'' (???)
#
# 

##################################################

# programs.bash = {

#   enable = true;

# };

##################################################

# programs.chromium.enable = true;

# programs.chromium.extensions = [

#   "gcbommkclmclpchllfjekcdonpmejbdp" 
#   # ^ https everywhere

#   "cjpalhdlnbpafiamejdnhcphjbkeiagm"
#   # ^ ublock origin

#   ""
#   # ^
# ];

##############################################

programs.firefox = {
    enable = true;

    #enable = true;
};

##############################################

programs.git = {
    enable = true;

    userName  = sboo.name;
    userEmail = sboo.email;
};

##################################################

programs.ssh.enable = true;

##############################################

programs.termite.enable = true; 

programs.termite.font = "Monospace 48";

# the Font Description, i.e. Font Family (which should be a monospace font) and Font Size.

programs.termite.clickableUrl = true; 

# Whether Auto-detected URLs can be clicked on to open them in your browser (if a browser is configured or detected.)

programs.termite.dynamicTitle = true; 


# Setting dynamic title allows the terminal and the shell to update the terminal's title.

programs.termite.fullscreen = true;

# Enables entering fullscreen mode by pressing F11.

programs.termite.scrollOnKeystroke = true;

# Scroll to the bottom automatically when a key is pressed.

programs.termite.scrollbar = "left";

# position and presence of the scrollbar.
# Type: null or one of "off", "left", "right"

programs.termite.urgentOnBell = true;

# Sets the window as urgent on the terminal bell.

##################################################

programs.htop.enable = true;

##################################################

programs.texlive = {
 enable = true;

 extraPackages = tpkgs: 
  { inherit (tpkgs) 
    collection-fontsrecommended 
    algorithms
    ;
 };

};

##################################################

programs.command-not-found.enable = true;

##################################################
# ⑤  Services ###################################
##################################################

services.redshift = {
    enable = true;

    provider  = "manual";
    inherit (sboo.locations.boston) longitude latitude;

#    provider  = "manual";
#    longitude = "42";
#    latitude  = "71";

    temperature.night  = 1000;
    temperature.day    = 20000;

    # ^ kelvins.
    # min 1000 (red), max 25000 (blue).

    brightness.night  = "0.9";
    brightness.day    = "1.0";

    # ^ fraction.
    # min 0.1 (dim, 10%), max 1.0 (bright, 100%).
};

##################################################

#TODO# services.gpg-agent = {
#    enable = true;
#
#    defaultCacheTtl = 1800;
#    enableSshSupport = true;
#};

##################################################

#TODO# services.ssh-agent = {
#    enable = true;
#
# };

##################################################
# ⑥ Environment #################################
##################################################

home.sessionVariables = { 

 EDITOR = "emacs"; 

 GS_OPTIONS = "-sPAPERSIZE=a4";

 SBOO_CONFIGURATION_DIR = ''"$HOME"/configuration'';
 SBOO_EMACS_DIR = ''"$HOME"/.emacs.d'';
 SBOO_HASKELL_DIR = ''"$HOME"/haskell'';
 SBOO_ELISP_DIR = ''"$HOME"/elisp'';
 SBOO_EMACS = ''"$HOME"/.emacs.d/result/bin/emacs'';

};

##################################################

home.keyboard.options = [ "grp:caps_toggle" "grp_led:scroll" ];

#TODO# home.keyboard.model = "pc104"

##################################################
}
