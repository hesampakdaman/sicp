(load "2.59.scm")

;; (element-of-set? x set) must check if x is in the set by traversing
;; through the entire set. We therefore do not change this procedure
;; at all and hence the time-complexity is still O(n) for a set of n
;; elements.

;; (intersection-set set1 set2) still needs to check if an element in
;; set1 exists in set2 and would have to do this for all elements in
;; set1. Again, we do not need to change this procedure and the
;; time-complexity is left unchanged O(n^2).

;; For adjoin-set we need not to check if x is already in the set
;; before adding it. Our new set-representation allows for element
;; duplication. Hence the time-complexity is constant O(1). The
;; original procedure had time-complexity O(n) for a set with n
;; elements.
(define adjoin-set cons)

;; When constructing the union of two sets there is no longer a need
;; to make sure each element is distinct. Therefore we can merely
;; append them. Since append traverses each element in set1 and uses
;; cons to tack them to set2, the time-complexity is O(n) if set1 has
;; n elements. Compared this with the orignal procedure that would
;; have had O(n^2) time-complexity for two equally sized sets with n
;; elements.
(define union-set append)

;; We see that two operations, adjoin-set and union-set, benefits from
;; this new set-representation. By allowing for duplication these
;; procedure do not need to worry about checking for duplication. But
;; this comes at the price of increased memory usage since sets with
;; duplication in general need more memory.

;; If the application we are building requires lots of set union
;; operations or to add elements to existing sets, then this
;; representation can be better suited than in the non-duplication
;; set-representation.
