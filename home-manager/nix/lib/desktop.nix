##################################################
{ lib ? (import <nixpkgs> {}).pkgs.lib
, mkDesktopEntry
}:

##################################################
let

in
##################################################
let

mkApplication = { name, desktop, autostart ? false }:

  assert (builtins.elem (builtins.typesOf desktop) ["string" "path" "attr"]);

  let
  desktop-type = builtins.typesOf desktop;

  desktop-attrset =

      if   autostart && ("string" == desktop-type)
      then { text = desktop; }

      else

      if   autostart && ("path" == desktop-type)
      then { source = desktop; }

      else

      if   autostart && ("attr" == desktop-type) && (submodule.check desktop)
      then { text = mkDesktopEntry desktop; }

      else {};
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
