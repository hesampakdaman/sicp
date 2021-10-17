;; generic procedures
(define (drop x)
  ;; If the super-type has a project op, then sub-type has a raise
  ;; op. Therefore we don't check for existence of raise for the
  ;; sub-type.
  (define (tagged-data?)
    (or (pair? x) (number? x)))
  (if (and (tagged-data?)
	   (get 'project (type-tag x))
	   (equ? (raise (project x)) x))
      (drop (project x))
      x))
(define (project x)
  ((get 'project (type-tag x)) (contents x)))

;; installed in complex-package
(define (project-complex z)
  ((get 'make 'real) (real-part z)))
(put 'project 'complex project-complex)

;; installed in real package
(define (project-real x)
  ((get 'make 'integer) (round x)))
(put 'project 'real project-real)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (drop (apply proc (map contents args))) ; usage of drop
	  (if (and (= (length args) 2) (not (apply eq? type-tags)))
	      (let ((type1 (car type-tags))
		    (type2 (cadr type-tags))
		    (a1 (car args))
		    (a2 (cadr args)))
		(if (>type? type1 type2)
		    (apply-generic op a1 (raise a2))
		    (apply-generic op (raise a1) a2)))
	      (error "No method for these types" (list op type-tags)))))))
