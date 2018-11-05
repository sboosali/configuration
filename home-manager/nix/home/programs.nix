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
  ++ unfreePrograms
     ;

##################################################

freePrograms = builtins.concatLists [

  systemPrograms
  haskellPrograms
  haskellCompilerPrograms
  xorgPrograms
  x11Programs

];

# systemPrograms ++ haskellPrograms ++ haskellCompilerPrograms ++ xorgPrograms;

##################################################

unfreePrograms = with self; [

 idea  # "IntelliJ IDEA"

#google-chrome

];

##################################################

systemPrograms = with self; [

 bash-completion
 cabal-install
 cabal2nix
 colordiff
 dex
 dhall
 expect
 feh
 flac
 fltk
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
 #mdless
 nano
 ncdu
 nix-bash-completions
 nix-prefetch-github
 nix-prefetch-scripts
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
 tmux
 tree
 unzip
 vlc
 wmctrl
 xautomation
 xbindkeys
 xbrightness
 xcalib
 xclip
 xdg_utils
 xdotool
 xinput_calibrator
 xkbd
 xkbmon
 xrandr-invert-colors
 xtitle
 xvkbd
 youtube-dl

 #nixfmt
 #terminfo
 #VirtualBox-GuestAdditions
 #cask
 #dconf-editor
 #emacs
 #emacs2nix
 #fsnotify
 #melpa2nix
 #mesa
 #nix
 #nix-derivation-pretty
 #nix-prefetch-git            # subsumed within « nix-prefetch-scripts ».
 #xbacklight
 #xinput
 #xkeyboard-config
 #xmodmap
 #xprop
 #xsel-unstable

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

##################################################

x11Programs = with pkgs.xlibs; [

 xbacklight

];

########################################

xorgPrograms = with self.xorg; [

 xinput
 xmessage
 xmodmap
 xprop

];

##################################################

haskellPrograms = with haskellPackages; [

 ghcid
 hpack
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