;; We define (test-numbers-below-n n) that will run the fermat test
;; for each non-negative integer a < n. Indeed, the all of the
;; Carmichael numbers listed in Footnote 1.47 (561, 1105, 1729, 2465,
;; 2821, and 6601) pass the test. This shows that the fermat test is a
;; necessary condition for n being prime, but not sufficient.


(define (square x) (* x x))

(define true #t)
(define false #f)

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder
	  (square (expmod base (/ exp 2) m))
	  m))
	(else
	 (remainder
	  (* base (expmod base (- exp 1) m))
	  m))))

(define (fermat-test a n)
  (= (remainder (expmod a n n) n) a))

(define (fast-prime? a n)
  (cond ((= a n) true)
	((fermat-test a n) (fast-prime? (+ a 1) n))
	(else false)))

(define (test-numbers-below-n n)
  (fast-prime? 0 n))
