(define p1 (make-polynomial 'x (make-term-list-from-terms (make-term 1 1) (make-term 0 1))))
(define p2 (make-polynomial 'x (make-term-list-from-terms (make-term 3 1) (make-term 0 -1))))
(define p3 (make-polynomial 'x (make-term-list-from-terms (make-term 1 1))))
(define p4 (make-polynomial 'x (make-term-list-from-terms (make-term 2 1) (make-term 0 -1))))
(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(define expected
  (make-rational
   (make-polynomial 'x (make-term-list-from-coeffs 1 2 3 1))
   (make-polynomial 'x (make-term-list-from-coeffs 1 1 0 -1 -1))))
(define actual (add rf1 rf2))

(equ? (add rf1 rf2) expected)
