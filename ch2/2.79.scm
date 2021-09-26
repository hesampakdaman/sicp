;; Since equ? returns true or false we do not need to tag the data it
;; in each package. We simply return the boolean.

(define (install-scheme-number-package)
  ;; procedures from p. 256 with addition of
  (put 'equ? '(scheme-number scheme-number) =)
  'done)

(define (install-rational-package)
  ;; all procedures in p. 257 with the addition of
  (define (eq-rat? x y)
    ;; this is possible since we divide by the gcd in the constructor
    (and (= (numer x) (numer y))
	 (= (denom x) (denom y))))
  (put 'equ? '(rational rational) eq-rat?)
  'done)

(define (install-complex-package)
  ;; all procedures in p. 258 with the addition of
  (define (eq-complex? z1 z2)
    (and (= (real-part z1) (real-part z2))
	 (= (imag-part z1) (imag-part z2))))
  (put 'equ? '(complex complex) eq-complex?)
  'done)

;; generic interface
(define (equ? x y)
  (apply-generic 'equ? x y))
