;; We turn (sum term a next b) into an iterative process. The local
;; evolution for is as follows
;;
;; (sum identity 0 inc 3)
;; (iter 0 0)
;; (iter 1 1)
;; (iter 2 3)
;; (iter 3 6)
;; 6
;;
;; where (define (inc x) (+ x 1)) and (define (identity x) x) for sake
;; of this example.

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (+ result (term a)))))
  (iter a 0))
