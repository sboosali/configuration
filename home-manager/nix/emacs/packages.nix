##################################################
# Inputs #########################################
##################################################
{ pkgs
, lib

, utilities
, options
}:

#------------------------------------------------#

epkgs:

##################################################
# Output #########################################
##################################################

with utilities;

##################################################
let
#------------------------------------------------#

coreEmacsPackages = with epkgs; [

  #----------------------------------------------#

# use-package
  bind-key
  diminish
  delight

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

  # ^ Mode for « grep ».
  # ^ https://github.com/mhayashi1120/Emacs-wgrep

  #----------------------------------------------#

];
#------------------------------------------------#

moreEmacsPackages = [

 #----------------------------------------------#

 (epkgs.sidebar             or null)            # https://github.com/sebastiencs/sidebar.el
 (epkgs.edit-env            or null)
 (epkgs.hexrgb              or null)
#awesome-tab

 #----------------------------------------------#

 (epkgs.pinentry            or null)

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

 (epkgs.helm-dash            or null)
 (epkgs.helm-make            or null)
 (epkgs.helm-swoop           or null)
 (epkgs.helm-navi            or null)           # https://github.com/emacs-helm/helm-navi
 (epkgs.helm-hayoo           or null)

 (epkgs.company-ghc          or null)
 (epkgs.company-ghci         or null)
 (epkgs.company-cabal        or null)
 (epkgs.company-web          or null)
 (epkgs.company-restclient   or null)
 (epkgs.company-anaconda     or null)

 #company-yasnippet
 #company-abbrev
 #company-dabbrev

 #----------------------------------------------#
 # Templates

 #----------------------------------------------#
 # Window/Buffer Management

#(epkgs.awesome-tab          or null)   # « https://github.com/manateelazycat/awesome-tab ». Tabs.
 (epkgs.shackle              or null)
 (epkgs.window-purpose       or null)

 #----------------------------------------------#
 # Appearence

 (epkgs.color-theme          or null)
 (epkgs.smooth-scrolling     or null)
 (epkgs.centered-cursor-mode or null)
 (epkgs.telephone-line       or null)   # Modeline.
#spaceline                              # Modeline.
#doom-modeline                          # Modeline.

#all-the-icons                          # https://github.com/domtronn/all-the-icons.el
#all-the-icons-dired                    # https://github.com/jtbm37/all-the-icons-dired
#icons-in-terminal                      # https://github.com/sebastiencs/icons-in-terminal

 #----------------------------------------------#
 # Haskell

#dante

 (epkgs.intero              or null)    # needs `stack` system-package
#ghc                                    # « ghc-mod » # NOTE it's been DEPRECATED for « haskell-ide-engine ».

 (epkgs.lsp-mode            or null)    # for « haskell-ide-engine »
 (epkgs.lsp-ui              or null)    # for « haskell-ide-engine »
 (epkgs.lsp-haskell         or null)    # for « haskell-ide-engine »

 #----------------------------------------------#
 # Editing:

 (epkgs.wrap-region          or null)
 # ^ Wrap selection with punctuations, tags (org-mode, markdown-mode, ..)
 #   « https://github.com/rejeep/wrap-region.el »

 (epkgs.expand-region        or null)
 # ^ Expand selection to strings, definitions, words, lines, paragraphs, etc.

 (epkgs.sed-mode       or null)
 # ^ Mode for « sed ».

 (epkgs.deft                 or null)   # « Notational Velocity » port
 # ^ Quick note taking and management

 (epkgs.edit-indirect        or null)

 (epkgs.simpleclip           or null)

 (epkgs.page-break-lines     or null)
 # ^ Convert the ^L (form feed) chars to horizontal lines

 #----------------------------------------------#
 # FileSystem:

 (epkgs.dired-collapse       or null)   # from the « dired-hacks » megarepo.
 (epkgs.dired-filter         or null)   # from the « dired-hacks » megarepo.
#(epkgs.dired-list           or null)   # from the « dired-hacks » megarepo.
 (epkgs.dired-open           or null)   # from the « dired-hacks » megarepo.
 (epkgs.dired-rainbow        or null)   # from the « dired-hacks » megarepo.
#(epkgs.dired-ranger         or null)   # from the « dired-hacks » megarepo.
 (epkgs.dired-sidebar        or null)   # from the « dired-hacks » megarepo.
 (epkgs.dired-subtree        or null)   # from the « dired-hacks » megarepo.

 (epkgs.peep-dired           or null)   # « https://github.com/asok/peep-dired ». c.f. « ranger ».
 (epkgs.neotree              or null)

 #----------------------------------------------#
 # Formats:

 (epkgs.markdown-mode        or null)   # « .md » files.
 (epkgs.json-mode            or null)   # « .json » files.
 (epkgs.yaml-mode            or null)   # « .yaml » files.
 (epkgs.restclient           or null)   # « POST ... » “files”.

 #----------------------------------------------#
 # « prog-mode »s

 (epkgs.rainbow-delimeters   or null)
 (epkgs.rainbow-blocks       or null)

 (epkgs.highlight-numbers          or null)
 (epkgs.highlight-quoted           or null)
 (epkgs.highlight-escape-sequences or null)

 #----------------------------------------------#
 # Lisp

 (epkgs.package-lint         or null)   # Linter for Library Headers of Emacs Packages.
 (epkgs.flycheck-package     or null)   # Flycheck « package-lint ».
 (epkgs.modalka              or null)   # « https://github.com/mrkkrp/modalka/blob/master/README.md »

#paredit

 #----------------------------------------------#
 # Python

 (epkgs.anaconda-mode        or null)

 #----------------------------------------------#
 # Development

 #magit                                 # <C-x g>
 (epkgs.magit-annex        or null)
#(epkgs.magithub           or null) #TODO addTool git 
#(epkgs.github-pullrequest or null) #TODO addTool git 

 (epkgs.direnv               or null)   # needs `direnv` system-package
 (epkgs.multi-term           or null)

 (epkgs.pandoc-mode          or null)

 #----------------------------------------------#
 # Media:

 (epkgs.pdf-tool or null)               # « .pdf ».

 #----------------------------------------------#
 # External Packages which extend Internal Packages:

 (epkgs.bm                   or null)   # extends `bookmark'. visual bookmarks.
 (epkgs.desktopPlus          or null)   # extends `desktop'.

 #-----------------------------#
 # Tools:

 (epkgs.pass or null)                   # TUI for « pass ».

 #----------------------------------------------#
 # Dependencies

 (epkgs.navi                 or null)   # https://github.com/alphapapa/navi
 (epkgs.outshine             or null)   # https://github.com/alphapapa/outshine

 #----------------------------------------------#
 # Miscellaneous

 (epkgs.anzu                 or null)   # shows total search hits in mode line (c.f. `query-replace`).
 (epkgs.desktop-environment  or null) # « https://github.com/DamienCassou/desktop-environment/ »
 (epkgs.eimp                 or null)
 (epkgs.elfeed               or null)
 (epkgs.elnode               or null)
 (epkgs.epc                  or null)
 (epkgs.hungry-delete        or null)
 (epkgs.imgbb                or null)
 (epkgs.move-text            or null)
 (epkgs.ov                   or null)
 (epkgs.request              or null)   # « https://tkf.github.io/emacs-request/manual.html »
 (epkgs.rg                   or null)
 (epkgs.vlf                  or null)   # « https://github.com/m00natic/vlfi ». « vlf » abbreviates "View Large Files".
 (epkgs.volatile-highlights  or null) # 
 (epkgs.webpaste             or null)
 (epkgs.quack                or null)
 (epkgs.which-key            or null)   # « https://github.com/justbur/emacs-which-key/blob/master/README.org »

 #TODO# graphviz-dot
 #any-ini-mode # EmacsWiki only
 #csv-nav # editing CSV files
 #emacs-web-server
 #TODO# elisp-ffi
 #TODO# objed
 #palimpsest
 #ranger

 #-----------------------------#
 # EmacsWiki:

 (epkgs.rainbow-mode         or null)                   # Visualize Hex strings, CSS color syntax, X11 color names, etc. « http://elpa.gnu.org/packages/rainbow-mode.html »
 (epkgs.grab-and-drag        or null)
 (epkgs.better-registers     or null)

 #-----------------------------#
 
];

# ^ the « pkgs._ or null » form supports extremely-optional packages.

#------------------------------------------------#

themeEmacsPackages = [

 (epkgs.solarized-theme or null)

];

#------------------------------------------------#
in
##################################################

builtins.concatLists

  [
    coreEmacsPackages
    (lib.optionals (! options.minimal) moreEmacsPackages)
  # themeEmacsPackages
  ]

##################################################
