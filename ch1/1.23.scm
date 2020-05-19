;; The times we get using (next test-divisor) modification in
;; (smallest-divisor) are
;;
;; 1000:              3.54647636414e-6
;; 10000:             6.78420066835e-6
;; 100000:	      2.0252863566e-5
;; 1000000:           6.28304481506e-5
;; 10000000:          1.99911594391e-4
;;
;; This modified verison will half the numbers of test
;; steps. Therefore, the time-complexity will be the same as running
;; the older algorithm but with input n/2. Consequently, we expect the
;; ratio between the times to be sqrt(n) / sqrt(n/2) = sqrt(2) ~ 1.41.
;;
;; Our tests gives us a ratio between the modified and the old
;; algorithm (see 1.22.scm) that goes towards 1.4 as n grows, which
;; support our claim.

(define (runtime)
  (define now (gettimeofday))
  (+ (car now) (/ (cdr now) 1000000.)))

(define (square x) (* x x))

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

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

(define (next n)
  (if (= n 2) 3
      (+ n 2)))
