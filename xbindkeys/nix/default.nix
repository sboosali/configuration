
##################################################
{ config
, lib
, pkgs
, ...
}:

##################################################
let
#------------------------------------------------#

cfgService = config.services.xbindkeys;
cfgProgram = config.programs.xbindkeys;

#------------------------------------------------#

configGuile =
  let
  baseConfigGuile  = if cfgService.configGuile != null then (builtins.readFile cfgServices.configGuile) else "";
  extraConfigGuile = builtins.readFile cfgServices.extraConfigGuile;
  in

  baseConfigGuile + "\n\n" + extraConfigGuile;

#------------------------------------------------#

configXbk =

  let
  baseConfigXbk  = builtins.readFile cfgServices.configXbk;
  extraConfigXbk = cfgServices.extraConfigXbk;
  in

  baseConfigXbk + "\n\n" + extraConfigXbk;

#------------------------------------------------#

isGuile = (cfgService.language == "guile")     && (cfgService.configGuile != null || cfgService.extraConfigGuile != null);
isXkd   = (cfgService.language == "xbindkeys") && (cfgService.config      != null || cfgService.extraConfig      != null);

#------------------------------------------------#

finalLanguage =

  if   (cfgService.language == "guile")
  then "guile"

  else

  if   (cfgService.language == "xbindkeys")
  then "xbindkeys"


  else pkgConfigDefault;

#------------------------------------------------#

finalConfig =

  if   isGuile
  then pkgConfigGuile

  else

  if   isXkd
  then pkgConfigXbk

  else pkgConfigDefault;

#------------------------------------------------#
in
##################################################

{
  meta.maintainers = [ lib.maintainers.sboosali ];

  #----------------------------#

  options = { services.xbindkeys = import ./options.nix { inherit pkgs lib; }; };

  #----------------------------#

  config = lib.mkIf cfgService.enable {

    home.packages = [ pkgs.xbindkeys ];

    systemd.user.services.xbindkeys = import ./service.nix { inherit pkgs lib; inherit cfgService cfgProgram; };

    xdg.configFile =
      {
       "xbindkeys/xbindkeysrc.scm" = pkgs.writeText "xbindkeysrc.scm" configGuile;
       "xbindkeys/xbindkeysrc"     = pkgs.writeFile "xbindkeysrc"     configXbk;
      };

    assertions = [{
        assertion = cfgProgram.enable;
        message = ''The XBindKeys service's module requires {{{ programs.xbindkeys.enable = true; }}}.'';
    }];

  };
}
