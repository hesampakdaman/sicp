;; We have shown that the golden ratio is a fixed point to the mapping
;; x |-> 1 + 1/x (see 1.35.pdf). Now we use the procedure
;; (fixed-point) to get an approximation of the number.

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

;; The call below results in 1.6180327868852458, which is correct up
;; until the 6th decimal.
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
