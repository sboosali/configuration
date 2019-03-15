##################################################
# Inputs #########################################
##################################################
{ pkgs

, sbooUtilities
, emacsUtilities
}:

#------------------------------------------------#

epkgs:

##################################################
# Output #########################################
##################################################

with sbooUtilities;

#------------------------------------------------#

with emacsUtilities;

##################################################
let
#------------------------------------------------#

coreEmacsPackages = with epkgs; [

  #----------------------------------------------#

  use-package
  bind-key
  diminish

  #----------------------------------------------#

  helm
  async
  popup
  lcr

  #----------------------------------------------#

  haskell-mode
  nix-mode

  #----------------------------------------------#

  projectile

  #----------------------------------------------#

  yasnippet

  #----------------------------------------------#

  flycheck

  #----------------------------------------------#

  magit

  #----------------------------------------------#

  wgrep                         # "Writeable GREP"

  # ^ https://github.com/mhayashi1120/Emacs-wgrep

  #----------------------------------------------#

];
#------------------------------------------------#

moreEmacsPackages = (with epkgs; [

 #----------------------------------------------#

 edit-env
 hexrgb
#awesome-tab

 #----------------------------------------------#

 pinentry

  # ^ 
  # This package allows GnuPG passphrase to be prompted through the
  # minibuffer instead of graphical dialog.
  #
  # To use, add "allow-emacs-pinentry" to "~/.gnupg/gpg-agent.conf",
  # reload the configuration with "gpgconf --reload gpg-agent", and
  # start the server with M-x pinentry-start.
  #
  # The actual communication path between the relevant components
  # is as follows:
  #
  #     gpg --> gpg-agent --> pinentry --> Emacs
  #
  # where pinentry and Emacs communicate through a Unix domain socket
  # created at:
  #
  #     ${TMPDIR-/tmp}/emacs$(id -u)/pinentry
  #
  # under the same directory which server.el uses.

 #----------------------------------------------#
 # Completion

 helm-dash
 helm-make
 helm-swoop
 helm-hayoo
 helm-gtags

 #company-yasnippet
 #company-abbrev
 #company-dabbrev

 company-ghc
 company-ghci
 company-cabal
 company-web
 company-restclient
 company-anaconda

 #----------------------------------------------#
 # Window/Buffer Management

#awesome-tab                    # Tabs
 shackle
 window-purpose

 #----------------------------------------------#
 # Appearence

 color-theme
 smooth-scrolling
 centered-cursor-mode

 #----------------------------------------------#
 # Haskell

#dante

#intero                         # needs `stack` system-package
#ghc                            # « ghc-mod »

 lsp-mode                       # for « haskell-ide-engine »
 lsp-ui                         # for « haskell-ide-engine »
 lsp-haskell                    # for « haskell-ide-engine »

 #----------------------------------------------#
 # Bookmarks

 bm                             # visual bookmarks

 #----------------------------------------------#
 # Desktops

#desktopPlus

 #----------------------------------------------#
 # Editing

 expand-region
 # ^ Expand selection to strings, definitions, words, lines, paragraphs, etc.

 page-break-lines
 # ^ Convert the ^L (form feed) chars to horizontal lines

 wrap-region
 # ^ Wrap selection with punctuations, tags (org-mode, markdown-mode, ..)

 deft                           # « Notational Velocity » port
 # ^ Quick note taking and management

 edit-indirect

 #----------------------------------------------#
 # FileSystem

 dired-collapse # from the « dired-hacks » megarepo
 dired-filter   # from the « dired-hacks » megarepo
#dired-list     # from the « dired-hacks » megarepo
 dired-open     # from the « dired-hacks » megarepo
 dired-rainbow  # from the « dired-hacks » megarepo
#dired-ranger   # from the « dired-hacks » megarepo
 dired-sidebar  # from the « dired-hacks » megarepo
 dired-subtree  # from the « dired-hacks » megarepo

 #----------------------------------------------#
 # Formats

 markdown-mode 
 json-mode
 yaml-mode

 restclient

 #----------------------------------------------#
 # Lisp

#paredit

 #----------------------------------------------#

 modalka
 # ^ https://github.com/mrkkrp/modalka/blob/master/README.md

 ##god-mode
 ##evil

 #----------------------------------------------#
 # Python

 anaconda-mode

 #----------------------------------------------#
 # Development

 #magit          # <C-x g>
 magit-annex
 magithub
#github-pullrequest             # FIXME

 ggtags

 direnv         # needs `direnv` system-package
 neotree

 multi-term

 #----------------------------------------------#

 anzu   
 # ^ shows total search hits in mode line.
 # c.f. `query-replace`.

 # csv-nav
 #  # ^ editing csv files

 #any-ini-mode # EmacsWiki only

 #----------------------------------------------#

 epc
 elnode
 #emacs-web-server
 
 #----------------------------------------------#

#ranger

 #----------------------------------------------#

 move-text
 treemacs

 #----------------------------------------------#

 request
 # ^ https://tkf.github.io/emacs-request/manual.html

 #----------------------------------------------#

 palimpsest

 #----------------------------------------------#

 which-key
 # ^ https://github.com/justbur/emacs-which-key/blob/master/README.org

 #----------------------------------------------#

 ov

 #----------------------------------------------#

 volatile-highlights

 #----------------------------------------------#

 #TODO# objed

 #TODO# graphviz-dot

hungry-delete

webpaste
imgbb

 #TODO# elisp-ffi

 vlf                            # abbreviates "View Large Files"

 #----------------------------------------------#

]);

#------------------------------------------------#

themeEmacsPackages = with epkgs; [

 solarized-theme #TODO

];

#------------------------------------------------#
in
##################################################

builtins.concatLists

  [
    coreEmacsPackages
    moreEmacsPackages
  # themeEmacsPackages
  ]

##################################################