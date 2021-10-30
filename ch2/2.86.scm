;; The real-part, imag-part, magnitude and angle of a complex number
;; can now be any data type. Because of this we need to handle them in
;; a generic manner. The arithmetic operations +, -, * and / must
;; therefore be changed for their generic part inside these
;; packages.

;; First we make the changes to complex package
(define (add-complex z1 z2)
  (make-from-real-imag (add (real-part z1) (real-part z2))
		       (add (imag-part z1) (imag-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-imag (sub (real-part z1) (real-part z2))
		       (sub (imag-part z1) (imag-part z2))))
(define (mul-complex z1 z2)
  (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
		     (add (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-mag-ang (div (magnitude z1) (magnitude z2))
		     (sub (angle z1) (angle z2))))
(define (eq-complex? z1 z2)
  (and (equ? (real-part z1) (real-part z2))
       (equ? (imag-part z1) (imag-part z2))))
(define (=zero-complex? z)
  (and (=zero? (real-part z)) (=zero? (imag-part z))))

;; From this we see that the implementations of rectangular and polar
;; must now handle arguments of different types. We make sure that
;; real-part, imag-part, magnitude and angle handle this in both
;; implementations. We need first to introduce new generic operators.
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctan x) (apply-generic 'arctan x))
(define (square-generic x) (apply-generic 'square x))

;; Now we make the changes necessary in rectangular package
(define (magnitude z)
  (sqrt (+ (square-generic (real-part z))
	   (square-generic (imag-part z)))))
(define (angle z)
  (arctan (div (imag-part z) (real-part z))))
(define (make-from-mag-ang r a)
  (cons (mul r (cosine a)) (mul r (sine a))))

;; Changes to polar package
(define (real-part z) (mul (magnitude z) (cosine (angle z))))
(define (imag-part z) (mul (magnitude z) (sine (angle z))))
(define (make-from-real-imag x y)
  (cons (sqrt (+ (square-generic x) (square-generic y)))
	(arctan (div y x))))

;; We need to install the new operators we've introduced. For the
;; rational package we must make the following changes.
(define (sine-rat x)
  (sin (/ (numer x) (denom x))))
(define (cosine-rat x)
  (cos (/ (numer x) (denom x))))
(define (arctan-rat x)
  (atan (/ (numer x) (denom x))))
(define (square-rat x)
  (square (/ (numer x) (denom x))))
(put 'sine '(rational) sine-rat)
(put 'cosine '(rational) cosine-rat)
(put 'arctan '(rational) arctan-rat)
(put 'square '(rational) square-rat)

;; And for ordinary number package we just need to bind them to Scheme
;; primitives. We have the following changes
(put 'sine '(scheme-number) sin)
(put 'cosine '(scheme-number) cos)
(put 'arctan '(scheme-number) atan)
(put 'square '(scheme-number) square)

;; Finally, we must make sure to have coercion for scheme-number to
;; rational. We add the following procedure to the coercion table
(define (scheme-number->rational n)
  (make-rational (contents n) 1))
(put-coercion 'scheme-number 'rational scheme-number->rational)
