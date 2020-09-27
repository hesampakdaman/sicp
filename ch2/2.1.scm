;; We define a sign function that will return the sign of any
;; number. This function is then applied in the constructor to
;; normalize the sign of the rational number, as desired.

(define (sgn n)
  (if (>= n 0)
      1
      -1))

;; constructor
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ (* (sgn d) n) g)
	  (/ (abs d) g))))

;; selectors
(define (numer x) (car x))
(define (denom x) (cdr x))

;; string representation
(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))
