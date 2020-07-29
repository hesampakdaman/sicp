;; We take (cont-frac n d k) from ex. 1.37 and adapt arguments n, d
;; specific the continous fraction of tan.

(define (cont-frac n d k)
  (define (frac-rec i)
    (if (= i k)
	(/ (n i) (d i))
	(/ (n i) (+ (d i) (frac-rec (+ i 1))))))
  (frac-rec 1))

(define (tan-cf x k)
  (define (Ni i)
    (if (> i 1)
	(- (* x x))
	x))
  (cont-frac Ni (lambda (i) (- (* 2 i) 1)) k))
