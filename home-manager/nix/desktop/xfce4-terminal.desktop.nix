{}:

let

fromPath = builtins.toString;

exec = fromPath ~/.nix-profile/bin/emacs;

in

''
##################################################
[Desktop Entry]

Version=1.0
Type=Application
Encoding=UTF-8

#############################

Name=xfce4-terminal

#############################

Exec=${exec}
TryExec=${exec}

##################################################
''
