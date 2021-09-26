;; =zero? is a predicate and therefore we do not tag it when returning
;; the answer from each package. Simply return the boolean. Since we
;; use apply-generic we need to install =zero? as '(type) because
;; apply-generic uses map to get the types.

(define (install-scheme-number-package)
  ;; procedures from p. 256 with addition of
  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
  'done)

(define (install-rational-package)
  ;; all procedures in p. 257 with the addition of
  (put '=zero? '(rational) (lambda (x) (= (numer x) 0)))
  'done)

(define (install-complex-package)
  ;; all procedures in p. 258 with the addition of
  (define (=zero-complex? z)
    (and (= (real-part z) 0) (= (imag-part z) 0)))
  (put '=zero? '(complex) =zero-complex?)
  'done)

;; generic interface
(define (=zero? x)
  (apply-generic '=zero? x))
