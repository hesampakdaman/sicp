;; given: accumulate, accumulate-n and dot-product
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      #nil
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector mat v)
  (map (lambda (row) (dot-product row v)) mat))
(define (transpose mat)
  (accumulate-n cons #nil mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))
