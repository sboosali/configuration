(define (sboo-xbindkeys_show) (run-command "xbindkeys_show"))

(xbindkey-function '(control alt shift q) sboo-xbindkeys_show)

