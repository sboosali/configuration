##################################################
{ 
bashUtilities
}:

##################################################

bashUtilities.concatBashScripts

    [ (builtins.readFile ../../../bash/aliases)

      ''
      export TERMINFO_DIRS="$HOME/.nix-profile/share/terminfo":/lib/terminfo
      ''

      #(builtins.readFile ../../../bash/.bashrc)

      # ^ « tput » needs « terminfo » to identity « $TERM »
      # (i.e. the current terminal).

      # ^ TODO :"$TERMINFO"
      # ^ TODO :"$TERMINFO" as sessionVariables that interpolates `{pkgs.termite}/share/terminfo`
      # ^ TODO « "./home-path/share/terminfo/x/xterm-termite" »
      
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)
      (builtins.readFile ../../../bash/bash_settings)

      #TODO${pkgs.terminfo}
]   

#  bashrcExtra = lib.mkBefore ''
# '';

##################################################