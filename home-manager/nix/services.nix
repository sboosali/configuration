##################################################
{ pkgs

, sboo
}:

##################################################

#with pkgs; 

##################################################
{

  ################################################

  xbindkeys = import ./services/xbindkeys.nix { inherit pkgs sboo; } // { enable = true; };
  
  # ^ Enable XBindKeys, a hotkey daemon.

  ################################################

  gpg-agent = import ./services/gpg-agent.nix { inherit pkgs sboo; }
          // { enable = true; };
  
  # ^ Enable GnuPG, a private-key agent.

  ################################################

  redshift = import ./services/redshift.nix { inherit pkgs sboo; }
          // { enable = true; };
  
  # ^ Enable RedShift, a screen-color daemon.

  ################################################
  
  #services.network-manager-applet.enable = true;
  
  # ^ for wifi password input.
  
  ################################################
  
  #TODO# services.ssh-agent = {
  #    enable = true;
  #
  # };
  
  ################################################

}
##################################################