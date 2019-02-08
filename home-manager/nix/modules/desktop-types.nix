##################################################
{ lib
}:

/* Types (and Utilities) for Desktop Entry files.
 *
 */

##################################################
let

inherit (lib) types;

inherit (lib.types) mkOption;

in
##################################################
let



in
##################################################
rec {

  string-required = name: description: example:
  
    mkOption {
      type = types.string;
      inherit name description example;
    };
  
  localestring = name: description: example:
  
    mkOption {
      type = types.nullOr types.string;
      inherit name description example;
    };

  string = name: description: example:
  
    mkOption {
      type = types.nullOr types.string;
      inherit name description example;
    };

  path = name: description: example:
  
    mkOption {
    type = types.nullOr (types.either types.string types.path);
      inherit name description example;
    };

  bool = name: description: example:
  
    mkOption {
      type = types.nullOr types.bool;
      inherit name description example;
    };
  
  listof = type: name: description: example:
  
    mkOption {
      type = types.listOf type;
      inherit name description example;
    };
  
  setof = type: name: description: example:
  
    mkOption {
      type = types.attrsOf type;
      inherit name description example;
    };

  listof-string = listof types.string;

  listof-localestring = listof types.string;

}
##################################################
