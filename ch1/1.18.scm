;; Note that this algorithm only works with non-negative integers. In
;; fast-mul-iter we consider alter the product a * b to 2a * b/2 if b
;; is even. This means that any additional multiplication, m, allows
;; us to calculate the product with a number that is twice as large as
;; the original input, b. Thus, b = 2^m => O(m) ~ log(b).
;;
;; The algorithm is correct. To see this, consider the case where b =
;; 2^k, for any k >= 0. fast-mul-iter will double a (and half b) k
;; times
;;
;; (fast-mul-iter a 2^k 0) -> ... -> (fast-mul-iter 2^k*a 1 0), at
;;
;; which point b is 1 where the next step is to add the first argument
;; to the last (c)
;;
;; (fast-mul-iter 2^k*a 1 0) -> (fast-mul-iter 2^k*a 0 2^k*a) -> 2^k*a,
;;
;; which is correct. Now consider the case where b is any other
;; number. Then we can write b = 2^k + j, for some k >= 0 and j >
;; 0. In this case the algorithm proceeds to add a to c j times
;;
;; (fast-mul-iter a 2^k+j 0) -> (fast-mul-iter a 2^k j*a).
;;
;; From here, we are in the previous case discussed earlier. Thus,
;;
;; (fast-mul-iter a 2^k j*a) -> ... -> (fast-mul-iter 2^k*a 1 j*a) ->
;;     (fast-mul-iter 2^k*a 1 j*a) -> (fast-mul-iter 2^k*a 0 j*a+2^k*a) ->
;;     j*a + 2^k*a = [2^k + j] * a.
;;
;; Note that 2^(k+1) - 2^k > j, meaning that b = 2^m + j < 2^(m+1) =>
;; O(m) ~ O(log(b)).

(define (double n)
  (* n 2))

(define (halve n)
  (/ n 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-mul-iter a b c)
  (cond ((= b 0) c)
	((even? b) (fast-mul-iter (double a) (halve b) c))
	(else (fast-mul-iter a (- b 1) (+ c a)))))

(define (fast-mul a b)
  (fast-mul-iter a b 0))
