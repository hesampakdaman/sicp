(load "2.67.scm")

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
	(adjoin-set (make-leaf (car pair)    ; symbol
			       (cadr pair))  ; frequency
		    (make-leaf-set (cdr pairs))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge huffman-trees)
  (if (= (length huffman-trees) 1)
      (car huffman-trees)
      (successive-merge
       (adjoin-set
	(make-code-tree (car huffman-trees) (cadr huffman-trees))
	(cddr huffman-trees)))))
