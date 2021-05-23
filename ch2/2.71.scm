;; The chosen frequencies have the property that whenever the two
;; least frequent symbols sets are merged, then its combined weight
;; will be less than all other symbol weight sets. We can prove this
;; using induction.
;;
;; The least frequent symbol has frequency 1 and will be merged with
;; the next-to-least frequent with frequency 2. After merging the
;; combined weight of 1 + 2 = 3. The combined weight of 3 is strictly
;; less than the least other frequent symbol which has a frequency of
;; 2^2 = 4.
;;
;; Assume the hypothesis to be true for k. Now we show that it still
;; holds for k+1.
;;
;; The combined weight of previously merged symbols j =< k is
;;
;;            1 + 2 + 2^2 + ... + 2^k = 2^{k+1} - 1 < 2^{k+1}
;;
;; where we have used the fact that the sum on the LHS is a geometric
;; series. If we therefore merge the symbol set with the symbol that
;; has frequency 2^{k+1} the combined weight  is therefore
;;
;;           1 + 2 + ... + 2^k + 2^{k+1} < 2 * 2^{k+1} = 2^{k+2}.
;;
;; All other remaining symbols have frequencies > 2^{k+2} which shows
;; that the combined weight of the two merged symbol sets is strictly
;; less than all other symbol frequencies.
;;
;; This means that when generating the Huffman tree, the symbols will
;; be merged one at the time. Hence the height of the tree will be
;; n-1, because there are n-1 symbols to that each is merged one
;; at-a-time. Therefore, the least frequent symbol needs n-1 bits to
;; be encoded whereas the most-frequent symbol only needs one bit.
