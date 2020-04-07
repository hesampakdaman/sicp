;; Note that this algorithm only works with non-negative integers. In
;; fast-mul we take advantage of the fact that
;;
;; a * b = 2 * (a * (b / 2)) if b is even,
;; a * b = a + (b - 1) otherwise.
;;
;; For every additional multiplication, m, allowed we can
;; calculate numbers twice as large as the original input. Thus,
;;
;; b = 2^m => O(m) ~ O(log b), which is logarithmic in b.

(define (double n)
  (* n 2))

(define (halve n)
  (/ n 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-mul a b)
  (cond ((= b 0) 0)
	((even? b) (double (fast-mul a (halve b))))
	(else (+ a (fast-mul a (- b 1))))))
