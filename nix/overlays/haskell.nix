self: super: 
########################################
let

# "imports"
inherit (self) lib;
inherit (lib) map; 

# :: GitHub -> Derivation
github = x:
 super.callPackage (super.fetchFromGitHub x) {};

# :: FilePath -> Derivation
file = x:
 super.callPackage (import x) {};

# :: String -> FilePath -> Derivation
haskell = s: x:
 super.haskell.lib.callCabal2nix s (import x) {};

in
########################################
let

/*
a namespaced `overlay`.

`self` and `super` refer to `nixpkgs.haskellPackages` in this file, not `nixpkgs` (like other overlays).

`nixpkgs.self` and `nixpkgs.super` are the unqualified/global namespace.

*/

# :: PackageSet -> String -> Derivation
# String is a FilePath. 
# 
# NOTE
# + is left associative 
# paths are normalized to drop any trailing slashes.
# 
local = self: p:
 let
  packageDirectory = localHaskellDirectory + ("/" + p);
  package          = import packageDirectory; 
 in
  self.callPackage package {}; 

# :: FilePath
localHaskellDirectory = ~/haskell;

# `ps` are systemPackages (the `self` of `nixpkgs`)
# `hs` are haskellPackages (the `self` of `nixpkgs.haskellPackages`)
myHaskellPackages = pkgs: self: super: with self;

# myHaskellPackages = ps-self: hs-self: hs-super: 
# let self = { haskell = hs-self; packages = ps-self; };
 {

  spiros = super.callCabal2nix "spiros" ~/haskell/spiros {
  };

 # spiros = self.callPackage ~/haskell/spiros {};

 # NOTE
 # `callPackage` v `callCabal2nix` (`cabal2nix`): 
 # `callPackage` requires regenerating the `default.nix`.

 # These strings will be interpolated into paths...
 # spiros = local self.haskell "spiros";
 # spiros = self.callPackage ~/haskell/spiros {};

 };

# :: [String]
# String is a FilePath. 
# 
# 
myLocalHaskellPackages = map local [
 "spiros"
];

# # :: [String]
# # String is a FilePath. 
# # 
# # 
# myLocalHaskellPackageSet = map local [
#  "spiros"
# ];

in
########################################
{

 haskellPackages = super.haskellPackages.override {
    overrides = myHaskellPackages self;
 };

#    overrides = import ./haskell-overlay.nix { inherit self; };

 # haskellPackages = super.haskellPackages.override {
 #    overrides = hs-self: hs-super: {
 #      spiros = hs-self.callPackage ~/haskell/spiros {
 #      };
 #    };
 # };

# spiros = haskell "spiros" ~/haskell/spiros;

# spiros = file ~/haskell/spiros;

/*

PACKAGE = file ../DIRECTORY;

PACKAGE = github {
  owner           = "";
  repo            = "";
  rev             = "";
  fetchSubmodules = true;
  sha256          = "?";
 };

*/

}
########################################

/* NOTES

https://gist.github.com/CMCDragonkai/de84aece83f8521d087416fa21e34df4

nix-repl> ./foo + "/${name}"
/home/bas.van.dijk/foo/bar

 # we must include a prefix "/", since nix 
 # normalizes path literals, including when 
 # appended to strings (/ string literals).


 haskellPackages = super.haskellPackages.override {
    overrides = self: super: {
      spiros = self.callPackage ../spiros {};
    }
 }

# self: for requiring sibling packages
# super: for everything else (utilities, etc)
<p> = super.callPackage (super.importJSON ./<p>.json) { inherit (self) <q>; };

# the identity overlay
# ~ (const.const) empty 
identityOverlay = self: super: {}

# e.g.
$ nix-repl
> nixpkgs = import <nixpkgs> {}
> let super = { inherit (nixpkgs) callPackage fetchFromGitHub ...; }; self = import ./haskell.nix.nix self super; in self
{ emacs2nix = «derivation /nix/store/nxssrxd2qq2kkps34p2q16zzh83295kv-source.drv»; }

# e.g.
$ cat ./shell-haskell.nix.nix 
let
nixpkgs = import <nixpkgs> {}
super = { inherit (nixpkgs) callPackage fetchFromGitHub ...; }
self = import ./haskell.nix.nix self super
in
self
$ nix-eval ./shell-haskell.nix.nix 
{ haskell.nix = «derivation /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-source.drv»; }

# e.g.
$ nix-prefetch-git 'https://github.com/ttuegel/emacs2nix' > emacs2nix.json

*/
