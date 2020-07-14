(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      ;; Modified the procedure here to print intermediate steps.
      (display next)
      (newline)
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))


;; We calculate the fixed point without average damping and note that
;; the number of steps is 37.
(fixed-point (lambda (x) (/ (log 1000) (log x))) 1.1)

(newline)

;; Here we introduce average damping and note that the number of steps
;; is 13, which is less than half the steps required by the naive
;; method.
(define (average x y) (/ (+ x y) 2))
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 1.1)
