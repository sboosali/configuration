;; This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;; any functions that work in guile will work here.
;; see EXTRA FUNCTIONS:

;; Version: 1.8.6

;; If you edit this file, do not forget to uncomment any lines
;; that you change.
;; The semicolon(;) symbol may be used anywhere for comments.

;; To specify a key, you can use 'xbindkeys --key' or
;; 'xbindkeys --multikey' and put one of the two lines in this file.

;; A list of keys is in /usr/include/X11/keysym.h and in
;; /usr/include/X11/keysymdef.h
;; The XK_ is not needed.

;; List of modifier:
;;   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
;;   Mod3 (CapsLock), Mod4, Mod5 (Scroll).


;; The release modifier is not a standard X modifier, but you can
;; use it if you want to catch release instead of press events

;; By defaults, xbindkeys does not pay attention to modifiers
;; NumLock, CapsLock and ScrollLock.
;; Uncomment the lines below if you want to use them.
;; To dissable them, call the functions with #f

;;----------------------------------------------;;
;; Definitions ---------------------------------;;
;;----------------------------------------------;;

(define (transfer)
  ;; seems to work, both from emacs and into emacs
 (run-command " xdotool key --delay 120 --clearmodifiers 'Control_L+c'  'Alt_L+Tab' 'Control_L+v' 'Return' 'Alt_L+Tab'"))

;;----------------------------------------------;;

(define (open-google-voice-search)
  ;; 
 (run-command "xdg-open 'https://www.google.com'"))

;;----------------------------------------------;;
;; Keybindings: Applications -------------------;;
;;----------------------------------------------;;

;; action:   raise windows by application (not position).
;; shortcut: Ctrl+Alt+Shift+<key> (one button on my Keypad).

;; e.g.:
;;
;; « C-M-S-e » ⇒ « wmctrl -a emacs »

;;----------------------------------------------;;

;; Release, Control, Shift, Mod1 (Alt)

;;----------------------------------------------;;
;; Keybindings: Miscellaneous ------------------;;
;;----------------------------------------------;;

(xbindkey-function '(release "m:0x0" "Pause")
                   transfer)

;;----------------------------------------------;;

(xbindkey-function '(release "m:0x0" "Escape")
                   open-google-voice-search)

;;----------------------------------------------;;

(xbindkey '(release "m:0x0" "c:118")
          "xdotool key --clearmodifiers 'Control_L+0x76'")

;; needs extra presses
;; (xbindkey '(release "m:0x0" "c:___") ;; other keys don't work
(xbindkey '(release "m:0x0" "c:107") ;; buggy
 ;; "sleep 0.03 && xdotool key --clearmodifiers 'Control_L+0x63'")
 ;; "xdotool key --clearmodifiers 'Control_L+0x63'") 
 ;; "xte 'keydown Control_L' 'key C' 'keyup Control_L'")
;; "xvkbd -text '\\Cc'")
 "xdotool keydown control key c xdotool keyup control")
 ;; doesn't work in emacs (where i need it most), but works in terminal, seems to work in chrome and firefox

(xbindkey '(release "m:0x0" "c:78")
          "xdotool key --clearmodifiers 'Control_L+0x7a'")

;;----------------------------------------------;;

;; (xbindkey '(release "m:0x0" "c:0xff63") 
;;  "xdotool key --clearmodifiers 'Control_L+v'")
;; (xbindkey '(release "m:0x0" "c:0xff61")
;;  "sleep 0.03 && xdotool key --clearmodifiers 'Control_L+c'")
;; (xbindkey '(release "m:0x0" "c:0xff14") 
;;  "xdotool key --clearmodifiers 'Control_L+z'")

;; xdotool --clearmodifiers key 'control+_'

;; (xbindkey '(release "m:0x0" "c:118") 
;;  "xdotool key --clearmodifiers 'Control_L+v'")
;; (xbindkey '(release "m:0x0" "c:107")
;;  "sleep 0.03 && xdotool key --clearmodifiers 'Control_L+c'")
;; (xbindkey '(release "m:0x0" "c:78") 
;;  "xdotool key --clearmodifiers 'Control_L+z'")

;; (xbindkey '("m:0x0" "c:118") "C-v")
;; (xbindkey '("m:0x0" "c:107") "C-c")
;; (xbindkey '("m:0x0" "c:78") "C-z")

;; via `xbindkey -k`

    ;; m:0x0 + c:9
    ;; Escape

    ;; m:0x0 + c:118
    ;; Insert

    ;; m:0x0 + c:107
    ;; Print

    ;; m:0x0 + c:78
    ;; Scroll_Lock

;;----------------------------------------------;;
;; Notes ---------------------------------------;;
;;----------------------------------------------;;

;; XBindKeys-Scheme

;; e.g. `C-M-S-q`...
;;
;; via keysym(s):
;;
;;   (xbindkey '(control alt shift q) "xbindkeys_show")
;;
;; via keycode(s):
;;
;;   (xbindkey '("m:0xd" "c:24") "xbindkeys_show")
;;           "xbindkeys_show")
;;

;; e.g. LISP...
;;
;; « run-command »:
;;
;;   (xbindkey-function '(control alt shift q) 'sboo-xbindkeys_show)
;;
;; where:
;;
;;   (define (sboo-xbindkeys_show) (run-command "xbindkeys_show"))
;;

;; e.g. `C-<mouse-1>`...
;;
;; with mouse button:
;;
;;   (xbindkey '(control "b:1") "...")
;; 
;; (a.k.a. Single Left Click, while holding Control).
;;

;;----------------------------------------------;;

;; discover Keycodes via « xbindkeys --key ».  e.g.:
;; 
;;   $ xbindkeys --key
;;
;;   Press combination of keys or/and click under the window.
;;
;;   "(Scheme function)"
;;       m:0xd + c:24
;;       Control+Shift+Alt + q
;;

;;----------------------------------------------;;
;; EOF -----------------------------------------;;
;;----------------------------------------------;;