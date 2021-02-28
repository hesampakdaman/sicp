(define (same-parity n . integers)
  (define (same-parity? m)
    (= (remainder n 2) (remainder m 2)))
  (define (parity-iter cases)
    (cond ((null? cases) cases)
	  ((same-parity? (car cases)) (cons (car cases) (parity-iter (cdr cases))))
	  (else (parity-iter (cdr cases)))))
  (cons n (parity-iter integers)))
