##################################################
{ env
, bashUtilities
}:

##################################################
let

NIX_PROFILE = "$HOME/.nix-profile";

in
##################################################

bashUtilities.concatBashScripts

    [ ''### -*- mode: conf-unix; -*-''

      (builtins.readFile ../../bash/bashrc.sh)

      ''
      export TERMINFO_DIRS="${NIX_PROFILE}/share/terminfo":/lib/terminfo
      ''

      (builtins.readFile ../../../bash/aliases)
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)
      (builtins.readFile ../../../bash/bash_settings)

      # ^ « tput » needs « terminfo » to identity « $TERM »
      # (i.e. the current terminal).

      # ^ TODO :"$TERMINFO"
      # ^ TODO :"$TERMINFO" as sessionVariables that interpolates `{pkgs.termite}/share/terminfo`
      # ^ TODO « "./home-path/share/terminfo/x/xterm-termite" »

      #TODO${pkgs.terminfo}
]   

#  bashrcExtra = lib.mkBefore ''
# '';

##################################################