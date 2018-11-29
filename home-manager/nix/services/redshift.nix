##################################################
{ pkgs

, sboo
}:

##################################################
{

      provider  = "manual";
      inherit (sboo.locations.boston) longitude latitude;

  #TODO rm:
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

}
##################################################