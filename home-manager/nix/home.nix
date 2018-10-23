# -*- mode: nix -*-

##################################################
# Parameters #####################################
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
# Bootstrap ######################################
##################################################
let

in
##################################################
# Imports ########################################
##################################################
let

inherit (pkgs.stdenv) lib;

##################################################

config = {

 allowUnfree = true; 
 allowBroken = false; 

};

##################################################

overlays = [

];

##################################################

utilities =
  import ./home/utilities.nix
         { inherit lib; };

##################################################

sboo = import ./home/sboo.nix { inherit (utilities) env; };

##################################################

haskell = import ./haskell { inherit pkgs; };

##################################################

# haskellPackages   = (pkgs.haskellPackages);
# haskellCompilers  = (pkgs.haskell.compiler);

in
##################################################
# The Home-Manager Configuration #################
##################################################

with utilities;

##################################################
let 

configFile = path:

  "${self.xdg.configHome}/${path}";

##################################################

dataFile = path:

  "${self.xdg.dataHome}/${path}";

##################################################

self = {

##################################################

nixpkgs.config   = config;
nixpkgs.overlays = overlays; #TODO ../overlays

##############################################

programs.home-manager.enable = true;
programs.home-manager.path   =
  https://github.com/rycee/home-manager/archive/release-18.09.tar.gz;
  # ../../submodules/home-manager/

# ^ 

##################################################

home.sessionVariables =
  (import ./home/environment-variables.nix
          { inherit pkgs sboo;
            inherit (self) xdg;
          });

##################################################

home.file = import ./home/files.nix { inherit pkgs; };

##################################################

home.keyboard.options = [ "ctrl:nocaps" ];

# ^ « grp:caps_switch »:
# Caps Lock (while pressed), Alt+Caps Lock does the original capslock action.

#TODO# home.keyboard.model = "pc104"

##################################################
# Programs:

home.packages
   = (import ./home/programs.nix { inherit pkgs sboo; })
  ++ [ haskell.ghcs
     ];

home.extraOutputsToInstall = [ "bin" "dev" "man" "info" "doc" ];

##################################################
# XDG:

xdg =
  (import ./xdg { inherit env;
                })
   // { enable = true;
      };

##################################################

programs.emacs =

  (import ./emacs
          { inherit pkgs utilities;
          })

   // { enable = true;
      };

##################################################

programs.git =

  (import ./git
          { inherit pkgs sboo;
          })

   // { enable = true;
      };

##################################################

programs.ssh =

  (import ./home/ssh.nix
          { inherit pkgs sboo;
            inherit (self) xdg;
          })

   // { enable = true;
      };

##################################################

programs.bash =

  (import ./bash
          { inherit pkgs sboo env;
            inherit (self) xdg;
          })

   // { enable = true;
      };

##############################################

programs.firefox = {
    enable = true;

    #enable = true;
};

##################################################

programs.chromium.enable = true;

programs.chromium.extensions = [

  "gcbommkclmclpchllfjekcdonpmejbdp" 
  # ^ https everywhere

  "cjpalhdlnbpafiamejdnhcphjbkeiagm"
  # ^ ublock origin

  #""
  # ^
];

##############################################

programs.termite.enable = true;

# ^ TERMite is a terminal-emulator, and is:
# 
# * is minimal 
# * is VTE-based 
# * has modal UI (i.e. like Vim)
# * 
# 
# See « https://wiki.archlinux.org/index.php/termite ».

# large-font & black-on-white:

programs.termite.font = "Monospace 24";

# the Font Description,
# i.e. Font Family (which should be a monospace font) and Font Size.

programs.termite.foregroundColor = sboo.colors.black;
programs.termite.backgroundColor = sboo.colors.white;

# the BackgroundColor
# should look soft under `xrandr-invert-colors`.
# (like purple-gray?)

#"rgba(192, 64, 192, 0.95)";

programs.termite.clickableUrl = true; 

# Whether Auto-detected URLs can be clicked on,
# to open them in your browser (if a browser is configured or detected.)

programs.termite.dynamicTitle = true; 

# Whether the shell can update the terminal's title.

programs.termite.fullscreen = true;

# Enables entering fullscreen mode by pressing F11.

programs.termite.scrollOnKeystroke = true;

# Scroll to the bottom automatically when a key is pressed.

programs.termite.scrollbar = "left";

# Position and presence of the scrollbar.
#
# Type: null or one of "off", "left", "right"

programs.termite.urgentOnBell = true;

# Sets the window as urgent on the terminal bell.

programs.termite.allowBold = true;

# Whether the terminal-emulator outputs bold characters,
# when the stdout outputs the bold escape-sequence.

programs.termite.browser = 
''${pkgs.xdg_utils}/xdg-open'';

# Set the default browser for opening links. 
# 
# If it's not set, $BROWSER is read.
# If that too isn't set, url hints will be disabled.
#
# e.g.:
#       programs.termite.browser = ''${pkgs.xdg_utils}/xdg-open'';
#

programs.termite.audibleBell = false;

##################################################

programs.htop.enable = true;

##################################################

programs.feh = {
 enable = true;
};
 
##################################################

programs.texlive = {
 enable = true;

 extraPackages = tpkgs: 
  { inherit (tpkgs)
    resumecls
    resumemac
    collection-fontsrecommended 
    algorithms
    ;
 };

};

##################################################

programs.command-not-found.enable = true;

##################################################
# Services:

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

};

in
##################################################

self

##################################################
# Notes ##########################################
##################################################

# Installation:
#
# mkdir -p ~/.config/nixpkgs/ && cd ~/.config/nixpkgs/ && ln -sf ~/configuration/home-manager/nix/home.nix home.nix
#

# See:
#
# * https://rycee.gitlab.io/home-manager/options.html
# * https://github.com/rycee/home-manager#readme
# * https://nixos.wiki/wiki/Home_Manager
# * https://rycee.net/posts/2017-07-02-manage-your-home-with-nix.html
# * 

# See:
#
# $ man home-configuration.nix 
# $

# See:
#
# * ../REAMDE.md

##################################################