(define (same-parity n . integers)
  (define (same-parity? m)
    (= (remainder n 2) (remainder m 2)))
  (define (iter cases)
    (cond ((null? cases) #nil)
	  ((same-parity? (car cases)) (cons (car cases) (iter (cdr cases))))
	  (else (iter (cdr cases)))))
  (cons n (iter integers)))
