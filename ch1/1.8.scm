(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (sum-div x y z)
  (/ (+ x y) z))

(define (improve guess x)
  (sum-div (/ x (square guess)) (* 2 guess) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x) (sqrt-iter 1.0 x))

(display (sqrt-iter 4.1 64.0))
(display "\n")
