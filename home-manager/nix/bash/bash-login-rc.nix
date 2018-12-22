##################################################
{ pkgs

, sboo
, xdg

, bashUtilities
}:

##################################################
let

in
##################################################

bashUtilities.concatBashScripts

    [ ''### -*- mode: conf-unix; -*-''

      (builtins.readFile ../../bash/profile.sh)

      (builtins.readFile ../../../bash/aliases)
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)

      ############################################

      (import ./profile/x11-rc.sh.nix { inherit pkgs xdg; })

      (import ./profile/ssh-agent.sh.nix { inherit pkgs sboo; } )

      (import ./profile/terminfo.sh.nix { inherit pkgs; } )

]

# ^ TODO 
# profileExtra = ''
#   if ! pgrep -x "gpg-agent" > /dev/null; then
#       ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
#   fi
# '';

##################################################