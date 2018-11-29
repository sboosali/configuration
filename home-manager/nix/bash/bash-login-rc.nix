##################################################
{ pkgs
, xdg
, sboo

, bashUtilities
}:

##################################################
let

sboo-scripts-directory = builtins.toString ../../../scripts;

# ^ renders as absolute filepath.
#
# why `toString`?
# because interpolating a path is different than interpolating a string;
#
# in particular, "« ${../../../scripts}" »:
# doesn't equal « /home/sboo/configuration/scripts »,
# it equals « "/nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-scripts" ».
#

cabal-scripts-directory = builtins.toString ~/.cabal/bin;

in
##################################################

bashUtilities.concatBashScripts

    [ ''### -*- mode: conf-unix; -*-''

      (builtins.readFile ../../bash/profile.sh)

      (builtins.readFile ../../../bash/aliases)
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)

      ############################################

      (import ./profile/x11-rc.nix { inherit pkgs xdg; })

      (import ./profile/ssh-agent.sh.nix { inherit pkgs sboo; } )

      ''
      export PATH="${sboo-scripts-directory}":"${cabal-scripts-directory}":"$PATH"
      ''

      (import ./profile/terminfo.sh.nix { inherit pkgs; } )

]

# ^ TODO 
# profileExtra = ''
#   if ! pgrep -x "gpg-agent" > /dev/null; then
#       ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
#   fi
# '';

##################################################