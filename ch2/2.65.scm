;; We create union-set-tree procedure using (list->tree elements) from
;; ex. 2.64 and (tree->list-2 tree) from ex. 2.63. Finally,
;; (union-set elements) is from ex. 2.62.

(define (union-set-tree set1 set2)
  (list->tree
   (union-set (tree->list-2 set1)
	      (tree->list-2 set2))))

;; For a list of n elements all of the above procedures have O(k)
;; time-complexity. Above we have two separate calls to tree->list-2
;; and one call to union-set and finally one call to list->tree. These
;; calls do not entwine and therefore total time-complexity is a sum
;; of all time-complexities from the calls. If both set1 and set2 have
;; n elements each, then the time-complexity T(n) of union-set-tree is
;;
;;          T(n) = O(n + n)    +   O(n + n)   +     O(n) + O(n)
;;                 list->tree      union-set    2 calls tree->list-2
;;
;;                =  2*O(2n) + 2*O(n) = O(n).


;; Using the same line of reasoning we can define
;; (intersection-set-tree set1 set2) as
(define (intersection-set-tree set1 set2)
  (list->tree
   (intersection-set (tree->list-2 set1)
		     (tree->list-2 set2))))

;; where intersection-set is the procedure prestented to us in the
;; section Sets as ordered list p. 209. Again, all of the procedures
;; above are O(k) and do not entwine giving us an O(n) implementation
;; if both sets have n elements.
