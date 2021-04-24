;; By checking inequalites we know that we do not risk of prepending
;; duplicates to the union of the sets. Whenever equality occurs we
;; cdr down both sets and need only prepend the element in question
;; once.
;;
;; In each call to union-set we cdr down at least one of the sets and
;; stop whenever one of them is the empty list. This means that the
;; time-complexity is at most the sum of the sizes of the sets
;; involved. For sets with n and m elements in each respectively, the
;; time-complexity is linear: O(n + m) <= O(n), if m <= n.
(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else
	 (let ((x1 (car set1)) (x2 (car set2)))
	   (cond ((= x1 x2)
		  (cons x1 (union-set (cdr set1) (cdr set2))))
		 ((< x1 x2)
		  (cons x1 (union-set (cdr set1) set2)))
		 ((< x2 x1)
		  (cons x2 (union-set set1 (cdr set2)))))))))
