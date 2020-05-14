;; First we note that sqrt 10 ~ 3.16. We take the average time for
;; finding these three primes. For primes near 1000 and 10 000 the
;; ratio is 2.48. When n is 100 000 and 1 000 000 the average ratio is
;; 3.05.

;; We claim that the ratio gets closer to sqrt 10 as n grows. To
;; investigate further we found bigger primes and calculated the ratio
;; between 10 000 000 and 1 000 000 to be 3.12. With 100 000 000 and
;; 10 000 000 we get 3.14. This supports the idea that the algorithm
;; is O(sqrt n).
;;
;; Found primes:
;; (1009, 1013, 1019, 10007, 10009, 10037,
;; 100003, 100019, 100043, 1000003, 1000033, 1000037)
;;
;; Average Times
;; 1000:                           4.01496887207e-6
;; 10000:                          9.95755195621e-6
;; 100000:                         2.87353992462e-5
;; 1000000:                        8.75914096833e-5
;; 10000000:                       2.73623466492e-4
;; 100000000:                      8.60544443131e-4


(define (runtime)
  (define now (gettimeofday))
  (+ (car now) (/ (cdr now) 1000000.)))

(define (square x) (* x x))

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes n)
  (if (even? n) (larger-than-n-primes (+ n 1) 50)
      (larger-than-n-primes n 50)))

(define (larger-than-n-primes n count)
  (timed-prime-test n)
  (if (> count 0) (larger-than-n-primes (+ n 2) (- count 1))))
