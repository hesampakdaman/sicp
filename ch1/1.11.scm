(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1))
	 (* 2 (f-rec (- n 2)))
	 (* 3 (f-rec (- n 3))))))

(define (f n)
  (f-iter 2 1 0 n))

(define (f-iter n_1 n_2 n_3 count)
  (if (= count 0)
      n_3
      (f-iter (+ n_1 (* 2 n_2) (* 3 n_3)) n_1 n_2 (- count 1))))
