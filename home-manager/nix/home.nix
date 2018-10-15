# 
# cd ~/.config/nixpkgs/ && ln -sf ~/configuration/home-manager/nix/home.nix home.nix

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
# ②  Utilities ###################################
##################################################
let
##################################################

inherit (pkgs) lib;

##################################################

haskellPackages   = (pkgs.haskellPackages);

haskellCompilers  = (pkgs.haskell.compiler);

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



};

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

locations = {

  sanfrancisco.longitude = "38";
  sanfrancisco.latitude  = "122";

  boston.longitude = "42";
  boston.latitude  = "71";

};

##################################################

obfuscatedEmail = builtins.concatStringsSep "" ["sam" "boosalis" "@" "gmail" "." "com"];

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
# ④  Programs ####################################
##################################################

programs.emacs = {
    enable = true;

    extraPackages = epkgs: with epkgs; [

      use-package
      helm

      haskell-mode
      nix-mode

      projectile
      yasnippet
      magit

    ];
};

##############################################

programs.firefox = {
    enable = true;

    #enable = true;
};

##############################################

 programs.git = {
    enable = true;

    userName  = "Sam Boosalis";
    userEmail = sboo.obfuscatedEmail;
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
# ⑥ _ ############################################
##################################################

##################################################
}
