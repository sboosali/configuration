##################################################
{ lib
}:

##################################################
let

publicOptions = import ./options.nix { inherit lib; };

##################################################

options
  = publicOptions
 // {};

in
##################################################
{
  meta.maintainers = [ maintainers.sboosali ];

  options = {
    applications.<APPLICATION>.options = options;
  };

  config = mkIf cfg.enable (
    mkMerge configs;
  );

}
##################################################
/* Notes *****************************************

**************************************************

See:

- « https://wiki.archlinux.org/index.php/desktop_entries »
- « https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys »

*************************************************/
