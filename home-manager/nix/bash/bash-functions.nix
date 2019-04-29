##################################################
{ pkgs
, lib

, sboo

}:
##################################################
let
#------------------------------------------------#

env = {

  HOME = builtins.getEnv "HOME";

};

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

mkdir       = ''${pkgs.coreutils}/bin/mkdir'';
chmod       = ''${pkgs.coreutils}/bin/chmod'';

find        = ''${pkgs.findutils}/bin/find'';
xargs       = ''${pkgs.findutils}/bin/xargs'';

nix-shell   = "nix-shell"; #TODO# ''${pkgs.nix}/bin/nix-shell''
 #TODO3 or... keep "dynamic" (not lexical) to use the same nix that must be installed for home-manager to evaluate this very file
nix-store = "nix-store";

tar         = "tar"; #TODO# ''${pkgs.tar}/bin/tar'';
sed         = "sed"; #TODO# ''${pkgs.coreutils?}/bin/sed'';
grep        = "grep"; #TODO# ''${pkgs.??}/bin/grep'';

git         = ''${pkgs.git}/bin/git'';

xev         = "xev"; #TODO# ''${pkgs.xev}/bin/xev'';
xclip       = ''${pkgs.xclip}/bin/xclip'';
xdotool     = ''${pkgs.xdotool}/bin/xdotool'';
wmctrl      = ''${pkgs.wmctrl}/bin/wmctrl'';
xbrightness = ''${pkgs.xbrightness}/bin/xbrightness'';
xbindkeys   = ''${pkgs.xbindkeys}/bin/xbindkeys'';
#xmodmap    = ''${pkgs.xmodmap}/bin/xmodmap'';

xrandr               = ''${xrandr}/bin/xrandr'';
xrandr-invert-colors = ''${pkgs.xrandr-invert-colors}/bin/xrandr-invert-colors'';

xdg-open     = ''${pkgs.xdg_utils}/bin/xdg-open'';
# xdg-mime     = ''${pkgs.xdg_utils}/bin/xdg-mime'';
# xdg-settings = ''${pkgs.xdg_utils}/bin/xdg-settings'';

xprop       = ''${pkgs.xorg.xprop}/bin/xprop'';

redshift   = ''${pkgs.redshift}/bin/redshift'';

#------------------------------------------------#

#TODO configure between [1] the package's program and [2] the vendored submodule's program with environment-variable like SBOO_HOME_MANAGER_CABAL

cabal      = ''${pkgs.cabal-install}/bin/cabal'';

#------------------------------------------------#

NIX_PROFILE = "~/.nix-profile";
NIXPKGS     = "${env.HOME}/nixpkgs";

#NixProfile = "${env.HOME}/.nix-profile";
#NixProfile = "${env.HOME}/.nix-profile";

#------------------------------------------------#

xterm-set-title = title: ''

  echo -e -n "\033]2;${title}\007"

  '';

#------------------------------------------------#

xdotool-send-lines = lines:

  (builtins.concatStringsSep " && "
    (builtins.map xdotool-send-line
      lines));

#------------------------------------------------#

#TODO# bash escape line

xdotool-send-line = line:

  let

  line' = lib.strings.escapeShellArg line;

  in

  ''${xdotool} type --clearmodifiers ${line'} && ${xdotool} key --clearmodifiers Return'';

#------------------------------------------------#



#------------------------------------------------#
in
##################################################
{
  ################################################

  sboo-nix-repl =

    let

    prelude = ''

      nixpkgs = import <nixpkgs> {}
      pkgs    = nixpkgs.pkgs

      b = builtins
      c = nixpkgs.config
      l = nixpkgs.lib

      :a nixpkgs
      :a nixpkgs.lib

      haskell = pkgs.haskell
      h       = pkgs.haskell.lib
      ghcs    = pkgs.haskell.compilers
      hs      = pkgs.haskellPackages
      hs86    = pkgs.haskell.packages.ghc863

      es    = pkgs.emacsPackagesNgGen pkgs.emacs26
      es26  = es
      melpa = es.melpaPackages

      py   = pkgs.python27Packages
      py27 = py

      js = pkgs.nodePackages

      self  = pkgs
      super = pkgs

    '';

      # es25 = pkgs.emacsPackagesNgGen pkgs.emacs26
      # melpaBuild = pkgs.emacs26Packages.emacsMelpa.melpaBuild
      # melpa      = pkgs.emacs26Packages.emacsMelpa

      # js10 = pkgs.nodePackages_10_x

      # xfce  = pkgs.xfce
      # xfceu = pkgs.xfceUnstable

      # sboo        = pkgs.sboo
      # sbooHaskell = pkgs.sboo.haskellPackages

    lines =

      (builtins.filter isStringNotBlank
        (lib.splitString "\n" prelude));

    isStringNotBlank = s:

      (builtins.any isCharNotBlank
        (lib.stringToCharacters s));

    isCharNotBlank = c:

      (builtins.elem c whitespaceCharacters);

    whitespaceCharacters =

      (lib.stringToCharacters " \t\r\n");

    in

''

 ${xterm-set-title "nix repl"}

 read -r -d '''''' NIX_REPL_EXAMPLES <<EOF

''''''
##################################################

${prelude}

##################################################
''''''

EOF

# :i sbooHaskell.spiros

  echo
  echo -e "$NIX_REPL_EXAMPLES"
  echo

  if   [ -x "$(command -v ${xdotool})" ]
  then
     (sleep 1 && ${xdotool-send-lines lines}) &
  fi
  
  nix repl

  # ^ Nix v2

'';

  #----------------------------------------------#

  xterm-set-title = ''

  Title="''${1:-$(basename $(pwd))}"

  echo -e -n "\033]2;''${Title}\007"

  # NOTES:
  # « echo » an XTERM EscapeSequence to set the WindowTitle.
  # « ]2; » is the sequence being escaped.
  # « ESC » and « BEL » are the escaping characters.

  # USAGE:
  # if type xterm-set-title; then xterm-set-title ""; fi
  '';

  #----------------------------------------------#

  #----------------------------------------------#

  #----------------------------------------------#

  #----------------------------------------------#

  #----------------------------------------------#

  sboo-test = ''

    echo sboo-test

  '';

  #----------------------------------------------#

  # sboo-home-manager-archive = ''

  #   ${find} -L "$1" -type f | ${tar} -c -v --gzip -f ./home-manager.tar -T -
 
  # '';

/*
  #----------------------------------------------#

  sboo- = ''


  '';

*/

  ################################################
}
##################################################