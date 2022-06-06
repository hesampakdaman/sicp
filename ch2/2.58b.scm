(load "2.58a.scm")

(define (sum? exp) (pair? (memq '+ exp)))
(define (product? x) (and (not (sum? x)) (pair? x) (eq? (cadr x) '*)))
(define (singleton? x)
  (and (pair? x) (= (length x) 1)))
(define (get-singleton-or-list x)
  (if (singleton? x) (car x) x))
(define (addend exp)
  (define (make-addend x)
    (if (eq? '+ (car x))
	'()
	(cons (car x) (make-addend (cdr x)))))
  (get-singleton-or-list (make-addend exp)))
(define (augend exp)
  (cond ((eq? '+ (car exp))
	 (get-singleton-or-list (cdr exp)))
	(else (augend (cdr exp)))))