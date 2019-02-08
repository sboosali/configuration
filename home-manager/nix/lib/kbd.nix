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

 syntax.modifiers = {

  "C" = "";
  "A" = "";
  "S" = "";
  "M" = "";

 };

 /* 
  * 
  *
  */

 syntax.keys = {

  "DEL" = "";
  "RET" = "";
  "SPC" = "";
  "ESC" = "";
  "TAB" = "";

 };

}
##################################################
/* NOTES *****************************************

« C- »:  means (press and hold) the Control key.
« M- »:  means the Meta key (the Alt key, on most keyboards).
« S- »:  means the Shift key (e.g. ‘S-TAB’ means Shift Tab).
« DEL »: means the Backspace key (not the Delete key).
« RET »: means the Return or Enter key.
« SPC »: means the Space bar.
« ESC »: means the Escape key.
« TAB »: means the Tab key.

A notation such as ‘C-M-x’ (or, equivalently, ‘M-C-x’) means press and hold both Control and Meta (Alt) keys while hitting the ‘x’ key.

 *************************************************

(global-set-key (kbd "M-#") 'left-char)       ; Alt+Shift+3 or Alt+#

(global-set-key (kbd "C-S-<kp-3>") 'left-char); Ctrl+Shift+“number pad 3”

(global-set-key (kbd "C-e SPC") 'calendar)  ; Ctrl+e Space

(global-set-key (kbd "C-M-S-<up>") 'left-char); Ctrl+Alt+Shift+↑

 ************************************************/