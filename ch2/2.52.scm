(load "2.44.scm")
(load "2.49.scm")
(load "2.51.scm")

;;a) we simply add more segments to the wave painter
(define wave-smile
  (let ((left-innerleg    (make-vect 0.40 0.00))
	(left-crotch      (make-vect 0.45 0.40))
	(left-outerleg    (make-vect 0.30 0.00))
	(left-armpit      (make-vect 0.38 0.60))
	(left-armpit-ext  (make-vect 0.30 0.60))
	(left-elbow       (make-vect 0.20 0.50))
	(left-underhand   (make-vect 0.00 0.60))
	(left-overhand    (make-vect 0.00 0.70))
	(left-overelbow   (make-vect 0.20 0.60))
	(left-overarmpit  (make-vect 0.30 0.70))
	(left-shoulder    (make-vect 0.40 0.70))
	(left-middlehead  (make-vect 0.35 0.85))
	(left-mouth       (make-vect 0.40 0.80))
	(left-tophead     (make-vect 0.40 1.00))
	(middle-mouth     (make-vect 0.50 0.78))
	(right-crotch     (make-vect 0.55 0.40))
	(right-innerleg   (make-vect 0.60 0.00))
	(right-outerleg   (make-vect 0.70 0.00))
	(right-armpit     (make-vect 0.62 0.60))
	(right-armpit-ext (make-vect 0.70 0.60))
	(right-underhand  (make-vect 1.00 0.30))
	(right-overhand   (make-vect 1.00 0.35))
	(right-overarmpit (make-vect 0.70 0.70))
	(right-shoulder   (make-vect 0.60 0.70))
	(right-middlehead (make-vect 0.65 0.85))
	(right-mouth      (make-vect 0.60 0.80))
	(right-tophead    (make-vect 0.60 1.00)))
    (segments->painter
     (list (make-segment left-innerleg    left-crotch)
	   (make-segment left-crotch      right-crotch)
	   (make-segment right-crotch   right-innerleg)
	   ;; left side
	   (make-segment left-outerleg    left-armpit)
	   (make-segment left-armpit      left-armpit-ext)
	   (make-segment left-armpit-ext  left-elbow)
	   (make-segment left-elbow       left-underhand)
	   (make-segment left-overhand    left-overelbow)
	   (make-segment left-overelbow   left-overarmpit)
	   (make-segment left-overarmpit  left-shoulder)
	   (make-segment left-shoulder    left-middlehead)
	   (make-segment left-middlehead  left-tophead)

	   ;; new segments
	   (make-segment left-mouth       middle-mouth)
	   (make-segment right-mouth      middle-mouth)

	   ;; right side
	   (make-segment right-outerleg   right-armpit)
	   (make-segment right-armpit     right-armpit-ext)
	   (make-segment right-armpit-ext right-underhand)
	   (make-segment right-overhand   right-overarmpit)
	   (make-segment right-overarmpit right-shoulder)
	   (make-segment right-shoulder   right-middlehead)
	   (make-segment right-middlehead right-tophead)))))

;; b) given right-split
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
	(beside painter (below smaller smaller)))))
;; removed the beside operation for up-split and right-split in the
;; second let expression
(define (corner-split-mod painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
	    (right (right-split painter (- n 1))))
	(let ((top-left up)
	      (bottom-right right)
	      (corner (corner-split painter (- n 1))))
	  (beside (below painter top-left)
		  (below bottom-right corner))))))

;; c) given square-of-four, flip-vert, corner-split
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
	    (right (right-split painter (- n 1))))
	(let ((top-left (beside up up))
	      (bottom-right (below right right))
	      (corner (corner-split painter (- n 1))))
	  (beside (below painter top-left)
		  (below bottom-right corner))))))
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
	  (bottom (beside (bl painter) (br painter))))
      (below bottom top))))
(define (flip-vert painter)
  (transform-painter painter
		     (make-vect 0.0 1.0)
		     (make-vect 1.0 1.0)
		     (make-vect 0.0 0.0)))
(define (identity painter) painter)
;; we create two square-of-fours so that we can flip horizontally the
;; big square leaving the other squares as in the original
;; square-limit.
(define (square-limit-mod painter n)
  (let ((corner (square-of-four (lambda (p) (up-split p (- n 1)))
				(lambda (p) (corner-split p (- n 1)))
				flip-horiz
				(lambda (p) (right-split p (- n 1))))))
    (let ((combine-corners (square-of-four flip-horiz identity
					   rotate180 flip-vert)))
      (combine-corners (corner painter)))))
