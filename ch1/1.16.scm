;; Note that ab^n is invariant. Since a = 1 in the beginning from the
;; hint, we know that ab^n = b^n from state to state. To respect the
;; invariant quantity we must update a anb b from state to state in a
;; specific way.
;;
;; We update a with the current value of b when current exponent j is
;; odd and decrement j by one. If the current exponent j is even, then
;; we update b by squaring it and dividing j by 2. We will show that
;; the quanity is invariant by induction in the steps k that the
;; algorithm takes.
;;
;; k = 1:
;; a_1 = 1, b_1 = b, n_1 = n: a_1 * b_1^n_1 = b^n.
;;
;; k + 1 where exponent from step k is even:
;;
;; a_{k+1} = a_k, b_{k+1} = b_k^2 and n_{k+1} = n_k / 2.
;;
;; The invariant quanitity is
;;
;; a_{k+1} * b_{k+1}^n_{k+1} = a_k * (b_k^2)^(n_k / 2) = a_k * b_k^{n_k} = b^n,
;;
;; where we used the induction step in the last equality.
;;
;; k + 1 where exponent from step k is odd:
;;
;; a_{k+1} = a_k * b_k, b_{k+1} = b_k and n_{k+1} = n_k - 1.
;;
;; We have that
;;
;; a_{k+1} * b_{k+1}^(n_{k+1}) = a_k * b_k * b_k^{n_k - 1} = a_k * b_k^{n_k} = b^n,
;;
;; where we again used the induction step in the last equality. This
;; completes the proof. The algorithm will end after j steps whenever
;; n_j = 0. Then the invariant quanitity is
;;
;; a_j * b_j^n_j = a_j.
;;
;; Since this quanitity is invariant and is equal to b^n, we know that
;; a_j must equal to b^n.
;;
;; The process evolves state to state as
;;
;; (fast-exp 2 3)
;; (fast-exp-iter 2 3 1)
;; (fast-exp-iter 2 2 2)
;; (fast-exp-iter 4 1 2)
;; (fast-exp-iter 4 0 8)
;; 8
;;
;; which is an iterative process that. For each new multiplication we
;; are allowed, we double the the exponent we can calculate. The
;; number of steps k is related to the exponent n as n = 2^k, which
;; gives us that k ~ O(log n). Thus, the algorithm is logarithmic.


(define (even? n) (= (remainder n 2) 0))

(define (square x) (* x x))

(define (fast-exp-iter b n a)
  (cond ((= n 0) a)
	((even? n) (fast-exp-iter (square b) (/ n 2) a))
	((fast-exp-iter b (- n 1) (* a b)))))

(define (fast-exp b n) (fast-exp-iter b n 1))

(define (test-fast-exp)
  (cond ((not (= (fast-exp 3 3) 27)) #f)
	((not (= (fast-exp 8 2) 64)) #f)
	((not (= (fast-exp 9 4) 6561)) #f)
	((not (= (fast-exp 2 10) 1024)) #f)
	((not (= (fast-exp 64 3) 262144)) #f)
	(else #t)))
