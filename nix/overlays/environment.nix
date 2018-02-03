self: super: 
########################################
let

homeWith = pathsWith: self: super:
 super.buildEnv {
  name  = "homeEnv";
  paths = pathsWith self;
 };

# :: GitHub -> Derivation
github = x:
 super.callPackage (super.fetchFromGitHub x) {};

# :: FilePath -> Derivation
file = x:
 super.callPackage (import x) {};

in
########################################
let

# which packages' executables. 
# it links their /bin to the PATH. 
myExecutablesWith = self: with self; [ 
 emacs25
];

in
########################################

{

 home = homeWith myExecutablesWith self super;
 
 # # namespaced with my username
 # sboo = {
 #  home = homeWith myExecutablesWith self super;  
 # };

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

# self: for requiring sibling packages
# super: for everything else (utilities, etc)
<p> = super.callPackage (super.importJSON ./<p>.json) { inherit (self) <q>; };

# the identity overlay
# ~ (const.const) empty 
identityOverlay = self: super: {}

# e.g.
$ nix-repl
> nixpkgs = import <nixpkgs> {}
> let super = { inherit (nixpkgs) callPackage fetchFromGitHub ...; }; self = import ./environment.nix.nix self super; in self
{ emacs2nix = «derivation /nix/store/nxssrxd2qq2kkps34p2q16zzh83295kv-source.drv»; }

# e.g.
$ cat ./shell-environment.nix.nix 
let
nixpkgs = import <nixpkgs> {}
super = { inherit (nixpkgs) callPackage fetchFromGitHub ...; }
self = import ./environment.nix.nix self super
in
self
$ nix-eval ./shell-environment.nix.nix 
{ environment.nix = «derivation /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-source.drv»; }

# e.g.
$ nix-prefetch-git 'https://github.com/ttuegel/emacs2nix' > emacs2nix.json

*/
