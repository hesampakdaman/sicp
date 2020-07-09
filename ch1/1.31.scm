;; Part a)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (factorial n)
  (define (identity x) x)
  (define (inc x) (+ x 1))
  (product identity 1 inc n))

(define (pi-product n)
  (define (square x) (* x x))
  (define (pi-term x)
    (/ (square x) (* (+ x 1) (- x 1))))
  (define (pi-next x) (+ x 2))
  (* (/ 2 3) (product pi-term 4.0 pi-next n)))


;; In part b) we (define (product-iter)) which generates an iterative
;; processes since (product n) generates a recursive one.

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (* result (term a)))))
  (iter a 1))
