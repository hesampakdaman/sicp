(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cadr x))
  (define (make-rat n d)
    (reduce n d))
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
		 (mul (numer y) (denom x)))
	      (mul (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y))
		 (mul (numer y) (denom x)))
	      (mul (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
	      (mul (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y))
	      (mul (denom x) (numer y))))
  (define (equ-rat? r s)
    (and (equ? (numer r) (numer s))
	 (equ? (denom r) (denom s))))
  (define (sine-rat x)
    (sine (div (numer x) (denom x))))
  (define (cosine-rat x)
    (cosine (div (numer x) (denom x))))
  (define (arctan-rat x)
    (arctan (div (numer x) (denom x))))
  (define (square-rat x)
    (square (div (numer x) (denom x))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'equ? '(rational rational) equ-rat?)
  (put '=zero? '(rational) (lambda (x) (= (numer x) 0)))
  (put 'sine '(rational) sine-rat)
  (put 'cosine '(rational) cosine-rat)
  (put 'arctan '(rational) arctan-rat)
  (put 'square '(rational) square-rat)
  (put 'raise 'rational (lambda (r) (make-complex-from-real-imag (tag r) 0)))
  (put 'negate '(rational)
       (lambda (r) (tag (make-rat (negate (numer r)) (denom r)))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))