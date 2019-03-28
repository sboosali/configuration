##################################################
{ nixpkgs  ? <nixpkgs>
, config   ? {}
, overlays ? []
}:

#------------------------------------------------#

assert (let t = builtins.typeOf nixpkgs;
        in builtins.elem t ["string" "path"]);

assert (let t = builtins.typeOf config;
        in builtins.elem t ["attrs"]);

assert (let t = builtins.typeOf overlays;
        in builtins.elem t ["list"]);

##################################################
let
#------------------------------------------------#

pkgs = import nixpkgs { inherit config overlays; };

#------------------------------------------------#

self  = pkgs;
super = pkgs;

inherit (self)
        perl
        ;

inherit (super)
        stdenv
        fetchurl
        ;

#------------------------------------------------#

mkGhc = { version, name, sha256 }:

  let

  platform = stdenv.hostPlatform.system;

  sources = {

      "x86_64-linux" = {
        url = "http://haskell.org/ghc/dist/${version}/ghc-${version}-x86_64-deb8-linux.tar.xz";
        inherit sha256;
      };

      "x86_64-darwin" = {
        url    = "http://haskell.org/ghc/dist/${version}/ghc-${version}-x86_64-apple-darwin.tar.xz";
        inherit sha256;
      };

      # "armv7l-linux" = {
      #   url = "http://haskell.org/ghc/dist/${version}/ghc-${version}-armv7-deb8-linux.tar.xz";
      #  inherit sha256;
      # };

    };

  in

  stdenv.mkDerivation {

    version = version;

    name = "${name}-binary";

    src = fetchurl (sources.${platform} or (throw "« mkGhc »: unsupported platform « ${platform} »"));

    nativeBuildInputs = [ perl ];

    # Stripping combined with patchelf breaks the executables (they die
    # with a segfault or the kernel even refuses the execve).
    dontStrip = true;

    # No building is necessary, but calling make without flags ironically
    # calls install-strip ...
    dontBuild = true;

    doInstallCheck = true;
    installCheckPhase = ''
      # Sanity check, can ghc create executables?
      cd $TMP
      mkdir test-ghc; cd test-ghc
      cat > main.hs << EOF
        {-# LANGUAGE TemplateHaskell #-}
        module Main where
        main = putStrLn \$([|"yes"|])
      EOF
      $out/bin/ghc --make main.hs || exit 1
      echo compilation ok
      [ $(./main) == "yes" ]
    '';

    passthru = {
      targetPrefix = "";
      enableShared = true;
    };

    meta.license = stdenv.lib.licenses.bsd3;
    meta.platforms = [ "x86_64-linux" "x86_64-darwin" "armv7l-linux" ];
  };

# mkGhc = self.callPackage ./ghc-binary.nix
# { stdenv, substituteAll
# , fetchurl, perl, gcc, llvm_39
# , ncurses5, gmp, glibc, libiconv
# };

#------------------------------------------------#

ghcs = {

  v710 = {
    version       = "7.10.3";
    name          = "ghc-7.10";
    sha256        = if (stdenv.isLinux && stdenv.is64bit) then linux.sha256 else if (stdenv.isDarwin) then darwin.sha256 else null;
    linux.sha256  = "5e163c557e9236cce68be41c984eab0fcdbdc1602e39040ca9ae325e6bdec1c3";
    darwin.sha256 = "4b537228d49b5ea0f8e8dbcc440a5b3c3cb19a92579d607291cc0041422fa5c3";
  };

  v800 = {
    version       = "8.0.2";
    name          = "ghc-8.0";
    sha256        = if (stdenv.isLinux && stdenv.is64bit) then linux.sha256 else if (stdenv.isDarwin) then darwin.sha256 else null;
    linux.sha256  = null;
    darwin.sha256 = null;
  };

  v802 = rec {
    version       = "8.2.2";
    name          = "ghc-8.2";
    sha256        = if (stdenv.isLinux && stdenv.is64bit) then linux.sha256 else if (stdenv.isDarwin) then darwin.sha256 else null;
    linux.sha256  = "0ahv26304pqi3dm7i78si4pxwvg5f5dc2jwsfgvcrhcx5g30bqj8";
    darwin.sha256 = "09swx71gh5habzbx55shz2xykgr96xkcy09nzinnm4z0yxicy3zr";
  };

  v804 = {
    version       = "8.4.4";
    name          = "ghc-8.4";
    sha256        = if (stdenv.isLinux && stdenv.is64bit) then linux.sha256 else if (stdenv.isDarwin) then darwin.sha256 else null;
    linux.sha256  = null;
    darwin.sha256 = null;
  };

  v806 = {
    version       = "8.6.4";
    name          = "ghc-8.6";
    sha256        = if (stdenv.isLinux && stdenv.is64bit) then linux.sha256 else if (stdenv.isDarwin) then darwin.sha256 else null;
    linux.sha256  = null;
    darwin.sha256 = null;
  };

  v808 = {
    version       = "8.8.0";
    name          = "ghc-8.8";
    sha256        = if (stdenv.isLinux && stdenv.is64bit) then linux.sha256 else if (stdenv.isDarwin) then darwin.sha256 else null;
    linux.sha256  = null;
    darwin.sha256 = null;
  };

};

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

#------------------------------------------------#
in
##################################################
{

  ghc710 = mkGhc { inherit (ghcs.v710) version sha256 name; };
  # ghc800 = mkGhc { inherit (ghcs.v800) version sha256 name; };
  ghc802 = mkGhc { inherit (ghcs.v802) version sha256 name; };
  # ghc804 = mkGhc { inherit (ghcs.v804) version sha256 name; };

  # ghc806 = mkGhc { inherit (ghcs.v806) version sha256 name; };
  # ghc808 = mkGhc { inherit (ghcs.v808) version sha256 name; };

}
##################################################
/* Notes

https://downloads.haskell.org/~ghc/7.10.3/ghc-7.10.3-x86_64-deb8-linux.tar.bz2

*/