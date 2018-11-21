##################################################
# Inputs #########################################
##################################################
{ pkgs
, utilities
}:

##################################################

epkgs:

##################################################
# Output #########################################
##################################################
let

themes = with epkgs; [

 solarized-theme #TODO

];

in
##################################################

with utilities;

##################################################

with epkgs; [

  ################################################

  use-package
  bind-key
  diminish

  ################################################

  helm
  async
  popup

  ################################################

  haskell-mode

  ################################################

  nix-mode

  ################################################

  projectile

  ################################################

  yasnippet

  ################################################

  (addBuildInputs [ pkgs.git ] melpaPackages.magit)

  ################################################

  org

  ################################################

  wgrep
  # ^ https://github.com/mhayashi1120/Emacs-wgrep

  ################################################

]

 #################################################

 ++ (with melpaPackages; [ #TODO

 #company-yasnippet
 #company-abbrev
 #company-dabbrev

 company-ghc
 company-ghci
 company-cabal
 company-web
 company-restclient
 company-anaconda

 ####################

 ghc
 dante

 ##intero          # needs `stack` system-package

 ####################

 anaconda-mode

 ####################

 tabbar
 shackle
 window-purpose

 ####################

 color-theme
 smooth-scrolling
 centered-cursor-mode

 ####################

 paredit

 ####################

 #magit          # <C-x g>

 direnv         # needs `direnv` system-package
 neotree
 wgrep

 multi-term

 markdown-mode 
 edit-indirect

 ####################

 json-mode
 yaml-mode

 restclient

 ####################

 helm-dash
 helm-make
 helm-swoop
 helm-hayoo

 ####################

 modalka
 # ^ https://github.com/mrkkrp/modalka/blob/master/README.md

 ##god-mode
 ##evil

 ########################

 anzu   
 # ^ shows total search hits in mode line.
 # c.f. `query-replace`.

 bm 
 # ^ visual bookmarks

 # csv-nav
 #  # ^ editing csv files

 deft
 # ^ quick note taking and management

 expand-region

 page-break-lines
 # ^ Convert the ^L (form feed) chars to horizontal lines

 wrap-region
 # ^ wrap selection with punctuations, tags (org-mode, markdown-mode, ..)

 yaml-mode

 #any-ini-mode # EmacsWiki only

 ########################

 epc
 elnode
 #emacs-web-server
 
 ########################
 # for haskell-ide-engine:

 lsp-mode
 lsp-ui 
 lsp-haskell

 ########################

 ranger

 ########################
 # from the "dired-hacks" megarepo:

 dired-filter
 dired-open
 dired-rainbow
 dired-subtree
 dired-ranger
 #dired-list
 dired-collapse

 ########################

 move-text
 treemacs
 tabbar-ruler

 ########################

 request
 # ^ https://tkf.github.io/emacs-request/manual.html

 ########################

 palimpsest

 ########################

 which-key
 # ^ https://github.com/justbur/emacs-which-key/blob/master/README.org

 ########################

 ov

 ########################

 volatile-highlights

 ########################

 #TODO objed 

 ])

 ++ themes
##################################################