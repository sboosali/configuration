# -*- mode: nix -*-

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

##################################################
# ①  Input #######################################
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
# ②  Utilities: Imports ##########################
##################################################
let

inherit (pkgs.stdenv) lib;

##################################################

env = {

  HOME = builtins.getEnv "HOME";

};

##################################################

haskellPackages   = (pkgs.haskellPackages);

haskellCompilers  = (pkgs.haskell.compiler);

in
##################################################
# ② Utilities: Nixpkgs ###########################
##################################################
let

addBuildInputs = extraBuildInputs: package:

  package.overrideAttrs (old:

    {
      buildInputs = old.buildInputs ++ extraBuildInputs;
    });

# ^ e.g.
#
# (addBuildInputs [ pkgs.git ] melpaPackages.magit) 
# 
# equals:
#
# (melpaPackages.magit.overrideAttrs (old: {
#     buildInputs = old.buildInputs ++ [ pkgs.git ];
#  }))
#

##################################################

in
##################################################
# ②  Utilities: sboo #############################
##################################################
let sboo = rec {
##################################################

paths = {

#home-manager = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;

};

##################################################

config = {

 allowUnfree = true; 
 allowBroken = false; 

};

##################################################

overlays = [

];

##################################################

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
 mesa
 ncdu
 #nix
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


##################################################

emacsPackages = epkgs: with epkgs; [

  use-package
  helm

  haskell-mode
  nix-mode

  projectile
  yasnippet

  (addBuildInputs [ pkgs.git ] melpaPackages.magit)

];

##################################################

colors.white = "rgb(255, 255, 255)";
colors.black = "rgb(0,   0,   0)";

colors.darkorchid = "rgb(153,50,204)";
#colors.lightgray = "rgb()";

##################################################

locations = {

  sanfrancisco.longitude = "38";
  sanfrancisco.latitude  = "122";

  boston.longitude = "42";
  boston.latitude  = "71";

};

##################################################

name = builtins.concatStringsSep " "

  [ "Sam" "Boosalis" ];

email = builtins.concatStringsSep ""

  ["sam" "boosalis" "@" "gmail" "." "com"];

# ^ TODO obfuscate more.

##################################################

keys.github = "SpirOS_git@github.com_id_rsa";

##################################################
};

##################################################

