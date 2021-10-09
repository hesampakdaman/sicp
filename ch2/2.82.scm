;; The lookup procedure get-coercion will return false if no coercion
;; between two types are found. If we try to apply this procedure from
;; one type to all others, then at least once get-coercion will return
;; false.
;;
;; We can use the fact above to try and coerce all types into one type
;; and if that fails try with another type. We make sure that the type
;; we try to coerce all others to is excluded, as to avoid coercions
;; between same types.
;;
;; Our solution is implemented in try-coercion.
(define (try-coercion tags-to-try args)
  (define (coercion-successful?)
    (not (memq '() coercions)))
  (define (no-tags-to-try?)
    (null? tags-to-try))
  (define (iterative-coerce to-type data)
    (if (null? data)
	'()
	(let* ((item (car data))
	       (item-type (type-tag item))
	       (item->to-type (get-coercion item-type to-type)))
	  (cond ((eq? item-type to-type)
		 (cons item (iterative-coerce to-type (cdr data))))
		((null? item->to-type) '())
		(else (cons
		       (item->to-type item)
		       (iterative-coerce to-type (cdr data))))))))
  (if (no-tags-to-try?)
      '()
      (let ((coercions (iterative-coerce (car tags-to-try) args)))
	(if (coercion-successful?)
	    coercions
	    (try-coercion (cdr tags-to-try) args)))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (let ((coerced-data (try-coercion type-tags args)))
	    (if (not (null? coerced-data))
		(apply-generic op coerced-data)
		(error "No method for these types" (list op type-tags)))))
      (error "No method for these types"
	     (list op type-tags)))))


;; Let's suppose we have three data types integer, rational and real
;; numbers. In the rational package we've installed a special procedure
;; called integer-denom-mult
(define (integer-denom-mult n r)
  (make-rat (numer r) (* n (denom r))))

;; This procedure is installed in the operator-type table
(put 'special-multiply '(scheme-number rational) integer-denom-mult)

;; Now suppose we do the following: (apply-generic 'special-multiply n
;; z) where n is a scheme-number and z is complex number 5 +
;; 0i. Clearly, z can be expressed as the rational 5/1.
;;
;; However, we do not have any special-multiply defined for types
;; '(scheme-number complex), hence apply-generic will try
;; coercion. This coercion stratagem only tries coercion to same
;; types, both '(scheme-number scheme-number) and '(complex complex)
;; are tried. Unfortunately both do not have any suitable
;; 'special-multiply operation defined so we get an Error.
;;
;; From the discussion above we note that the suitable mixed-operation
;; integer-denom-mult was not tried. Since we only coerce all data
;; types to one type, the mixed and suitable combination '(integer
;; rational) was never tried, even though z could have been expressed
;; as a rational.
