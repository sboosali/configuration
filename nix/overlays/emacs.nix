self: super: {

}

# /* 
#     nix-install emacs2nix
# */

# let 

# # inherit (builtins) fromJSON;
# # inherit (super.lib) readFile;
# # inherit (super) fetchgit; 
# # # fetchFromGitHub

# # # :: FilePath -> Derivation
# # github = p:
# #  fetchgit (fromJSON (readFile p));
# #  # fetchGithubFromJSONFile

# # :: GitHub -> Derivation
# github = x:
#  super.callPackage (super.fetchFromGitHub x) {};


# in

# {

#  # emacs2nix = github ./emacs2nix.json;

#  emacs2nix = github {
#   owner           = "ttuegel";
#   repo            = "emacs2nix";
#   rev             = "844fee9daf5ed3bfcdea9fb5f47a400f25fbbce1";
#   fetchSubmodules = true;
#   sha256          = "1w16y32gyvvyk3ln4h9wxh1bsll4xmzyivbjnbkd0g5zvzxakh9b"; 
#                   # "1mgy05fka4zpqcy64a0j0hlrry0hwj10hk2278k9g5vz5c3bsdzf";
#  };

# }

# /* NOTES

# $ nix-prefetch-git 'https://github.com/ttuegel/emacs2nix' > emacs2nix.json

# $ ./melpa-packages.sh --melpa ~/melpa -o ~/nixpkgs/pkgs/applications/editors/emacs-modes/melpa-generated.nix

# e.g.

# > nixpkgs = import <nixpkgs> {}
# > let super = { inherit (nixpkgs) fetchFromGitHub; }; self = import ./emacs.nix self super; in self
# { emacs2nix = «derivation /nix/store/nxssrxd2qq2kkps34p2q16zzh83295kv-source.drv»; }

# */

# # OLD
# # jsonFileToNixValue = x: fromJSON (readFile ./${x}.json);
# # json2nix = path: fromJSON (readFile path);
