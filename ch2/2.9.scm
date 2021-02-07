;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

;; Ex. 2.9
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;; We show that the width of an interval, that is the result from
;; adding y to x, is a function of adding the widths of x and y.
;;
;; (width (add-interval x y))
;; (width (make-interval (+ (lower-bound x) (lower-bound y))
;; 		         (+ (upper-bound x) (upper-bound y))))
;; (width ((+ (lower-bound x) (lower-bound y)) . (+ (upper-bound x) (upper-bound y))))
;; (/ (- (+ (upper-bound x) (upper-bound y)) (+ (lower-bound x) (lower-bound y))) 2)
;; (/ (+ (- (upper-bound x) (lower-bound x)) (- (upper-bound y) (lower-bound y))) 2)
;; (+ (/ (- (upper-bound x) (lower-bound x)) 2) (/ (- (upper-bound y) (lower-bound y)) 2))
;; (+ (width x) (width y))
;;
;;
;; For subtraction the sign in (make-interval) is changed, resulting
;; in the widths of x and y being subtracted as opposed to added like
;; above.
;;
;; (width (sub-interval x y))
;; (width (add-interval x (negative-y)))
;; (width (make-interval (+ (lower-bound x) (* -1 (lower-bound y)))
;; 		         (+ (upper-bound x) (* -1 (upper-bound y)))))
;; (width (make-interval (- (lower-bound x) (lower-bound y))
;; 		         (- (upper-bound x) (upper-bound y))))
;; (width ((- (lower-bound x) (lower-bound y)) . (- (upper-bound x) (upper-bound y))))
;; (/ (- (- (upper-bound x) (upper-bound y)) (- (lower-bound x) (lower-bound y))) 2)
;; (/ (- (- (upper-bound x) (lower-bound x)) (- (upper-bound y) (lower-bound y))) 2)
;; (- (/ (- (upper-bound x) (lower-bound x)) 2) (/ (- (upper-bound y) (lower-bound y)) 2))
;; (- (width x) (width y))
;;
;; In general we cannot add or subtract the respective widths of the
;; arguments to (mul-interval) to get the width of the interval we get
;; from multiplication. To see this, consider the intervals
;;
;;                       x = (0 2), y = (-1 0)
;;
;; Their widths are 1 and 0.5, respectively. Multiplication yields an
;; interval (-2 0) with the width of 1. With simple addition (or
;; subtraction) the widths of x and y produce either 1.5 or 0.5 --
;; neither of which are correct.
;;
;; For division, simply take two intervals that are co-prime. Let x =
;; (2 . 4) and y = (3 . 5). Then (div-interval x y) = (2/5 . 4/3) has
;; a width that is not an integer. Whereas subtraction or additon of x
;; or y always yields a whole number.
