##################################################
{ bashUtilities
, bashFunctions
, bashCompletions
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
      (bashUtilities.renderBashSources   bashCompletions)
    ]   

#TODO#
#  bashrcExtra = lib.mkBefore ''
# '';

##################################################