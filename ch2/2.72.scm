;; The Huffman trees produced by choosing the relative frequencies as
;; in Ex. 2.71 are of the following form
;;
;;
;;                                   n *
;;                                    / \
;;                               n-1 *   * 1
;;                                  / \
;;                             n-2 *   * 1
;;                                /
;;                               .
;;                              .
;;                             .
;;                          2 *
;;                           / \
;;                        1 *   * 1
;;
;;
;; where the numbers represent the amount of symbols associated with a
;; node. A Huffman tree of the form above has for n symbols a height
;; of n.
;;
;; For each node the procedure has to search for the input-symbol in
;; its symbol-list. The start node is associated with all symbols. For
;; an arbitrary node associated with k symbols, its right-branch is
;; only associated with one symbol while the left-branch is associated
;; with k-1 nodes. This is due to the relative frequencies (see Ex
;; 2.71) and our implementation choice of putting nodes with smaller
;; weights on the left-branch (Ex. 2.69).
;;
;; We use memq procedure to search for a symbol. In general memq has a
;; linear time-complexity O(m) for a list of m elements.  To search
;; for a symbol with relative frequency 2^{j+1} at a node that is
;; associated with j+1 <= k symbols takes j steps. This is due to how
;; the symbols are collected at each node. The symbols-list at a node
;; is ordered ascending so that symbol with frequency 2^{j+1} is at
;; the j:th place in the symbol-list. memq is actually used twice at
;; each step, once for the root node and once again for the
;; left-branch.
;;
;; Taking the above into account, the total time-complexity of
;; (encode-symbol) to encode the k:th symbol (with relative frequency
;; 2^{k+1}) is
;;
;;                f(k) = sum[i=n-k to n] 2*k ~ k * (n-k+1)
;;
;;
;; The most frequent symbol is the n:th symbol with a frequency of 2^n-1
;;
;;                             f(n) = n
;;
;; The least frequent symbol is found at the bottom of the tree. We
;; have to traverse down to down the whole tree and preform checks for
;; the symbol at each step. The total number of steps is at most
;;
;;                            f(1) = n.
;;
;; BONUS: Had we implemented (make-code-tree) such that each
;; symbol-list associated with the resulting node is sorted descending
;; w.r.t. symbol frequency, then memq would take n-k+1 steps to search
;; for the k:th symbol in the input-list. Hence
;;
;;                h(k) = sum[i=n-k to n] 2*(n-k+1) ~ (n-k+1)^2,
;;
;; which leads to h(n) = 1 and h(1) = n^2. But this comes at the price
;; of increasing time-complexity for creating the entire Huffman-tree.
