;; We look at the local evolution of the procedure. The first three
;; iterative calls are
;;
;; (iter items nil)
;; (iter (cdr things) (cons (square (car things)) nil))
;; (iter (cdr (cdr things)) (cons (square (car (cdr things))) (cons (square (car things)) nil)))
;;
;; Here we see that each subsequent item while cdring down list things is put in
;; front of the answer list.
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons (square (car things))
		    answer))))
  (iter items nil))

;; The second procedure puts the transformed items in the correct
;; order, but the final result will not be a list. A list consists of
;; nested cons where each car is an item and each cdr is either
;; another cons or the null value to indicate termination. If we
;; follow the local evolution of the procedure we see that the
;; iterative calls does not construct a list.
;;
;; (iter items nil)
;; (iter (cdr things) (cons nil (square (car things))))
;; (iter (cdr (cdr things)) (cons
;;                                (cons nil (square (car things)))
;;                                (square (car (cdr things)))))
;;
;; This shows that the answer list first item is nil, which is
;; incorrect, and that the subsequent item is not a cons.
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons answer
		    (square (car things))))))
  (iter items nil))
