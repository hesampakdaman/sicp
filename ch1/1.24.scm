;; Number                        Actual steps             ~ log_2 n
;; 1009                               15                     10
;; 1013                               16                     10
;; 1019                               17                     10
;; 10007                              20                     13
;; 10009                              19                     13
;; 10037                              20                     13
;; 100003                             23                     17
;; 100009                             24                     17
;; 100043                             24                     17
;; 1000003                            27                     20
;; 1000033                            27		     20
;; 1000037                            28		     20
;;
;; Since the order of growth is O(log n) we expect that ratio of
;; testing for primes around 10^6 and for primes around 10^3 to be
;; log(10^6) / log(10^3) = 6 / 3 = 2.
;;
;; However, this ratio ~ 1.69 -- 1.86 < 2 depending on which primes we
;; compare. This has to do with the fact that the (fermat-test n) is
;; only roughly logarithmic with base 2: we do not consider odd
;; numbers in the time-complexity of the analysis. Using the true
;; number of steps for getting the ratios gives us better estimates.


(define (runtime)
  (define now (gettimeofday))
  (+ (car now) (/ (cdr now) 1000000.)))

(define (square x) (* x x))

(define true #t)
(define false #f)

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

(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10)
      (- (runtime) start-time)))

(define (get-ratio n m)
  (/ (timed-prime-test n) (timed-prime-test m)))

(define (acc-ratio n m ratio count)
  (cond ((= count 0) ratio)
	(else (acc-ratio n m (+ ratio (get-ratio n m)) (- count 1)))))

(define (mean-time-ratio n m)
  (/ (acc-ratio n m 0 1000) 1000))

(define (get-steps n)
  (steps n 0))

(define (steps n current)
  (cond ((= n 1) current)
	((even? n) (steps (/ n 2) (+ current 1)))
	 (else (steps (- n 1) (+ current 1)))))
