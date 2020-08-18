;; For applicative-order evaluation the operands are evaluated before the operator is applied.
;; The interperter tries to evaluate
;;
;; (test 0 (p))
;;
;; by first looking at (p). But evaluating (p) will return (p), which
;; in turn evaluates to (p) and we get an infinite loop.
;;
;;
;; With normal-order evaluation the combination is expanded until
;; only primitive exists. In this case we get
;;
;; (test 0 (p))
;; (if (= 0 0) 0 (p))
;; 0,
;;
;; where for evaluation of the if-statement is a special form.
