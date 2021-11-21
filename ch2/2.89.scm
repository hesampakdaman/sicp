;; We need to change adjoin-term to prepend zeros so long as the order
;; of the term t to be adjoined is greather than the biggest order s
;; in the term-list: t > s + 1.
(define (adjoin-term term term-list)
  (cond ((=zero? (coeff term)) term-list)
	((> (order term) (+ (order (first-term term-list)) 1))
	 (adjoin-term term (cons 0 term-list)))
	(else (cons (coeff term) term-list))))

;; The terms in a dense list are just the coefficents, hence we must
;; make the term when we extract the first one.
(define (first-term term-list)
  (make-term (- (length term-list) 1) (car term-list)))
