;; We define (cubic a b c) in terms of (cube) and (square)
;; abstractions. Newton's method and fixed-point abstractions are take
;; directly from the book.

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (newton-transform g)
  (define (deriv g)
    (define dx 0.00001)
    (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (square x) (* x x))

(define (cube x) (* x (square x)))

(define (cubic a b c)
  (lambda (x) (+ (cube x)
		 (* a (square x))
		 (* b x)
		 c)))

(newtons-method (cubic 1 0 1) 1)
