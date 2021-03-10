;; Consider the subset S {x0, x1, ...} and let T = {x1, x2, ...}, we
;; see that S = T u {x0}. All the subsets of S are exactly the same as
;; all the subsets of T with x0 added back to each of the subsets of
;; T, togehter with the the empty set and the singelton {x0}.
;;
;; subsets of S = {subsets of T with x0 added to them} u {x0} u {empty set}
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
	(append rest (map (lambda (x) (cons (car s) x)) rest)))))

;; using cons in the lambda avoids adding #nil every where.  Since the
;; variable rest will only once be (list #nil), the empty set is added
;; once to the subsets with the append procedure.
