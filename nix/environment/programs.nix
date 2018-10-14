##################################################
{ nixpkgs

, haskellPackages   ? (nixpkgs.haskellPackages)
, haskellCompilers  ? (nixpkgs.haskell.compiler)

, emacsPackages     ? (nixpkgs.emacs26Packages)
, melpaPackages     ? (nixpkgs.emacs26PackagesNg)

}:

##################################################
let
##################################################

programs =

  systemPrograms ++ haskellPrograms ++ haskellCompilerPrograms ++ xorgPrograms;

##################################################

haskellCompilerPrograms = with haskellCompilers; [

ghcjs

];

##################################################

haskellPrograms = with haskellPackages; [

ghcid
git-annex

];

##################################################

systemPrograms = with nixpkgs; [

bash-completion
cabal-install
cabal2nix
#cask
colordiff
chromium
#dconf-editor
dex
dhall
#emacs
emacs26
#emacs2nix
#melpa2nix
expect
feh
firefox
flac
fltk
#fsnotify
fswatch
ghc
gimp
git
glib
google-chrome
gparted
graphviz
htop
imagemagick
inotify-tools
jq
mesa
nix
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

##################################################

xorgPrograms = with nixpkgs.xorg; [

#rgb
xprop

];

##################################################
in
##################################################
#
##################################################
let
##################################################

libraries =

  systemLibraries ++ haskellLibraries ++ emacsLibraries;

##################################################

systemLibraries = with nixpkgs; [

libjpeg
libnotify
#libX11
#libXrandr
lmdb

#X11
#x11-xinput
#X11-xshape

];

##################################################

haskellLibraries = with haskellPackages; [

spiros
lens

];

##################################################

#emacsLibraries = with emacsPackages.melpaStablePackages; [

emacsLibraries = (with emacsPackages; [

#colorThemes
#haskellMode #NOTE# broken
xmlRpc

]) ++ (with melpaPackages; [

helm
use-package

]);

##################################################
in
##################################################

programs ++ libraries

##################################################

