;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
		  (/ 1.0 (lower-bound y)))))

;; Ex. 2.10
(define (spans-zero? i)
  ;; An interval that spans zero has diffrent signs for lower- and
  ;; upper-bound.
  (let ((lower (lower-bound i))
	(upper (upper-bound i)))
    (and (negative? lower) (positive? upper))))

(define (safe-div-interval x y)
  (if (spans-zero? y)
      (display "Error, denominator spans zero.\n")
      (div-interval x y)))
