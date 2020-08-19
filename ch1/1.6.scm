;; In (sqrt-iter) the procedurue (new-if) has no special form and will
;; be evaluated as any other combination using
;; applicative-order. Hence, its arguments will be evaluated before
;; the operand is applied:
;;
;; (new if (good-enough? guess x)
;;         guess
;;         (sqrt-iter (improve guess x) x))
;;
;; When the interpreter tries to evaluated the last argument it will
;; recurse to (sqrt-iter). There it will find (new-if) again which in
;; turn will evaluate the last argument of (sqrt-iter (improve guess x) x).
;; This goes on in an infinite loop.
