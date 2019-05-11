##################################################
{ self }:

##################################################

with self; 

##################################################
let
#------------------------------------------------#

haskell-overridez =
  let
  version = "0.10.3.1";
  notes   = "https://github.com/adetokunbo/haskell-overridez#readme";
 in
  builtins.fetchTarball {
    url    = "https://github.com/adetokunbo/haskell-overridez/archive/v${version}.tar.gz";
    sha256 = "1w2pv96bdf16nc1vvh03acx37qq4h4hrz2y979a705i70z8h59lk"; # via « nix-prefetch-url »
  };

# /nix/store/qjq8scb0y89nsq2shk3a8pf3sr70hpp0-ghcjs-8.6.0.1

#------------------------------------------------#

#TODO# aspellWithDicts []             # Spell-Checker + Dictionaries.
#  aspellDicts.en-science
#  aspellDicts.en-computer

 # aspell
 # aspellDicts.en
 # aspellDicts.en-computers
 # aspellDicts.en-science

#------------------------------------------------#
in
##################################################
[

 arcanist
 bash-completion
 cabal-install                  # Comment-out to use development-version « cabal-install-2.5.0.0 » in « ~/.cabal/bin ».
 cabal2nix
 bat                            # a cat(1) clone with "wings" (i.e. syntax highlighting and Git integration.) « https://github.com/sharkdp/bat »
 bfg-repo-cleaner               # « bfg » (reverse acronym of « git-filter-branch »). « https://help.github.com/en/articles/removing-sensitive-data-from-a-repository »
 borgbackup                     # « borg » Backup.
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
 guile                          # « Scheme » implementation (v2.2.4, circa 2019)
 guile-lint                     # 
 haskell-overridez
 htop
#hunspell                       # Spell-Checker ("hunspell" abbreviates "HUNgarian SPELL-checker")
 imagemagick
 inotify-tools
 jq
 killall                        # « killall ».
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
#pandoc
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
 swiProlog                      # Prolog compiler.
 tmux
 tree
 unzip
 vlc
 wmctrl
 xautomation
#xbindkeys
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

 nodejs                         # JS Interpreter
 html-tidy                      # HTML Linter
 csslint                        # CSS Linter
 shellcheck                     # Bash Linter

#global                         # GNU Global (a.k.a. « gtags »)

#nixfmt
#terminfo
#VirtualBox-GuestAdditions
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
#xprop
#xsel-unstable
#styx                           # https://styx-static.github.io/styx-site/

]
##################################################

# ^ NOTE we must omit the `programs._` programs:
#
# * emacs26
# * git
# * firefox
# * ...
#
# from the `home.packages = _` programs.
#
