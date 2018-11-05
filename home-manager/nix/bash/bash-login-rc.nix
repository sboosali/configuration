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

       ###########################################

      (builtins.readFile ../../../bash/aliases)
      (builtins.readFile ../../../bash/bash_definitions)
      (builtins.readFile ../../../bash/bash_aliases)

       ###########################################

      (import ./x11-rc.nix { inherit pkgs xdg; })

       ###########################################

       ''
       export PATH="${sboo-scripts-directory}":"${cabal-scripts-directory}":"$PATH"
       ''

       ###########################################

       ''
       #-----------------------------------------------#
       # ssh-agent ------------------------------------#
       #-----------------------------------------------#

       if [ -x "$(command -v ${pkgs.openssh}/bin/ssh-agent)" ]
       then

       if   ! pgrep -x "ssh-agent" > /dev/null
       then eval "$(${pkgs.openssh}/bin/ssh-agent -s)"
       fi

           # ^ Start the « ssh-agent » in the background.

           if [ -f "~/.ssh/${sboo.keys.github}" ]
           then
               "${pkgs.openssh}/bin/ssh-add" ~/.ssh/${sboo.keys.github}
           fi

           # ^ Register my GitHub (@sboosali) key, via « ssh-agent ».
       fi
       ''

       ###########################################
]

# ^ TODO 
# profileExtra = ''
#   if ! pgrep -x "gpg-agent" > /dev/null; then
#       ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
#   fi
# '';

##################################################
