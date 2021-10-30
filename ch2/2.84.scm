;; First we define the relationship between the datatypes. Recall that
;; 'complex is at the top of the tower and has no super-type.
(define (super-type type)
  (cond ((eq? type 'integer) 'rational)
	((eq? type 'rational) 'real)
	((eq? type 'real) 'complex)
	(else '())))

;; Testing which of the types is higher in the hierarchy consists of
;; raising the second type successively until either of two cases
;; happen:
;;
;; 1) If the second type is raised such that eventually equals it
;; equals the first type, we say that the first type is "greater" than
;; the second type.
;;
;; 2) If the second type is raised so that in the end it equals the
;; empty list, then we know that there exists no type further in the
;; tower to raise it to. Hence the first type must be "lower" than the
;; second and we say that the second type is "greater" than the first.
(define (>type? type1 type2)
  (define (>=type? t1 t2)
    (cond ((null? t2) false)
	  ((eq? t1 t2) true)
	  (else (>=type? t1 (super-type t2)))))
  (if (eq? type1 type2)
      false
      (>=type? type1 (super-type type2))))

;; Here we iteratively raise the lower type until both arguments are
;; at the same level. If at that moment there exists a procedure then
;; we apply it, otherwise we return an error.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (and (= (length args) 2) (not (apply eq? type-tags))) ; ensures type1 != type2
	      (let ((type1 (car type-tags))
		    (type2 (cadr type-tags))
		    (a1 (car args))
		    (a2 (cadr args)))
		(if (>type? type1 type2) ; from above either type1 > type2 or type1 < type2
		    (apply-generic op a1 (raise a2))
		    (apply-generic op (raise a1) a2)))
	      (error "No method for these types" (list op type-tags)))))))
