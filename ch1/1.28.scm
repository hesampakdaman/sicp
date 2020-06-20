;; We replace expmod with an iterative process, see ex. 1.16. This way
;; we can check if in any intermidate step we can find a non-trivial
;; square whenever the exponent is even. We check our design against
;; the Carmichael numbers.

(define (square x) (* x x))

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

(define (fast-prime? n times)
  (cond ((= times 0) true)
	((miller-rabin-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (test-miller-rabin)
  (cond ((not (fast-prime? 2 2)) false)
	((not (fast-prime? 3 3)) false)
	((not (fast-prime? 19 10)) false)
	((not (fast-prime? 1009 10)) false)
	((not (fast-prime? 10007 10)) false)
	((not (fast-prime? 1000033 10)) false)
	((fast-prime? 561 50) false)
	((fast-prime? 1105 50) false)
	((fast-prime? 1729 50) false)
	((fast-prime? 2465 50) false)
	((fast-prime? 2821 50) false)
	((fast-prime? 6601 50) false)
	(else true)))
