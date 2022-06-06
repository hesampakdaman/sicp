(define (make-monitored f)
  (let ((calls 0))
    (define (mf arg)
      (cond ((eq? arg 'how-many-calls?) calls)
	    (else (set! calls (+ calls 1))
		  (f arg))))
    mf))

(define s (make-monitored sqrt))
(s 100)
(= (s 'how-many-calls?) 1)