(define (iterative-improve good-enough? improve-guess)
  (define (iterate guess)
    (if (good-enough? guess)
	guess
	(iterate (improve-guess guess))))
  iterate)

(define (tolerant-comparison next target tolerance)
  (lambda (guess)
    (< (abs (- (next guess) (target guess))) tolerance)))

(define (fixed-point f first-guess)
  (define good-enough?
    (tolerant-comparison f identity 0.00001))
  ((iterative-improve good-enough? f) first-guess))

(define (sqrt x)
  (define (average a b) (/ (+ a b) 2))
  (define (square a) (* a a))
  (define (improve guess) (average guess (/ x guess)))
  (define good-enough?
    (tolerant-comparison square (lambda (y) x) 0.001))
  ((iterative-improve good-enough? improve) 1.0))
