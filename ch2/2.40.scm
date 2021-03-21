;; given: flatmap, enumerate-interval, make-pair-sum, prime-sum?
(define (flatmap proc seq)
  (fold-right append '() (map proc seq)))
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (prime? p)
  (null? (filter (lambda (q) (= (remainder p q) 0))
		 (enumerate-interval 2 (- p 1)))))
(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
	  (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
