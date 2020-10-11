;; Because 2 and 3 are prime, we can tell how many of any of them
;; there are in the non-negative number 2^a 3^b. After choosing which
;; prime factor to divide with, then iteratively we divide the number
;; until the new number is by the chosen prime.
;;
;; - For 2, we know to stop dividing whenever the new number is odd.
;; - For 3, we know to stop dividing whenever the new number has
;;   remainder > 0.
;;
;; We count how many times we can do this, this number will then
;; represent a or b depending which of the prime numbers we check
;; division for. For any pair (x y) we can associate it the number 2^x
;; * 3^y. Then we know that the prime 2 is associated with x and 3
;; with y. Hence, (car z) will count the numbers of 2 in the pair z
;; and (cdr z) will count the numbers of 3 in the pair z.

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))
(define (dispatch p i term filter)
  (if (filter p)
      i
      (dispatch (term p) (+ i 1) term filter)))
(define (car p)
  (dispatch p 0 (lambda (x) (/ x 2)) odd?))
(define (cdr p)
  (dispatch p 0 (lambda (x) (/ x 3)) (lambda (x) (> (remainder x 3) 0))))
