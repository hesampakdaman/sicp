;; a) Recursively this procedure will take the element in the middle
;; and make two sub-trees of the rest of the elements. The elements to
;; the left of the chosen middle will become the left sub-tree and the
;; ones to the right will become the right sub-tree (this is why the
;; list has to be ordered). The middle element then becomes the entry.
;;
;; Each subcall to make the left branch takes the list as a whole but
;; only creates the subtree with half of the elements. Any remanding
;; elements that were not included in the tree will be returned back
;; and used to make the right subtree.
;;
;; If we apply the procedure to the list (1 3 5 7 9 11) we get
;;
;;                             5
;;                           /   \
;;                          1      9
;;                           \    / \
;;                            3  7  11
;;


;; b) We use the Master Theorem. Let T(n) be the time-complexity of
;; the procedure with n elements in the input list. Because the
;; procedure makes two recusrive call for every element in the list -
;; each with half the size of n - we get the following recurrence
;; relation
;;
;; T(n) = 2T(n/2) + 1,
;;
;; where the last term comes from using cons and make-tree procedures
;; which have constant time-complexity. As we saw in ex. 2.64 the
;; solution to this relation is T(n) = n + log_2(n) which gives us a
;; time-complexity of O(n).
