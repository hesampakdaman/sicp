;; abs is defined as x if x > 0 and -x otherwise. This way abs x is
;; always positive. We can ensure this by choosing the correct
;; operator (+ or -) when adding it to a.
;;
;; When (if (> b 0) + -) is evaluated, it returns either the operator
;; + or - that will ensure we get the correct sign of abs b before
;; it's added to a.
