(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))

(((double (double double)) inc) 5)

;; The combination above yields 21. Too see this start by expanding
;; the leftmost inner combination
;;
;; (double double) -> (double (double))
;;
;; Hence we get (double (double (double))). We know that the operator
;; applies the operand twice, so that
;;
;; (double (double (double))) -> ((double (double (double (double))))).
;;
;; If we apply the operator above on (inc x), then we will double it
;; four times, i.e x will be incremented by 16 (each double will
;; increment x with 2, 4, 8 and lasty with 16).
;;
;; Therefore, the following combination is equivalent

((double (double (double (double inc)))) 5)
