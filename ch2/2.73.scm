(load "2.56.scm")

;; Given by the exercise.
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) (if (same-variable? exp var) 1 0))
	(else ((get 'deriv (operator exp))
	       (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; a) Instead of checking the type of expression exp is and applying
;; derivation directly in deriv, we use a lookup table to fetch the
;; correct operator and apply it to the operands. Instead of explicit
;; dispatch we have adopted data-directed programming.
;;
;; Any expression put into deriv does not have a tag for number or
;; variable. Due to this fact we cannot assimliate these predicates
;; into the data-directed dispatch.

;; b/c) We implement the install-package and include derivation of
;; exponentation.
(define (install-deriv-package)
  ;; internal procedures
  ;; changed selectors since deriv hands them to the operator
  (define addend car)
  (define augend cadr)
  (define multiplier car)
  (define multiplicand cadr)
  (define base car)
  (define exponent cadr)
  ;; make-sum/make-product loaded from 2.56.scm
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
	      (deriv (augend operands) var)))
  (define (deriv-product operands var)
    (make-sum
     (make-product (multiplier operands)
		   (deriv (multiplicand operands) var))
     (make-product (deriv (multiplier operands) var)
		   (multiplicand operands))))
  (define (deriv-exponent operands var)
    (let ((b (base operands))
	  (n (exponent operands)))
      (make-product
       (make-product n (make-exponentiation b (- n 1)))
       (deriv b var))))
  ;; interface to the rest of the system
  ;; there's no need for a constructor that attaches tags to the data
  ;; created. this is already done by make-sum/make-product functions.
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  (put 'deriv '** deriv-exponent)
  'done)

;; d) We then change the order of the arguments to the put function in
;; install-deriv-package. We instead get
(put '+ 'deriv deriv-sum)
(put '* 'deriv 'deriv deriv-product)
(put '** 'deriv 'deriv deriv-exponent)
