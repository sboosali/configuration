##################################################
{ pkgs
, utilities
}:

#########################

self: super:

##################################################
let

configuration = import ./configuration.nix { }:

#########################

fromRepository = { repo ? null }:

  assert (null == repo || builtins.isString repo);

  let

  epkgs =
    if repo == "elpa"        then self.elpaPackages
    if repo == "melpa"       then self.melpaPackages
    if repo == "melpaStable" then self.melpaStablePackages
    if repo == null          then self
    else self;

  in

  epkgs;

#########################

configure =
  { name
  , tools ? null, elisp ? null, package ? null, repo ? null
  }:

  assert (builtins.isString name);

  let

  repo' = fromRepository { inherit repo; };

  package' =
    if   package != null
    then package
    else repo'.''${name}'';

  tools' =
    if   tools != null
    then tools
    else [];

  elisp' =
    if   elisp != null
    then elisp
    else "";

  in

  super.addBuildInputs tools' package';

in
#########################

with utilities;

##################################################
rec {

  haskell-mode = self.melpaPackages.haskell-mode;

}
##################################################