;; a) For the new generic exponentiation with types '(complex complex)
;; there isn't a procedure installed in the operator-and-type
;; table. apply-generic will in this case try coercion and it will
;; find a suitable transformation that Louise Reasoner has installed,
;; complex->complex.
;;
;; One of the arguments coerce to their own and be supplied as an
;; argument to a recursive call to apply-generic. This puts us back to
;; the same place as we started. We have effectively created an
;; infinite recursive loop.


;; b) It will work as is as long as we do not put coercion of same
;; data types in the coercion table (assuming the coercion table
;; returns false when there's no coercion with the types
;; supplied). But Louise Reasoner has shown that apply-generic can
;; turn into an infinite loop by allowing coercion to own type.


;; c) If the procedure cannot be find in the operator-and-type table,
;; we add a test to skip coercion for same type-tags.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (and (= (length args) 2) (not (apply eq? type-tags))) ; skips if both types are equal
	      (let ((type1 (car type-tags))
		    (type2 (cadr type-tags))
		    (a1 (car args))
		    (a2 (cadr args)))
		(let ((t1->t2 (get-coercion type1 type2))
		      (t2->t1 (get-coercion type2 type1)))
		  (cond (t1->t2
			 (apply-generic op (t1->t2 a1) a2))
			(t2->t1
			 (apply-generic op a1 (t2->t1 a2)))
			(else (error "No method for these types"
				     (list op type-tags))))))
	      (error "No method for these types"
		     (list op type-tags)))))))
