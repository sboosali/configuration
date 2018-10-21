##################################################
{ pkgs

, sboo

, haskellPackages   ? (pkgs.haskellPackages)
, haskellCompilers  ? (pkgs.haskell.compiler)

}:
##################################################
let

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
 #mesa
 nano
 ncdu
 #nix
 #nix-derivation-pretty
 nix-bash-completions
 nix-prefetch-git
 nix-prefetch-github
 nix-prefetch-scripts
#nixfmt
 nox
 openssh
 pandoc
 pocketsphinx
 postgresql
 qbittorrent
 shellcheck
 signal-desktop
 sox
 stack
#terminfo
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

#melpaPackages.ov

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

in
##################################################
programs
##################################################