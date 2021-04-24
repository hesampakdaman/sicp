;; a)
;;
;; The first procedure places the entry node between the sub-tree of
;; the node's left branch converted as a list and the entry node's
;; right branch converted as a list. This means that every element to
;; the left of the entry node in the such a list will be smaller and
;; bigger to the right of it.
;;    Since this list is created recursevily obeying the rule above
;; for all entry nodes, we then can infer that such a list must be
;; monotonically increasing. Therefore the output of all trees in
;; in Figure 2.16 using the first procedure will be (1 3 5 7 9
;; 11).
;;
;;
;; The second procedure creates a result-list for the entry node's
;; left-branch. This result-list is created by using cons to tack the
;; entry node to the list that will be created of its right branch.
;; Hence the result-list for the left branch will have the property
;; that from left to right in the list its elements are monotonically
;; increasing. Since this property is never broken all trees in
;; Fig. 2.16 will be converted to the list (1 3 5 7 9 11).
;;
;;
;;
;; b) In both cases we will make use of the Master Theorem.
;;
;; Let T(n) be the time-complexity of (tree->list-1 tree) where n is
;; the number of nodes in the tree. The procedure will create two
;; sub-problems of each branch. In a balanced tree we expect each
;; branch have half of the remanding nodes. Lastly, the procedure will
;; combine both recursive calls using append procedure which has
;; time-complexity is O(n). Hence
;;
;; T(n) = 2T(n/2) + n = 2 [2T(n/4) + n/2] = 2 [2 [T(n/8) + n/4] + n/2]
;;      = 4T(n/8) + 2n = ... = 2^k T(n/2^k) + kn
;;
;; The base case T(1) = 1 since in that case the procedure simply
;; returns the empty list. Therefore,
;;
;; T(1) = 2^(log_2 n) T (n/2^log_2 n) + n*log_2 n =
;;      = 2^(log_2 n) + n * log_2 n
;;      = n + n * log_2 n,
;;
;; where we used the fact that T(n/2^log_2 n) = T(1) = 1.
;;
;; From here we see that T(n) = O(n + n*log_2 n) = O(n*log n).
;;
;;
;; Following the same reasoning for the next procedure we get the
;; recurrence relation
;;
;; T(n) = 2 * T(n/2) + 1,
;;
;; where the last term is due to the fact of using one cons with
;; constant time-complexity to combine elements rather than
;; append. Hence
;;
;; T(n) = 2^k T(n/2^k) + k => T(n) = n + log_2 n.
;;
;; Again we used the fact that T(1) = 1. Hence T(n) = O(n).
