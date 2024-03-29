(load "table.scm")
(load "project.scm")
(load "raise.scm")

(load "ordinary.scm")
(load "rational.scm")
(load "complex.scm")
(load "term.scm")
(load "polynomial.scm")

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (greatest-common-divisor x y)
  (apply-generic 'greatest-common-divisor x y))
(define (reduce x y) (apply-generic 'reduce x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctan x) (apply-generic 'arctan x))
(define (square-generic x) (apply-generic 'square x))
(define (negate x) (apply-generic 'negate x))

(install-scheme-number-package)
(install-rational-package)
(install-complex-package)
(install-term-package)
(install-polynomial-package)
