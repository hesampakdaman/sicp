(define (split left right)
  (define (recursive-split painter n)
    (if (= 0)
	painter
	(let ((smaller (recursive-split painter (- n 1))))
	  (left painter (right smaller smaller)))))
  recursive-split)
(define right-split (split beside below))
(define up-split (split below beside))
