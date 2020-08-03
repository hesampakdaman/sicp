;; We are allowed to assume any arithmetic operations that we need are
;; available as primitives. For our purpose we need the function that
;; rasies x to the n:th power. This is implemented as (expt x n) in
;; Scheme.
;;
;; TODO: Find the number of times to repeate average-damp in order to
;; make (nth-root x n) converge.

(define (fixed-point f first-guess)
  (define tolerance 0.0001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (repeated (compose f f) (- n 1))))

(define (nth-root x n)
  (fixed-point ((repeated average-damp 2)
		(lambda (y) (/ x (expt y (- n 1)))))
	       1.0))

;; (define x 1729)
;; (define n 7)
;; (define k 3)
;; (display (ceiling (* 3 (log (log n)))))
;; (define a (nth-root x n))
;; (display (ceiling (/ x (expt 2 n))))
;; (newline)

;; 1  2  3  4   5    6
;; 2, 4, 8, 32, 507, 128000
