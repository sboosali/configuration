;;----------------------------------------------;;
;; Imports -------------------------------------;;
;;----------------------------------------------;;

(use-modules (srfi srfi-19))
(use-modules (ice-9 format))

;;----------------------------------------------;;
;; Definitions ---------------------------------;;
;;----------------------------------------------;;

(define (sboo-xbindkeys_show)

  (run-command "xbindkeys_show"))

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

(define (sboo-popup-date)

  (let ((DATE (date->string (current-date) "~A, ~B ~e ~Y ~H:~S"))
        )

  (notify-send "date" DATE)))

;;----------------------------------------------;;
;; Keybindings ---------------------------------;;
;;----------------------------------------------;;

(xbindkey-function '(control alt shift q) sboo-xbindkeys_show)

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
;; > (define (run-command string) string)
;; > (define (run-command string) (string))
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
;; EOF -----------------------------------------;;
;;----------------------------------------------;;