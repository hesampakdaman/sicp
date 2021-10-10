;; included in integer package
(define (raise-integer n)
  ((get 'make 'rational) n 1))
(put 'raise 'integer raise-integer)

;; included in rational package
(define (raise-rational q)
  ((get 'make 'real) (/ (numer q) (denom q))))
(put 'raise 'rational raise-rational)

;; included in real package
(define (raise-real x)
  ((get 'make-from-real-imag 'complex) x 0))
(put 'raise 'real raise-real)

;; generic interface
(define (raise x)
  ((get 'raise (type-tag x)) (contents x)))
