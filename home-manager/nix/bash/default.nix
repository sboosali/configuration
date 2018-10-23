##################################################
{ pkgs
, xdg
, sboo
, env
}:

##################################################
let

bashUtilities = rec {

 concatBashScripts =
   builtins.concatStringsSep "########################################\n\n";

};

##################################################

# configFile = path:
#   "${xdg.configHome}/${path}";

in
##################################################
{

 profileExtra = import ./bash-login-rc.nix { inherit pkgs xdg sboo;
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

 bashrcExtra = import ./bash-interactive-rc.nix { inherit env bashUtilities; };

# ^ « .bashrc » extras.
# 
# i.e. Extra commands that should be run when initializing an interactive shell.

 shellOptions =
  [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" ];

# ^ Shell options to set.

#TODO port over .aliases#
#  shellAliases =
#   (import ./home/shell-aliases.nix
#           { inherit pkgs sboo; });

# ^ Attribute Set mapping aliases (the top-level Attribute Names in this option) either:
# 
# * to command strings, or
# * directly to build outputs.

 sessionVariables = {};

# ^ Environment variables that will be set for the Bash session.

 historyControl = [ "ignoredups" "ignorespace" ];

# ^ 
# `"ignoredups"`: ignore (consecutive) duplicate commands.
# `"ignorespace"`: ignore commands that begin with white space.

# historyFile = ''"$HOME"/.bash_history'';
## ^ Location of the bash history file.

 historyIgnore = [ "ls" "cd" "exit" ];

# ^ List of commands that should not be saved to the history list.

 historySize = 100000;

# ^ Number of history lines to keep in memory.

 historyFileSize = 1000000;

# ^ Number of history lines to keep on file.

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

}
##################################################