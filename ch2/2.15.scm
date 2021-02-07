;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

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

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
		       (div-interval one r2)))))

;; Ex. 2.15
;;
;; As an example consider the interval A below. If we use the same
;; resistors in parallel we expect the value being
;; R_par = (c +- w)/2
;; (center c and width w of the interval). In our case we have
;; that R_par = (45 55).
(define A (make-interval 90.0 110.0))
(par1 A A) ;; => (36.8 67.2)
(par2 A A) ;; => (45.0 55.0)

;; For every interval we include in the expression we must perform
;; some floating-point arithmetic to get our result. If we repeat the
;; number of occurences of any variable, the more floating-point
;; operations must be made -- which in turn can lead to accumilation
;; of error due to truncation or round-off error. We can limit such
;; error by restricting the number of variables in our expression.
;;
(div-interval A A)                                   ; => (0.818... 1.222...)
(div-interval (mul-interval A A) (mul-interval A A)) ; => (0.669 1.493)
