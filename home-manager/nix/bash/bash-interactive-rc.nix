##################################################
{ env
, bashUtilities
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

]   

#  bashrcExtra = lib.mkBefore ''
# '';

##################################################