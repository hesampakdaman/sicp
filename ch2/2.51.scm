(load "2.49.scm")
(load "2.50.scm")

;; given beside
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
	   (transform-painter
	    painter1
	    (make-vect 0.0 0.0)
	    split-point
	    (make-vect 0.0 1.0)))
	  (paint-right
	   (transform-painter
	    painter2
	    split-point
	    (make-vect 1.0 0.0)
	    (make-vect 0.5 1.0))))
      (lambda (frame)
	(paint-left frame)
	(paint-right frame)))))

;; 1st implementation
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-left
	   (transform-painter
	    painter1
	    (make-vect 0.0 0.0)
	    (make-vect 1.0 0.0)
	    split-point))
	  (paint-right
	   (transform-painter
	    painter2
	    split-point
	    (make-vect 1.0 0.5)
	    (make-vect 0.0 1.0))))
      (lambda (frame)
	(paint-left frame)
	(paint-right frame)))))

;; 2nd implementation given rotate90
(define (rotate90 painter)
  (transform-painter painter
		     (make-vect 1.0 0.0)
		     (make-vect 1.0 1.0)
		     (make-vect 0.0 0.0)))

(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))
