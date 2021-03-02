;; If head of the tree is another tree, then append the fringe of it
;; with the fringe of the rest of the tree. Otherwise, cons the head
;; with the fringe of the remaining tree.
(define (fringe tree)
  (define (car-tree? tree) (pair? (car tree)))
  (cond ((null? tree) #nil)
	((car-tree? tree) (append (fringe (car tree)) (fringe (cdr tree))))
	(else (cons (car tree) (fringe (cdr tree))))))
