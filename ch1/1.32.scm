;; In part a) we write a procedure that generates a recursive process.

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate-iter + 0.0 term a next b))

(define (product term a next b)
  (accumulate-iter * 1.0 term a next b))


;; Since in part a) we have a recursive process, we show that
;; (accumulate) can be written to generate an iterative process.

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (combiner result (term a)))))
  (iter a null-value))
