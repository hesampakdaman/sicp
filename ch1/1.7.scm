(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(display (sqrt-iter 1.0 9))
(display "\n")

(define (good-enough-improved? guess-new guess-old)
  (< (abs (/ (- guess-new guess-old) guess-old)) 0))

(define (sqrt-iter-improved guess x)
  (if (good-enough-improved? (improve guess x) x)
      guess
      (sqrt-iter (improve guess x) guess)))

(display (sqrt-iter-improved 1.0 9.0))
(display "\n")
