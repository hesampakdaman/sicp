(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))


(define (make-segment p q) (cons p q))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))


;; First representation
(define (make-rect p q)
  ;; We represent a rectangle as a diagonal created by the line
  ;; segment between points p q.
  (make-segment p q))

(define (length-rect r coord)
  ;; For a rectangle r we choose which coordinate to calculate the
  ;; length for.
  (let ((p (start-segment r))
	(q (end-segment r)))
    (abs (- (coord p) (coord q)))))
(define (width-rect r) (length-rect r x-point))
(define (height-rect r) (length-rect r y-point))


;; Second representation
(define (make-rect s w)
  ;; In the second version we represent rectangles with its base s
  ;; (line segment) and the width (number).
  (cons s w))
(define (width-rect r) (cdr r))
(define (height-rect r)
  (let ((p (start-segment (car r)))
	(q (end-segment (car r))))
    (abs (- (x-point p) (x-point q)))))


;; Both procedures below work with any of the representations above.
(define (area-rect r)
  (* (width-rect r) (height-rect r)))
(define (perimeter-rect r)
  (* 2 (+ (width-rect r) (height-rect r))))
