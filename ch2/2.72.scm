;; TOD:
;; * Fix so memq 2 times until k
;; * 2 calls to memq
;;
;; The Huffman trees produced by choosing the relative frequencies as
;; in Ex. 2.71 are of the following form
;;
;;
;;                                   n *
;;                                    / \
;;                               n-1 *   *
;;                                  / \
;;                             n-2 *   *
;;                                /
;;                               .
;;                              .
;;                             .
;;                          2 *
;;                           / \
;;                        1 *   *
;;
;;
;; where the numbers represent the number of symbols associated with a
;; node that has two branches. Un-numbered nodes are associated with
;; exactly one symbol.
;;
;; In worst case (encode-symbol) will have to visit traverse down the
;; entire tree. A Huffman tree of the form above has for n symbols
;; a height of n.
;;
;; For each step in the procedure, the procedure has to search for the
;; symbol in the symbol-list associated with a node. The start node
;; are associated with all symbols. For a arbitrary node associated
;; with k symbols, its left-branch is only associated with one symbol
;; while the right-branch is associated with k-1 nodes. This is due to
;; the relative frequencies (see Ex 2.71).
;;
;; Taking the above into account, the total time-complexity of
;; (encode-symbol) to encode the symbol with relative frequency 2^k is
;;
;;              f(k) = sum[i=1 to k] 2*k = 2*k^2.
;;
;; The most frequent symbol is found at the top of the tree. It
;; therefore takes only two steps to reach it (initial call and one
;; additional recursive call).
;;
;;                            f(1) = 2.
;;
;; The least frequent symbol is found at the bottom of the tree. We
;; have to traverse down to the bottom and preform checks for the
;; symbol at each step. The total number of steps is at most
;;
;;                        f(n) = 2*n^2
