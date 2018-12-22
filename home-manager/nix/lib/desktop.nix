##################################################
{ lib ? (import <nixpkgs> {}).pkgs.lib
}:

##################################################
let

in
##################################################
let

mkApplication = { name, desktop, autostart ? false }:

  assert (builtins.elem (builtins.typesOf desktop) ["string" "path"]);

  let
  typeof-desktop = builtins.typesOf desktop;

  desktop-attrset = if autostart && ("string" == typeof-desktop)
      then { text = desktop; }
      else

      if   autostart && ("path" == typeof-desktop)
      then { source = desktop; }
      else

  in

  {
    data."applications/emacs.desktop".text = desktop;
  } // (lib.optionalAttrs autostart {
    config."autostart/${name}.desktop" = desktop-attrset; }
  });

in
##################################################
{

  

}
##################################################

# e.g. "autostart/emacs.desktop".source    = if applications.emacs.autostart then applications.emacs.desktop else null;
