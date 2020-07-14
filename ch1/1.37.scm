;; Part a) First we have that1/phi = 0.61803398875... Define cont-frac
;; with a helper function that generates a recursive process.

(define (cont-frac n d k)
  (define (frac-rec i)
    (if (= i k)
	(/ (n i) (d i))
	(/ (n i) (+ (d i) (frac-rec (+ i 1))))))
  (frac-rec 1))

;; With k = 11 we get 0.618055.. which is correct up to 4 decimals.

(cont-frac (lambda (i) 1.0)
	   (lambda (i) 1.0)
	   11)

;; Part (b) Since (cont-frac n d k) generates a recursive process we
;; re-write it such that it generates an iterative process.

(define (cont-frac-iter n d k)
  (define (frac-iter k result)
    (if (= k 0)
	result
	(frac-iter (- k 1) (/ (n k) (+ (d k) result)))))
  (frac-iter k 0.0))
