##################################################
{ pkgs
, sboo
, xdg
}:

# NOTE `bash`-specfic environment-variables.
# for `sh`-general environment-variables, see « ../home/environment-variables.nix ».

##################################################
let

less = ''${pkgs.less}/bin/less'';

##################################################

startsWithSlash = s:

  builtins.substring 0 1 s == "/";

hasBuiltinType = x:

  builtins.any (f: f x) [
    (builtins.isAttrs)
    (builtins.isBool)
    (builtins.isFloat)
    (builtins.isFunction)
    (builtins.isInt)
    (builtins.isList)
    (builtins.isNull)
    (builtins.isString)
  ];

isPath = if builtins ? isPath then builtins.isPath else

  x:
  (! hasBuiltinType x) && startsWithSlash (builtins.toString x);

mkPATH = xs:

  let 
  stringFromPathOrString = x:
    if   builtins.isString x
    then x
    else
    if   isPath x
    then builtins.toString x
    else abort "pathFromList";
  in

  builtins.concatStringsSep ":"
    (builtins.map stringFromPathOrString
      xs);

# ^ Renders as absolute filepath.
#
# Why `toString`?
# Because interpolating a path is different than interpolating a string.
#
# in particular, "« ${../../../scripts}" »:
# doesn't equal « /home/sboo/configuration/scripts »,
# it equals « "/nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-scripts" ».
#

in
##################################################
{

 PAGER = less;

 #TODO GNUPGHOME = xdgDir "gnupg";
 # ^ « $GNUPGHOME » defaults to « $HOME » (i.e. « ~/.gnupg »).

 PATH = mkPATH (import ./paths.nix);

}
##################################################