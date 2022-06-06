;; Following the footnote's instructions we create a simple
;; rand-update with values for a, b and m chosen from Wikipedia's
;; Linear congruential generator article.
(define (rand-update x)
  (let ((a 4)
	(b 1)
	(m 9))
  (remainder (+ (* a x) b) m)))

(define rand
  (let ((x 0))
    (define (dispatch m)
      (cond ((eq? m 'reset) reset-seed)
	    ((eq? m 'generate) (generate-random))
	    (else (error "Need a symbol 'reset or 'generate"))))
    (define (generate-random)
      (set! x (rand-update x))
      x)
    (define (reset-seed new-value)
      (set! x new-value)
      '())
    dispatch))

(= (rand 'generate) 1)
(= (rand 'generate) 5)
((rand 'reset) 0)
(= (rand 'generate) 1)
(= (rand 'generate) 5)
