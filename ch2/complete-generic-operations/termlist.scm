(load "term.scm")

(install-term-package)

;; We implement two representations for term-list, dense and sparse.
(define (install-dense-term-list)
  (define (adjoin-term term term-list)
    (cond ((> (order term) (+ (order (first-term term-list)) 1))
	   (adjoin-term term (cons 0 term-list)))
	  (else (cons (coeff term) term-list))))
  (define (tag term-list)
    (if (empty-termlist? term-list)
	term-list
	(attach-tag 'dense term-list)))
  (define (first-term term-list)
    (make-term (- (length term-list) 1) (car term-list)))
  (define (rest-terms term-list)
    (cond ((empty-termlist? term-list) (the-empty-termlist))
	  ((empty-termlist? (cdr term-list)) (the-empty-termlist))
	  ((=zero? (first-term (cdr term-list))) (rest-terms (cdr term-list)))
	  (else (cdr term-list))))
  (put 'adjoin-term '(term dense) (lambda (t L) (tag (adjoin-term (make-term-from-pair t) L))))
  (put 'first-term '(dense) first-term)
  (put 'rest-terms '(dense) (lambda (L) (tag (rest-terms L))))
  (put 'make 'dense (lambda (coeffs) (tag coeffs)))
  'done)

(define (install-sparse-term-list)
  (define (adjoin-term term term-list)
	(cons term term-list))
  (define first-term car)
  (define rest-terms cdr)
  (define (tag term-list)
    (if (empty-termlist? term-list)
	term-list
	(attach-tag 'sparse term-list)))
  (put 'adjoin-term '(term sparse) (lambda (t L) (tag (adjoin-term (make-term-from-pair t) L))))
  (put 'first-term '(sparse) first-term)
  (put 'rest-terms '(sparse) (lambda (L) (tag (rest-terms L))))
  (put 'make 'sparse (lambda (terms) (tag terms)))
  'done)

(define (make-sparse-termlist . terms)
  ((get 'make 'sparse) terms))
(define (make-dense-termlist . coeffs)
  ((get 'make 'dense) coeffs))
(define (adjoin-term term term-list)
  (cond ((=zero? term) term-list)
	((empty-termlist? term-list) (make-sparse-termlist term))
	(else (apply-generic 'adjoin-term term term-list))))
(define (first-term term-list)
  (apply-generic 'first-term term-list))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
(define (empty-termlist? term-list)
  (null? term-list))
(define (the-empty-termlist) '())

(define (install-term-list-package)
  (install-sparse-term-list)
  (install-dense-term-list)
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
	  ((empty-termlist? L2) L1)
	  (else
	   (let ((t1 (first-term L1))
		 (t2 (first-term L2)))
	     (cond ((> (order t1) (order t2))
		    (adjoin-term
		     t1 (add-terms (rest-terms L1) L2)))
		   ((< (order t1) (order t2))
		    (adjoin-term
		     t2 (add-terms L1 (rest-terms L2))))
		   (else
		    (adjoin-term
		     (make-term (order t1)
				(add (coeff t1) (coeff t2)))
		     (add-terms (rest-terms L1)
				(rest-terms L2)))))))))
  (define (sub-terms L1 L2)
    (add-terms L1 (negate-termlist L2)))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
	(the-empty-termlist)
	(add-terms (mul-term-by-all-terms (first-term L1) L2)
		   (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
	(the-empty-termlist)
	(let ((t2 (first-term L)))
	  (adjoin-term
	   (make-term (add (order t1) (order t2))
		      (mul (coeff t1) (coeff t2)))
	   (mul-term-by-all-terms t1 (rest-terms L))))))
  (define (equ-terms? L1 L2)
    (cond ((and (empty-termlist? L1) (empty-termlist? L2)) true)
	  ((not (equ? (first-term L1) (first-term L2))) false)
	  (else (equ-terms? (rest-terms L1) (rest-terms L2)))))
  (define (mul-number-by-all-terms n L)
    (mul-term-by-all-terms (make-term 0 n) L))
  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
	(list (the-empty-termlist) (the-empty-termlist))
	(let ((t1 (first-term L1))
	      (t2 (first-term L2)))
	  (if (> (order t2) (order t1))
	      (list (the-empty-termlist) L1)
	      (let* ((new-c (div (coeff t1) (coeff t2)))
		     (new-o (- (order t1) (order t2)))
		     (new-t (make-term new-o new-c)))
		(let ((rest-of-result (div-terms
				       (sub-terms L1 (mul-term-by-all-terms new-t L2))
				       L2)))
		  (list (adjoin-term new-t (car rest-of-result)) (cadr rest-of-result))))))))
  (define (reduce-terms L1 L2)
    (let* ((greatest-div (gcd-terms L1 L2))
	   (factor (integerizing-factor-gcd greatest-div L1 L2))
	   (reduced-L1 (quotient-terms (mul-number-by-all-terms factor L1) greatest-div))
	   (reduced-L2 (quotient-terms (mul-number-by-all-terms factor L2) greatest-div)))
      (list reduced-L1 reduced-L2)))
  (define (integerizing-factor-gcd greatest-div L1 L2)
    (if (>= (order (first-term L1)) (order (first-term L2)))
	(integerizing-factor L1 greatest-div)
	(integerizing-factor L2 greatest-div)))
  (define (gcd-terms a b)
    (if (empty-termlist? b)
	(remove-common-coeff-factors a)
	(gcd-terms b (pseudoremainder-terms a b))))
  (define (gcd-coeffs L)
    (if (empty-termlist? (rest-terms L))
	(coeff (first-term L))
	(gcd (coeff (first-term L)) (gcd-coeffs (rest-terms L)))))
  (define (remove-common-coeff-factors L)
    (mul-number-by-all-terms (div 1 (gcd-coeffs L)) L))
  (define (remainder-terms L1 L2)
    (cadr (div-terms L1 L2)))
  (define (quotient-terms L1 L2)
    (car (div-terms L1 L2)))
  (define (pseudoremainder-terms L1 L2)
    (cadr (div-terms
	   (mul-number-by-all-terms (integerizing-factor L1 L2) L1)
	   L2)))
  (define (integerizing-factor L1 L2)
    (let ((O1 (order (first-term L1)))
	  (O2 (order (first-term L2)))
	  (c (coeff (first-term L2))))
      (expt c (sub (add 1 O1) O2))))
  (define (negate-termlist L)
    (mul-number-by-all-terms -1 L))
  (define (=zero-term-list? L)
    (cond ((empty-termlist? L) true)
	  ((not (=zero? (first-term L))) false)
	  (else (=zero-term-list? (rest-terms L)))))
  (define (tag x)
    (if (empty-termlist? x)
	(the-empty-termlist)
	(attach-tag 'termlist x)))
  (put 'mul '(termlist termlist) (lambda (L1 L2) (tag (mul-terms L1 L2))))
  (put 'mul '(term termlist) (lambda (t L) (tag (mul-term-by-all-terms (make-term-from-pair t) L))))
  (put 'div '(termlist termlist)
       (lambda (L1 L2) (let ((result (div-terms L1 L2)))
		    (list (tag (car result)) (tag (cadr result))))))
  (put 'greatest-common-divisor '(termlist termlist) (lambda (L1 L2) (tag (gcd-terms L1 L2))))
  (put 'reduce '(termlist termlist)
       (lambda (L1 L2) (let ((reduced (reduce-terms L1 L2)))
		    (list (tag (car reduced)) (tag (cadr reduced))))))
  (put 'add '(termlist termlist) (lambda (L1 L2) (tag (add-terms L1 L2))))
  (put 'sub '(termlist termlist) (lambda (L1 L2) (tag (sub-terms L1 L2))))
  (put 'negate '(termlist) (lambda (L) (tag (negate-termlist L))))
  (put '=zero? '(termlist) =zero-term-list?)
  (put 'equ? '(termlist termlist) equ-terms?)
  'done)

;; define constructors for term-list
(define (make-term-list-from-coeffs . coeffs)
  (attach-tag 'termlist ((get 'make 'dense) coeffs)))
(define (make-term-list-from-terms . terms)
  (attach-tag 'termlist ((get 'make 'sparse) terms)))