self = {

##################################################
# ③  Packages ####################################
##################################################

home.packages = sboo.programs;

##################################################

nixpkgs.config   = sboo.config;
nixpkgs.overlays = sboo.overlays;

##################################################
# ④  Programs ####################################
##################################################

programs.emacs = {
  enable = true;

  extraPackages = sboo.emacsPackages;
};

##############################################

programs.home-manager = {
  enable = true;
  path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
};

# ^ 
# 
# default `programs.home-manager.path` = ''"$HOME"/.config/nixpkgs/home-manager'' (???)
#
# 

##################################################

programs.bash.enable = true;

programs.bash.bashrcExtra =

  builtins.concatStringsSep "########################################\n\n"
#TODO${pkgs.terminfo}
    [ ''
      export TERMINFO_DIRS="$HOME/.nix-profile/share/terminfo":/lib/terminfo
      ''

      # ^ « tput » needs « terminfo » to identity « $TERM »
      # (i.e. the current terminal).

      # ^ TODO :"$TERMINFO"
      # ^ TODO « "./home-path/share/terminfo/x/xterm-termite" »

      (builtins.readFile ../../bash/.bash_definitions.sh)

      (builtins.readFile ../../bash/.bash_settings.sh)

      ''
      export LD_PRELOAD=
      ''
      # ^ (hacks)

    ];

# programs.bash.bashrcExtra = lib.mkBefore ''
# '';

# ^ « .bashrc » extras.
# 
# i.e. Extra commands that should be run when initializing an interactive shell.

programs.bash.profileExtra =

  builtins.concatStringsSep "########################################\n\n"

    [ (builtins.readFile ../bash/.profile)

       ''ssh-add ~/.ssh/${sboo.keys.github}
       ''
    ];

# ^ « .profile » extras.
# 
# i.e. Extra commands that should be run when initializing a login shell.

# ^ « ~/.profile » is executed by the command interpreter for Login Shells.
#
# NOTE `bash` ignores « ~/.profile » if either:
#
# * « ~/.bash_profile » exists, or
# * « ~/.bash_login » exists.
#

  # ^ TODO ${pkgs.ssh}??
  #      eval "$(${pkgs.ssh}/bin/ssh-agent -s)"
  #      {pkgs.ssh}/bin/ssh-add ~/.ssh/id_rsa

  # profileExtra = ''
  #   if ! pgrep -x "gpg-agent" > /dev/null; then
  #       ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
  #   fi
  # '';

programs.bash.shellOptions =
  [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" ];

# ^ Shell options to set.

programs.bash.shellAliases =
  (import ./home/shell-aliases.nix
          { inherit pkgs sboo; });

# ^ Attribute Set mapping aliases (the top-level Attribute Names in this option) either:
# 
# * to command strings, or
# * directly to build outputs.


programs.bash.sessionVariables = {};

# ^ Environment variables that will be set for the Bash session.

programs.bash.historyControl = [ "ignoredups" "ignorespace" ];

# ^ 
# `"ignoredups"`: ignore (consecutive) duplicate commands.
# `"ignorespace"`: ignore commands that begin with white space.

programs.bash.historyFile = ''"$HOME"/.bash_history'';

# ^ Location of the bash history file.

programs.bash.historyIgnore = [ "ls" "cd" "exit" ];

# ^ List of commands that should not be saved to the history list.

programs.bash.historySize = 100000;

# ^ Number of history lines to keep in memory.

programs.bash.historyFileSize = 1000000;

# ^ Number of history lines to keep on file.

programs.bash.enableAutojump = true;

# ^ Enable the `autojump` navigation tool.
# 
# See <https://github.com/wting/autojump>

/*
```sh
# `j` aliases `autojump`

$ j foo

# ^ `cd` to any (previously navigated to) directory whose path contains `foo`

$ jc foo 

# ^ `cd` to any child-directory whose path contains `foo`

$ jo foo

# ^ `open` (don't `cd` into) any (previously navigated to) directory whose path contains `foo`

$ jco 

# ^ `jc` + `jo`
```
*/

##################################################

# programs.chromium.enable = true;

# programs.chromium.extensions = [

#   "gcbommkclmclpchllfjekcdonpmejbdp" 
#   # ^ https everywhere

#   "cjpalhdlnbpafiamejdnhcphjbkeiagm"
#   # ^ ublock origin

#   ""
#   # ^
# ];

##############################################

programs.firefox = {
    enable = true;

    #enable = true;
};

##############################################

programs.git =

  (import ./home/git.nix
          { inherit pkgs sboo; })

   // { enable = true;
      };

##################################################

programs.ssh = #(import ./home/ssh.nix {inherit pkgs sboo;}) //
  { enable = true;
  };

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

programs.texlive = {
 enable = true;

 extraPackages = tpkgs: 
  { inherit (tpkgs) 
    collection-fontsrecommended 
    algorithms
    ;
 };

};

##################################################

programs.command-not-found.enable = true;

##################################################
# ⑤  Services ###################################
##################################################

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
# ⑥ Environment #################################
##################################################

home.sessionVariables =
  (import ./home/environment-variables.nix
          { inherit pkgs sboo;
            xdg = self.xdg;
          });

##################################################

home.keyboard.options = [ "grp:caps_toggle" "grp_led:scroll" ];

#TODO# home.keyboard.model = "pc104"

##################################################

xdg = {

 configHome = "${env.HOME}/.config";
 dataHome   = "${env.HOME}/.local/share";
 cacheHome  = "${env.HOME}/.cache";

} // {
  enable = true;
};

##################################################
};

in
##################################################
self
##################################################