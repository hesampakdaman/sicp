(define (inc x)
  (+ x 1))

(define (dec x)
  (- x 1))

(define (rec a b)
  (if (= a 0) b (inc (rec (dec a) b))))
;; Procedure above has the local evolution of a recursive
;; process due to deferred operations of inc.
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

(define (iter a b)
  (if (= a 0) b (iter (dec a) (inc b))))
;; Procedure above has the local evolution of an iterative
;; process due to the fixed-num of state variables.
;; (+ 4 5)
;; (+ 3 6)
;; (+ 2 7)
;; (+ 1 8)
;; (+ 0 9)
;; 9
