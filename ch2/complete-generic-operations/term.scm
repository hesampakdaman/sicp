(define (install-term-package)
  (define order car)
  (define coeff cadr)
  (define (equ-term? x y)
    (and (equ? (order x) (order y))
	 (equ? (coeff x) (coeff y))))
  (define (make-term order coeff) (list order coeff))
  (define (tag x) (attach-tag 'term x))
  (put 'make 'term (lambda (order coeff) (tag (make-term order coeff))))
  (put 'order '(term) order)
  (put 'coeff '(term) coeff)
  (put '=zero? '(term) (lambda (t) (= (coeff t) 0)))
  (put 'equ? '(term term) equ-term?)
  'done)

(define (make-term order coeff) ((get 'make 'term) order coeff))
(define (make-term-from-pair pair) (make-term (car pair) (cadr pair)))
(define (order term) (apply-generic 'order term))
(define (coeff term) (apply-generic 'coeff term))