(define (square x)
  (* x x))

(define (sum-of-squares a b)
  (+ (square a) (square b)))

(define (sum-square-larger a b c)
  (cond ((and (>= a b) (>= b c)) (sum-of-squares a b))
	((and (>= a b) (>= c b)) (sum-of-squares a c))
	(else (sum-of-squares b c))))
