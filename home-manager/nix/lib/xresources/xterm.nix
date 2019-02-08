##################################################
{ lib
}:

##################################################
let



in
##################################################
rec {

 /* 
  *  
  *
  */

 xterm.translations.mkTranslations = keybindings:

   (builtins.concatStringsSep xterm.translations.separator
     (builtins.map xterm.translations.mkBinding
       keybindings));

 /* 
  *  
  */

 xterm.translations.separator = ''\n\
'';

 /* 
  *
  * For example, this Nix attribute:
  *  
  *  <code>
  *  {
  *    "C-S-c" = "copy-selection(CLIPBOARD)";
  *  }
  *  </code>
  *  
  * becomes this XResources line:
  *  
  *  <code>
  *  Ctrl Shift <Key>C: copy-selection(CLIPBOARD)
  *  </code>.
  *  
  */

 xterm.translations.mkBinding = {name, value}:
   let
   keysequence = mkKeysequence name;
   binding     = value;
   in

   ''${keysequence}: ${binding}'';

 /* 
  *  
  */

 xterm.translations.mkKeysequence = s:
   let
   modifiers = name
   key       = xterm.translations.mkKey value;
   in
 
   ''${modifiers} ${key}'';

 /* 
  *  
  */

 xterm.translations.mkKey = s:
   let
   key = value;
   in
 
   ''<Key>${key}'';

 /* 
  *  
  */

 xterm.translations.keys = {

   #TODO the emacs « kbd » syntax

 };

}
##################################################
/* NOTES *****************************************

e.g.

  xterm.translations.mkTranslations [
    { key = "Ctrl Shift <Key>C";
      bind = "copy-selection(CLIPBOARD)";
    }
  ]



 ************************************************/