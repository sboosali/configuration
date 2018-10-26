##################################################
{ pkgs

, sboo

, haskellPackages   ? (pkgs.haskellPackages)
, haskellCompilers  ? (pkgs.haskell.compiler)

}:

##################################################
let

self  = pkgs;
super = pkgs;

in
##################################################
let

sbooPrograms = super.buildEnv
 {
   name                  = "sboo-programs";

   paths                 = programs;
   pathsToLink           = [ "/" "/bin" ];
   extraOutputsToInstall = [ "out" "bin" "man" "info" ];

   ignoreCollisions      = true;
 };

##################################################

programs =
     freePrograms
 #++ unfreePrograms
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

unfreePrograms = with self; [

 google-chrome

];

##################################################

systemPrograms = with self; [

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
 #nix-prefetch-git            # subsumed within « nix-prefetch-scripts ».
 nix-prefetch-github
 nix-prefetch-scripts
#nixfmt
 nox
 openssh
 pandoc
 pocketsphinx
 postgresql
 qbittorrent
 redshift
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
 xkbd
 #xkeyboard-config

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

xorgPrograms = with self.xorg; [

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
sbooPrograms
##################################################