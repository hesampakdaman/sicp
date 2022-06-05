;; A polynomial is defined zero if all its coefficients are 0. So we
;; loop over all coefficents in the polynomial's term-list and check
;; whether they are 0 or not. Note that we make use of generic =zero?
;; and doing so allows for recursive data dispatch -- in case the
;; coefficents themselves are polynomial (or any other type supported
;; in our system).

;; included in polynomial-install-package
(define (=zero-poly? p)
  (define (=zero-iterative terms)
    (cond ((empty-termlist? terms) true)
	  ((not (=zero? (coeff (first-term terms)))) false)
	  (else (=zero-iterative (rest-terms terms)))))
  (=zero-iterative (term-list p)))
(put '=zero? '(polynomial) =zero-poly?)
