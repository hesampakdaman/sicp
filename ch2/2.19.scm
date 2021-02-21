;; We want to prove that the order of coints does not matter.  Suppose
;; not, then there exists some ordering of the coins such that the
;; output of cc is incorrect for some input amount A. Let (c1, ...,
;; cn) be such an ordering and cj be the first coin cc encounters that
;; is in the wrong position.
;;
;; Assume at the step of which cc encounters cj the amount is B <=
;; A. cc will consider two subgroups, of which only one will use cj
;; for the calculation. In the first other subgroup cj is ignored in
;; further calculations with (except-first-denomination)
;; procedure. Hence, the error cc makes stems from the other subgroup
;; that uses cj in its calculation.
;;
;; Since we assume cc makes a mistake for this particular order of
;; coins, cj must be replace by a coin ck to get the correct
;; result. Here k>j since cj is the first coin cc encounters that is
;; the wrong position.  Therefore we know that we can make change out
;; of B with coin ck if we use it dk times. This means that B - ck*dk
;; >= 0. For this particular dk, there must exists some positive
;; integer dj such that
;;
;;                     B = ck*dk + ... + cj*dj + ...
;;
;; since we know that cj was to be used (it should have been replaced
;; with ck to get correct ordering). For if no such dj exists, the
;; coin cj is not to be used and is then safely ignored in the other
;; subgroup for which cc can calculate the answer correctly and thus
;; there is no fault with the ordering of the coin cj. Thus we know
;; that B >= cj*dj.
;;
;; But cc already calculates this difference with the recursive calls
;; (cc (- amount cj)). This means that we get dj without replacing cj
;; with ck. But then cj could not have been the first coin that is in
;; the wrong order as we assumed. Hence no such first coin exists and
;; we get a contradiction.

(define (except-first-denomination coin-values)
  (cdr coin-values))
(define (first-denomination coin-values)
  (car coin-values))
(define (no-more? coin-values)
  (null? coin-values))
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? coin-values)) 0)
	(else
	 (+ (cc amount
		(except-first-denomination
		 coin-values))
	    (cc (- amount
		   (first-denomination
		    coin-values))
		coin-values)))))
