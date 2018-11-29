##################################################
{ pkgs
, sboo
}:

##################################################

#with pkgs; 

##################################################
{

  ################################################

  gpg-agent.enable = true;

  # ^ Enable GnuPG private-key agent.

  ################################################

  redshift = {
      enable = true;
  
      provider  = "manual";
      inherit (sboo.locations.boston) longitude latitude;
  
  #    provider  = "manual";
  #    longitude = "42";
  #    latitude  = "71";
  
      temperature.night  = 1000;
      temperature.day    = 20000;
  
      # ^ kelvins.
      # min 1000 (red), max 25000 (blue).
  
      brightness.night  = "0.9";
      brightness.day    = "1.0";
  
      # ^ fraction.
      # min 0.1 (dim, 10%), max 1.0 (bright, 100%).
  };
  
  ################################################
  
  #services.network-manager-applet.enable = true;
  
  # ^ for wifi password input.
  
  ################################################
  
  #TODO# services.gpg-agent = {
  #    enable = true;
  #
  #    defaultCacheTtl = 1800;
  #    enableSshSupport = true;
  #};
  
  ################################################
  
  #TODO# services.ssh-agent = {
  #    enable = true;
  #
  # };
  
  ################################################

}
##################################################