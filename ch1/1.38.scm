;; We take (cont-frac n d k) from ex. 1.37.

(define (cont-frac n d k)
  (define (frac-rec i)
    (if (= i k)
	(/ (n i) (d i))
	(/ (n i) (+ (d i) (frac-rec (+ i 1))))))
  (frac-rec 1))

;; First note that i > 0. We need to define procedures n, d for the
;; Euler formula.  N_i = 1 for all i > 0 and D_i is the sequence 1, 2,
;; 1, 1, 4, 1, 1, 6, 1, 1, 8, ... We see that every number in sequence
;; D_i with i such that i mod_3 = 2 is even. All other indices are 1.
;;
;; Next, consider these two sequences
;;
;;
;; k:   1, 2, 3, 4,  5,  6,  7, ...
;; --------------------------------
;; 2k:  2, 4, 6, 8, 10, 12, 14, ...
;;
;;
;; i:   1, 2, 3, 4, 5, 6, 7, 8, ...
;; --------------------------------
;; D_i: 1, 2, 1, 1, 4, 1, 1, 6, ...
;;
;;
;; The numbers come in blocks of
;;
;;               ... | 1 even 1 | 1 even 1 | 1 even 1 | ...
;;
;; We want the number of such blocks in our sequence when D_i is
;; even. Index i tells us how many numbers we have in sequence D_i.
;; To get the number of previous complete blocks, simply remove D_i
;; and D_{i-1} from the current incomplete block and divide by 3
;;
;;                        (i - 2) / 3.
;;
;; In each such block there are two 1s we have wasted our index i on
;; compared to k, together with the additional 1 in the incomplete
;; block | 1 even |. Hence the total number of 1s so far is 2 * (i -
;; 2) / 3 + 1. We remove them from i to get which k our index i
;; corresponds to:
;;
;;          k = i - [2 * (i - 2) / 3 + 1] = (i + 1) / 3.
;;
;; Hence whenever i mod 3 = 2, then D_i is even and we get the correct
;; number by calculating 2 * k = 2 * (i + 1) / 3.


(define (Di i)
  (if (= (remainder i 3) 2)
      (/ (* 2 (+ i 1)) 3)
      1))

; The result below is 2.7182817182817183, which is correct to the 6th
;; decimal.
(+ (cont-frac-iter (lambda (i) 1.0) Di 10) 2)
