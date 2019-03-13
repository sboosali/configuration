##################################################
{ pkgs
, lib
, stdenv

, config
}:

##################################################
let
#------------------------------------------------#

allowUnfree =

  if   (config ? allowUnfree)
  then config.allowUnfree
  else false;

#------------------------------------------------#

isX11 =

  stdenv.isLinux;

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

systemPrograms = import ./system-programs.nix

  { self = pkgs;
  };

#------------------------------------------------#

haskellPrograms = import ./haskell-programs.nix

  { self = pkgs.haskellPackages;
  };

#------------------------------------------------#

x11Programs = import ./x11-programs.nix

  { self = { inherit (pkgs) xorg xlibs; };
  };

#------------------------------------------------#

elispPrograms = import ./elisp-programs.nix

  { self = pkgs.emacsPackages;
  };

#------------------------------------------------#

javascriptPrograms = import ./javascript-programs.nix

  { self = pkgs.nodePackages;
  };

#------------------------------------------------#

pythonPrograms = import ./python-programs.nix

  { self = pkgs.pythonPackages;
  };

#------------------------------------------------#

unfreePrograms = import ./unfree-programs.nix

  { self = pkgs;
  };

#------------------------------------------------#
in
##################################################

builtins.concatLists
  [
    systemPrograms
    haskellPrograms
    elispPrograms
    javascriptPrograms
    pythonPrograms

    (lib.optionals isX11 x11Programs)

    (lib.optionals allowUnfree unfreePrograms)

  ]

##################################################