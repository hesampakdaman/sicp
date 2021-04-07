(define (init-win win)
  (lambda (u v)
    (plot-line win
	       (xcor-vect u) (ycor-vect u)
	       (xcor-vect v) (ycor-vect v))))
(define f (make-frame (make-vect 0 0) (make-vect 1 0) (make-vect 0 1)))
(define draw-line (init-win (frame 0 1 0 1)))
