##################################################
{ #TODO# emacs
}:

##################################################
let

in
##################################################
{
#------------------------------------------------#

  emacs.autostart = true;
  emacs.desktop   = import ../desktop/emacs.desktop.nix {}; #TODO { inherit emacs; };

#------------------------------------------------#

  google-chrome.autostart = true;
  google-chrome.desktop   = import ../desktop/google-chrome.desktop.nix { password-store = "basic"; };

  # ^ « password-store = "basic" » stops the "Unlock Keyring" spam
  #   (in which a modal prompt pops up literally a dozen times).

------------------------------------------------#

  xfce4-terminal.autostart = true;
  xfce4-terminal.desktop   = rec { Name = "xfce4-terminal"; Exec = Name; TryExec = Exec; };
# xfce4-terminal.desktop   = import ../desktop/xfce4-terminal.desktop.nix {};

#------------------------------------------------#
}
##################################################
/*************************************************

  _.autostart = true;
  _.desktop   = import ../desktop/emacs.desktop.nix {};

*************************************************/