##################################################
{ #TODO# emacs
}:

##################################################
let

in
##################################################
{

  emacs.autostart = true;
  emacs.desktop   = import ../desktop/emacs.desktop.nix {}; #TODO { inherit emacs; };

  xfce4-terminal.autostart = true;
  xfce4-terminal.desktop   = rec { Name = "xfce4-terminal"; Exec = Name; TryExec = Exec; };
# xfce4-terminal.desktop   = import ../desktop/xfce4-terminal.desktop.nix {};

}
##################################################
/*************************************************

  _.autostart = true;
  _.desktop   = import ../desktop/emacs.desktop.nix {};

*************************************************/