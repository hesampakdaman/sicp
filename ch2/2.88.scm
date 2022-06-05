;; We define subtraction by taking the negation of the second term
;; before adding it to the first.
(define (sub-poly p1 p2)
  (add-poly p1 (negate p2)))
(put 'sub '(polynomial polynomial) sub-poly)

;; Therefore, we need to define a generic negation operator and
;; install it in our system.
(define (negate x)
  (apply-generic 'negate x))

;; To negate a polynomial we negate each of its terms in it. This is
;; installed inside the polynomial package.
(define (negate-poly p)
  (make-polynomial (variable p) (mul-term-by-all-terms (make-term 0 -1) (term-list p))))
(put 'negate '(polynomial) negate-poly)

;; Installed in complex numbers. Here we assume real and complex parts
;; of a complex number can be of type rational or ordinary
;; number. This is why we use generic negate for each of them. Recall
;; that make-complex-from-real-imag tags the data as 'complex.
(define (negate-complex z)
  (make-complex-from-real-imag (negate (real-part z)) (negate (imag-part z))))
(put 'negate '(complex) negate-complex)

;; Installed in rational package.
(define (negate-rational r)
  (make-rational (negate (numer r) (denom r))
(put 'negate '(rational) negate-rational)

;; Installed in scheme-number package. Assuming ordinary numbers
;; defined as in Ex. 2.78 we do not have to bother with tagging by
;; 'scheme-number for negation.
(define (negate-ordinary n) (* -1 n))
(put 'negate '(scheme-number) negate-ordinary)
