##################################################
{ lib

, shellUtilities
}:

##################################################
let
#------------------------------------------------#

isStringOrPath = x:

  let

  t = builtins.typeOf x;

  in

  t == "string" || t == "path";

#------------------------------------------------#

startsWithSlash = s:

  builtins.substring 0 1 s == "/";

#------------------------------------------------#

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

#------------------------------------------------#

isPath = if builtins ? isPath then builtins.isPath else

  x:
  (! hasBuiltinType x) && startsWithSlash (builtins.toString x);

#------------------------------------------------#
in
##################################################
shellUtilities // rec {

  #----------------------------------------------#

  concatBashScripts =

    builtins.concatStringsSep "\n########################################\n";

  #----------------------------------------------#

  renderBashFunctions = attrs:

    let
    go = key: value:
        renderBashFunction { name = key; definition = value; };
    in

    (concatBashScripts
      (builtins.attrValues
        (builtins.mapAttrs
          go
          attrs)));

  #----------------------------------------------#

  renderBashFunction = { name, definition }: ''
#--------------------------------------#

function ${name} () {

${definition}

}

#--------------------------------------#
'';

  #----------------------------------------------#

  renderBashSources = paths:

    let
    go = path:
        renderBashSource { file = builtins.toString path; };
    in

    (builtins.concatStringsSep "\n"
      (builtins.map go
        paths));

  #----------------------------------------------#

  renderBashSource = { file }: ''
source ${file}
'';

  #----------------------------------------------#
}
##################################################