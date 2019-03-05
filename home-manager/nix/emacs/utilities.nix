##################################################
{ self, super }:

# self: super:
# { self, super }:

##################################################
let
#------------------------------------------------#

fromRepository = { repo ? null }:

    assert (null == repo || builtins.isString repo);

    let

    epkgs =

      if repo == "elpa"        then self.elpaPackages        else
      if repo == "melpa"       then self.melpaPackages       else
      if repo == "melpaStable" then self.melpaStablePackages else
      if repo == null          then self                     else

      abort ''« fromRepository x » — « x » is « ${repo} », but must be one of: « null "elpa" "melpa" "melpaStable" »'';

    in

    epkgs;

#------------------------------------------------#

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
      else repo'."${name}";

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

#------------------------------------------------#
in
##################################################
{

  inherit fromRepository configure;

}
##################################################