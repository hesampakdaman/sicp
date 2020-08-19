(define (inc x)
  (+ x 1))

(define (dec x)
  (- x 1))

(define (+ a b)
  (if (= a 0) b (inc (+ (dec a) b))))
;; Procedure above has the local evolution of a recursive process due
;; to deferred operations of +. This happens because whenever a =/= 0
;; then + is called recusively with a decremented by 1. Its return
;; value cannot be know until a = 0.
;;
;; (+ 4 5)
;; (inc (+ 3 5))
;; (inc (inc (+ 2 5)))
;; (inc (inc (inc (+ 1 5))))
;; (inc (inc (inc (inc (+ 0 5)))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9

(define (+ a b)
  (if (= a 0) b (+ (dec a) (inc b))))
;; Procedure above has the local evolution of an iterative process
;; because the state-variables' value can be calculated and are know
;; in each step. At any step we may stop the calculation and we will
;; know how to restart it becauuse there are no deferred operations
;; here.
;;
;; (+ 4 5)
;; (+ 3 6)
;; (+ 2 7)
;; (+ 1 8)
;; (+ 0 9)
;; 9
