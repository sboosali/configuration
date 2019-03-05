##################################################
{ bashUtilities
, bashFunctions
}:

##################################################
let

in
##################################################

bashUtilities.concatBashScripts

    [ ''### -*- mode: conf-unix; -*-''

      (builtins.readFile ../../bash/bashrc.sh)

      (builtins.readFile ../../../bash/aliases)
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)
      (builtins.readFile ../../../bash/bash_settings)

      (bashUtilities.renderBashFunctions bashFunctions)
    ]   

#TODO#
#  bashrcExtra = lib.mkBefore ''
# '';

##################################################