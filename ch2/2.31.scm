(define (tree-map f tree)
  (map (lambda (sub-tree)
	 (if (pair? sub-tree)
	     (map-tree f sub-tree)
	     (f sub-tree)))
       tree))

(define (square x) (* x x))
(define (square-tree tree)
  (tree-map square tree))
(define (scale-tree tree factor)
  (tree-map (lambda (x) (* x factor)) tree))
