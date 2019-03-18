##################################################
{ pkgs
, lib

, sboo
, applications
, xdg

, xdgUtilities
}:

##################################################
let
#------------------------------------------------#

shellUtilities = import ../shell/lib.nix

  { inherit lib;
  };

#------------------------------------------------#

bashUtilities = import ./lib.nix

  { inherit lib;
    inherit shellUtilities;
  };

#------------------------------------------------#

bashFunctions = import ./bash-functions.nix

  { inherit pkgs lib;
    inherit sboo;
  };

#------------------------------------------------#

bashCompletions = [

  ../../../bash/completion/cabal.bash
  ../../../bash/completion/home-manager.bash

];

# ^ custom completion scripts.

#------------------------------------------------#

# configFile = path:
#   "${xdg.configHome}/${path}";

#------------------------------------------------#
in
##################################################
rec {

 #-----------------------------#

 shellOptions = [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" ];

 # ^ Shell options to set.

 #-----------------------------#

 profileExtra = import ./bash-login-rc.nix { inherit pkgs lib;
                                             inherit xdg sboo;
                                             inherit bashUtilities;
                                           };

 # ^ « .profile » extras.
 # 
 # i.e. Extra commands that should be run when initializing a login shell.

 # ^ « ~/.profile » is executed by the command interpreter for Login Shells.
 #
 # NOTE `bash` ignores « ~/.profile » if either:
 #
 # * « ~/.bash_profile » exists, or
 # * « ~/.bash_login » exists.
 #

 #-----------------------------#

 bashrcExtra = initExtra;
 initExtra   = import ./bash-interactive-rc.nix { inherit bashUtilities;
                                                  inherit bashFunctions;
                                                  inherit bashCompletions;
                                                };

 # ^ « .bashrc » extras.
 # 
 # i.e. Extra commands that should be run when initializing an interactive shell.

 #-----------------------------#

#initExtra

 # ^ « . » extras.
 # 

 #-----------------------------#

 shellAliases =
  (import ./shell-aliases.nix
          { inherit pkgs sboo applications;
          });

 # ^ Attribute Set mapping aliases (the top-level Attribute Names in this option) either:
 # 
 # * to command strings, or
 # * directly to build outputs.

 #-----------------------------#

 sessionVariables =
    (import ./environment-variables.nix
            { inherit pkgs;
              inherit sboo xdg;
              inherit bashUtilities;
            });

 # ^ "Environment variables that will be set for the Bash session."

 # ^ NOTE « home.sessionVariables » has « sh »-general environment variables,
 # « programs.bash.sessionVariables » has the « bash »-specific environment variables.

 #-----------------------------#

 historyControl = [ "ignoredups" "ignorespace" ];

 # ^ 
 # `"ignoredups"`: ignore (consecutive) duplicate commands.
 # `"ignorespace"`: ignore commands that begin with whitespace.

 # historyFile = ''"$HOME"/.bash_history'';
 ## ^ Location of the bash history file.

 historyIgnore = [ "ls" "cd" "exit" ];

 # ^ List of commands that should not be saved to the history list.

 historySize = 100000;

 # ^ Number of history lines to keep in memory.

 historyFileSize = 1000000;

 # ^ Number of history lines to keep on file.

 historyFile = xdgUtilities.asXdgCachePath "bash/.bash_history";

 # ^ defaults to « ~/.bash_history »

 #-----------------------------#

 enableAutojump = true;

 # ^ Enable the `autojump` navigation tool.
 # 
 # See <https://github.com/wting/autojump>

/*
```sh
 # `j` aliases `autojump`

$ j foo

 # ^ `cd` to any (previously navigated to) directory whose path contains `foo`

$ jc foo 

 # ^ `cd` to any child-directory whose path contains `foo`

$ jo foo

 # ^ `open` (don't `cd` into) any (previously navigated to) directory whose path contains `foo`

$ jco 

 # ^ `jc` + `jo`
```
*/

 #-----------------------------#

}
#################################################