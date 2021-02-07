;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

;; Ex. 2.8
;;
;; Let z be the interval that we get by subracting interval x by y. We
;; define subtraction of intervals by shrinkage. z's upper-bound is
;; given by shrinking x's upper-bound with y's upper-bound. Therefore,
;; z's upper-bound equals (upper-bound x) - (upper-bound y).
;;
;; Using the substiution model, we see that subtraction can be defined
;; in terms of interval addition, i.e. x + (-y).
(define (negate-interval x)
  (make-interval (* -1 (lower-bound x)) (* -1 (upper-bound x))))

(define (sub-interval x y)
  (add-interval x (negate-interval y)))
