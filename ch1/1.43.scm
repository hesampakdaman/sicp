(define (square x) (* x x))

;; Taken from Ex. 1.42
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (repeated (compose f f) (- n 1))))

((repeated square 2) 5)
