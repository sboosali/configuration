##################################################
{ pkgs }:

##################################################

with pkgs; 

##################################################
[

 arcanist
 bash-completion
 cabal-install                # Comment-out to use development-version « cabal-install-2.5.0.0 » in « ~/.cabal/bin ».
 cabal2nix
 emacs26Packages.cask
 colordiff
 dex
 dhall
 expect
 ffmpeg
 flac
 fltk
 fswatch
#ghc                            # see ../haskell/compilers.nix
 gimp
 glib
 gparted
 gnupg22                        # for « gpg » version ≥2.1.17
 graphviz                       # GraphViz renders « .dot » files.
 htop
 imagemagick
 inotify-tools
 jq
 libreoffice
 markdown-pp
 #markdown-merge
 mplayer # exes: « mplayer », « mencoder »
 #mdless
 multimarkdown
 nano
 ncdu
 nix
 nix-bash-completions
 nix-info
 nix-prefetch-github
 nix-prefetch-scripts
 nixnote2                       # NixNote is an unofficial Evernote client.
 nox
 openssh
 pandoc
 pass
 pinta                          # Pinta is a simple image-editor.
 pocketsphinx
 postgresql
 qbittorrent
 redshift
 replace  # command
 ripgrep
 shellcheck
 signal-desktop
 sox
 stack
 styx                           # https://styx-static.github.io/styx-site/
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
 libxml2

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

]
##################################################