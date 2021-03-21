;; given: flatmap, enumerate-interval, make-pair-sum
(define (flatmap proc seq)
  (fold-right append '() (map proc seq)))
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))
(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
	  (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))
(define (distinct? tuple)
  (> (car tuple) (cadr tuple)))
(define (n-choose-k n k)
  ;; To generate unique k-tuples, generate (k-1)-unique tuples and for
  ;; reach k < j <= n insert j into each of them. Collectively to
  ;; generate and then add j back to these (k-1)-tuples.
  (define (iter j prev-tuples)
    (if (= j k)				;no more than k-tuples
        prev-tuples
        (iter
	 (+ j 1)
	 (flatmap (lambda (i) (filter
			  distinct?
			  (map (lambda (pair) (cons i pair)) prev-tuples)))
		  (enumerate-interval (+ j 1) n)))))
  (iter 2 (unique-pairs n)))
(define (unique-triples n)
  (n-choose-k n 3))
(define (make-triple-sum triple)
  (cons (fold-right + 0 triple) triple))
(define (sums-to? s)
  (lambda (triple) (= s (fold-right + 0 triple))))
(define (sum-triples s n)
  (map make-triple-sum (filter (sums-to? s) (unique-triples n))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Bonus: We can sum over the distinct k-tuples and filter so that each
; element is prime.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; fast-prime? from Ex. 1.28
(define (fast-prime? p times)
  (define true #t)
  (define false #f)
  (define (non-trivial-square? a n)
    (cond ((or (= a 1) (= a (- n 1))) false)
	  (else (= (remainder (square a) n) 1))))
  (define (expmod-iter b exp a m)
    (cond ((= exp 0) a)
	  ((even? exp)
	   (cond ((non-trivial-square? a m) 0)
		 (else (expmod-iter (remainder (square b) m) (/ exp 2) a m))))
	  (else (expmod-iter b (- exp 1) (remainder (* a b) m) m))))
  (define (expmod base exp m)
    (expmod-iter base exp 1 m))
  (define (miller-rabin-test n)
    (define (try-it a)
      (= (remainder (expmod a (- n 1) n) n) 1))
    (try-it (+ 1 (random (- n 1)))))
  (cond ((< p 2) false)
	((= times 0) true)
	((miller-rabin-test p) (fast-prime? p (- times 1)))
	(else false)))
(define (prime? p) (fast-prime? p 10))
(define (sum-k-tuples s n k)
  (map make-triple-sum (filter (sums-to? s) (n-choose-k n k))))
(define (summed-k-prime? summed-k-tuple)
  (= (car summed-k-tuple)
     (fold-right + 0 (filter prime? (cdr summed-k-tuple)))))
(define (prime-sum-k-tuple n k)
  (filter summed-k-prime? (sum-k-tuples n n k)))
