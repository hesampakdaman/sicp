;; We run Simpson's rule with n = 100 and n = 1000,
;;
;; (simpsons-rule cube 0 1 100)  => 0.24999999999999992
;; (simpsons-rule cube 0 1 1000) => 0.2500000000000002
;;
;; From the book we have that
;;
;; (integral cube 0 1 0.01)  => 0.24998750000000042
;; (integral cube 0 1 0.001) => 0.249999875000001
;;
;; which show that Simpson's rule is more accurate both cases.

(define (cube x) (* x x x))
(define (even? n) (= (remainder n 2) 0))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

(define (simpsons-rule f a b n)
  (define (sim-term x)
    (cond ((or (= x a) (= x b)) (f x))
	  ((even? (/ (- x a) (sim-h))) (* 2.0 (f x)))
	  (else (* 4.0 (f x)))))
  (define (sim-next x) (+ x (sim-h)))
  (define (sim-h) (/ (- b a) n))
  (* (/ (sim-h) 3.0) (sum sim-term a sim-next b)))
