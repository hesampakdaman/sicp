;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

;; Ex. 2.11
(define (mod-mul-interval x y)
  (let ((lx (lower-bound x)) (ly (lower-bound y))
	(ux (upper-bound x)) (uy (upper-bound y))
	(pos? positive?) (neg? negative?)
	(mk-iv make-interval))
    ;; Ordering the conditionals like below does make some of the
    ;; tests redudant. Nevertheless, these have been kept for
    ;; readability.
    (cond ((and (neg? ux) (neg? uy)) (make-interval (* ux uy) (* lx ly)))
	  ((and (neg? ux) (pos? ly)) (make-interval (* lx uy) (* ux ly)))
	  ((and (neg? ux) (pos? uy) (neg? ly)) (make-interval (* lx uy) (* lx ly)))
	  ((and (pos? lx) (neg? uy)) (make-interval (* ux ly) (* lx uy)))
	  ((and (pos? lx) (pos? ly)) (make-interval (* lx ly) (* ux uy)))
	  ((and (pos? lx) (pos? uy) (neg? ly)) (make-interval (* ux ly) (* ux uy)))
	  ((and (pos? ux) (neg? lx) (neg? uy)) (make-interval (* ux ly) (* lx ly)))
	  ((and (pos? ux) (neg? lx) (pos? uy) (pos? ly)) (make-interval (* lx uy) (* ux uy)))
	  ((and (pos? ux) (neg? lx) (pos? uy) (neg? ly))
	   (make-interval (min (* lx uy) (* ux ly)) (max (* lx ly) (* ux uy)))))))
