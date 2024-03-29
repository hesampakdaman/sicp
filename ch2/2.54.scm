(define (both-list? a b) (and (list? a) (list? b)))
(define (equal? a b)
  (cond ((or (null? a) (null? b)) (eq? a b))
	((both-list? (car a) (car b)) (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b))))
	(else (and (eq? (car a) (car b)) (equal? (cdr a) (cdr b))))))
