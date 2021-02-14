;; Employ the "cons up" answer list while "cdring down" input
;; list. While there is an element, pop it off and place in the front
;; of the answer list. Return the answer list when no more items
;; exists.
(define (reverse items)
  (define (reverse-iter answer residual)
    (if (null? residual)
	answer
	(reverse-iter (cons (car residual) answer) (cdr residual))))
  (reverse-iter (list (car items)) (cdr items)))
