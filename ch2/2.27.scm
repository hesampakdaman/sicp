;; Modification made: if the element itself is a pair, then use
;; reverse indepedently before adding it to the answer list.
(define (deep-reverse items)
  (define (iter answer things)
    (if (null? things)
	answer
	(let ((head (car things))
	      (next (cdr things)))
	  (if (pair? head)
	      (iter (cons (deep-reverse head) answer) next)
	      (iter (cons head answer) next)))))
  (iter #nil items))
