;; The algorithm below would stop and return the new set as soon as x
;; strictly less than any of the elements in the ordered list. Since
;; the list is ordered, we know now that x cannot be in the set as
;; soon as we encounter an element in the set that is strictly larger
;; than x. Since we do not allow duplication we must stop and return
;; whenever x equals to an element in the set.
;;
;; In worst case x is greater than every element in the set and we
;; therefore traverse the whole ordered list. If we are lucky x is
;; smaller than most elements in the st. On average, then, we get
;; time-complexity O(n/2) for a set with n elements.
(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((= x (car set)) set)
	((< x (car set)) (cons x set))
	(else (cons (car set) (adjoin-set x (cdr set))))))
