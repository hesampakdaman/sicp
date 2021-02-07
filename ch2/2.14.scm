;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent c tol)
  (make-center-width c (* 0.01 c tol)))

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

;; Ex. 2.14
;;
;; Using A and B defined as below, we can see that we get error in the
;; 16:th decimal due to usage of floating point arithmetics. Hence,
;; A/A = (1.0 1.0) and A/B = (0.1 0.1). This is wrong since the
;; correct answer is A/A = (0.999999999999999 1.000000000000001) and
;; A/B = (0.099999999999999 0.100000000000009)
(define A (make-center-percent 1.0  0.00000000000005))
(define B (make-center-percent 10.0 0.00000000000005))
(div-interval A A)
(div-interval A B)
