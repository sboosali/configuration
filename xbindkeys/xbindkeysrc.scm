;;----------------------------------------------;;
;; Imports -------------------------------------;;
;;----------------------------------------------;;

(use-modules (srfi srfi-19))
(use-modules (ice-9 format))

;;----------------------------------------------;;
;; Programs ------------------------------------;;
;;----------------------------------------------;;

(define (notify-send title message)

  ;; 

  (run-command
   (format #f "notify-send '~a' '~a'" title message)))

;; Format Placeholders:
;;
;; • Guile « ~a » is like Elisp « %s »
;; • Guile « ~s » is like Elisp « %S »

;;----------------------------------------------;;

(define (wmctrl application)

  ;; 

  (run-command
   (format #f "wmctrl -a '~a'" application)))

;; « wmctrl -a » matches a (case-insensitive) Regular Expression against a Window Title.

;;----------------------------------------------;;

(define (xdotool-key keysyms)

  ;; 

  (run-command
   (format #f
           "xdotool key --clearmodifiers '~a'"
           keysyms)))

;;----------------------------------------------;;
;; Functions -----------------------------------;;
;;----------------------------------------------;;

;;----------------------------------------------;;
;; Commands ------------------------------------;;
;;----------------------------------------------;;
 
(define (send-control-c) (xdotool-key "Control_L+c"))
(define (send-control-x) (xdotool-key "Control_L+x"))
(define (send-control-v) (xdotool-key "Control_L+v"))

;; (define (send-control-c) (send-keys "C-c"))
;; (define (send-control-x) (send-keys "C-x"))
;; (define (send-control-v) (send-keys "C-v"))

;;----------------------------------------------;;

(define (open-google-voice-search)

  ;; 

  (run-command
   "google-chrome 'https://www.google.com'")

;;TODO (xdotool-key "Control_L+Shift+period")

  )

;; Mouse-Click the 🎤 (to the right of the google search bar).

;;TODO click mouse on hard-coded coordinates.

;;TODO « chrome://extensions/shortcuts »

;;----------------------------------------------;;

(define (transfer)

  ;; seems to work, both from emacs and into emacs.

  (let ((delay-milliseconds 120)
        )

    (run-command
     (format #f
             "xdotool key --delay  '~a' --clearmodifiers 'Control_L+c'  'Alt_L+Tab' 'Control_L+v' 'Return' 'Alt_L+Tab'"
             delay-milliseconds))))

;;----------------------------------------------;;

(define (bring-editor)

  (wmctrl "Emacs - "))

;;----------------------------------------------;;

(define (bring-browser)

  (wmctrl "- Google Chrome"))

;;----------------------------------------------;;

(define (bring-terminal)

  (wmctrl "Terminal - "))

;;----------------------------------------------;;

(define (sboo-xbindkeys_show)

  (run-command "xbindkeys_show -fg ${XBINDKEYSRC:-${XDG_CONFIG_HOME:-$HOME/.config}/xbindkeys/xbindkeysrc.scm}"))

;;----------------------------------------------;;

(define (sboo-popup-date)

  (let ((DATE (date->string (current-date) "~A, ~B ~e ~Y ~H:~S"))
        )

  (notify-send "date" DATE)))

;;----------------------------------------------;;
;; Keybindings: Aliases ------------------------;;
;;----------------------------------------------;;

(xbindkey-function '(F5) send-control-c)
(xbindkey-function '(F6) send-control-x)

;;----------------------------------------------;;
;; Keybindings: Applications -------------------;;
;;----------------------------------------------;;

;; action:   raise windows by application (not position).
;; shortcut: Ctrl+Alt+Shift+<key> (one button on my Keypad).

;; e.g.:
;;
;; « C-M-S-e » ⇒ « wmctrl -a emacs »

;;----------------------------------------------;;

(xbindkey-function '(control alt shift e) bring-editor)
;; (xbindkey-function '(control alt shift b) bring-browser)
;; (xbindkey-function '(control alt shift t) bring-terminal)

;;----------------------------------------------;;
;; Keybindings: Miscellaneous ------------------;;
;;----------------------------------------------;;

;;----------------------------------------------;;

(xbindkey-function '(control alt shift d) sboo-popup-date)

;;----------------------------------------------;;
;; Testing -------------------------------------;;
;;----------------------------------------------;;

;; $ guile
;;
;; > (use-modules (srfi srfi-19))
;; > (use-modules (ice-9 format))
;;
;; > ;; (define (run-command string) string)
;; > (define (run-command string) (system string))
;;
;; > (define (notify-send title message)
;;     (run-command
;;      (format #f "notify-send '~a' '~a'" title message)))
;; > (define (popup-date)
;;     (let ((DATE (date->string (current-date) "~A, ~B ~e ~Y ~H:~S"))
;;           )
;;       (notify-send "date" DATE)))
;;
;; > (format #f "notify-send '~a' '~a'" "title" "message")
;;   $1 = "notify-send 'date' 'Friday, March 29 2019 15:33'"
;; > (popup-date)
;;

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
;; Notes...

;; $ xbindkeys --version
;;
;; Version: 1.8.6

;; This configuration is guile based.

;; The release modifier is not a standard X modifier, but you can
;; use it if you want to catch release instead of press events

;; By defaults, xbindkeys does not pay attention to modifiers
;; NumLock, CapsLock and ScrollLock.
;; Uncomment the lines below if you want to use them.
;; To dissable them, call the functions with #f

;; $ xbindkeys --key
;;
;; To specify a key, you can use 'xbindkeys --key' or
;; 'xbindkeys --multikey' and put one of the two lines in this file.

;; List of keys:
;;
;; /usr/include/X11/keysymdef.h
;; /usr/include/X11/keysym.h
;;
;; The XK_ is not needed.

;; List of modifiers:
;;
;; • Release
;; • Control
;; • Shift
;; • Mod1 (Alt)
;; • Mod2 (NumLock),
;; • Mod3 (CapsLock)
;; • Mod4
;; • Mod5 (Scroll)
;; 

;;----------------------------------------------;;
;; Pop-ups...

;; xmessage (output-only):
;;
;; $ xmessage -center "Hello, World!"
;;

;; notify-send (user-input):
;;
;; $ notify-send 'title' 'message'
;;

;; dialog (user-input):
;;
;; $ dialog --checklist "Choose OS:" 15 40 5 \
;; 1 Linux off \
;; 2 Solaris on \
;; 3 'HP UX' off \
;; 4 AIX off
;;

;;----------------------------------------------;;
;; Guile:

;; e.g. « string-split »
;;
;; M-: (string-split "C-c" #\-)
;;   ⇒ ("C" "c")
;;
;; M-: (map (lambda (keychord) (string-split keychord #\-)) (string-split "M-S-a C-c" #\ ))
;;   ⇒ (("M" "S" "a") ("C" "c"))
;;
;; M-: (map (lambda (keychord) (string-split keychord #\-)) (string-split "C-c" #\ ))
;;   ⇒ (("C" "c"))
;;
;; M-: (map (lambda (keychord) (string-split keychord #\-)) (string-split "c" #\ ))
;;   ⇒ (("c"))
;;

;;----------------------------------------------;;
;; Links:

;; • /usr/include/X11/keysym.h
;; • /usr/include/X11/keysymdef.h
;;
;; • http://www.gnu.org/software/guile/guile.htm
;; • https://www.gnu.org/software/guile/manual/html_node/Strings.html#Strings
;;
;; • https://unix.stackexchange.com/questions/144924/how-to-create-a-message-box-from-the-command-line
;;

;;----------------------------------------------;;
;; EOF -----------------------------------------;;
;;----------------------------------------------;;