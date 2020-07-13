;; Procedures used in both parts a) and b) of the exercise.

(define (filtered-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
	((filter a)
	 (combiner (term a)
		   (filtered-accumulate filter combiner null-value term (next a) next b)))
	(else (filtered-accumulate filter combiner null-value term (next a) next b))))

(define (inc x) (+ x 1))

;; In part a) we take (fast-prime? n times) from Ex. 1.24 and use
;; block stucture.

(define (square x) (* x x))

(define (prime? n)
  (define (fast-prime? times)
    (define (expmod base exp m)
      (cond ((= exp 0) 1)
	    ((even? exp)
	     (remainder
	      (square (expmod base (/ exp 2) m))
	      m))
	    (else
	     (remainder
	      (* base (expmod base (- exp 1) m))
	      m))))
    (define (fermat-test n)
      (define (try-it a)
	(= (remainder (expmod a n n) n) a))
      (try-it (+ 1 (random (- n 1)))))
    (cond ((= times 0) #t)
	  ((fermat-test n) (fast-prime? (- times 1)))
	  (else #f)))
  (fast-prime? 10))

;; Part a)

(define (sum-of-squares-prime a b)
  (filtered-accumulate prime? + 0 square a inc b))

;; Using Euclide's algorithm to implement (gcd a b). This is direct
;; copy from the book on p. 63.

(define (product-relative-prime n)
  (define (gcd a b)
    (if (= b 0)
	a
	(gcd b (remainder a b))))
  (define (relative-prime? i)
    (= (gcd i n) 1))
  (define (identity x) x)
  (filtered-accumulate relative-prime? * 1 identity 1 inc (- n 1)))
