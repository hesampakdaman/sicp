;; Employ the "cons up" answer list while "cdring down" input
;; list. While there is an element, pop it off and place in the front
;; of the answer list. Return the answer list when no more items
;; exists.
(define (reverse items)
  (define (iter answer things)
    (if (null? things)
	answer
	(iter (cons (car things) answer) (cdr things))))
  (iter #nil items))
