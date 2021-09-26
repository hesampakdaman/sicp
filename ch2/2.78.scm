;; We can use Scheme's primitive predicates for type checking
;; primitives. In doing so we do not need to attach any tag to
;; primitives as they are already built-in so to speak. We make
;; changes to attach-tag, type-tag and contents accordingly.

;; In attach-tag we do not attach any tag if the type-tag is
;; 'scheme-number. This allows us to represent data as Scheme numbers
;; in the scheme-numbers-package.
(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))

;; Since ordinary numbers are represented by primitives they are
;; un-tagged. We use Scheme's internal type system to determine when
;; this happens and return 'scheme-number, which is tag used by the
;; generic arithmetic package.
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
	((pair? datum) (car datum))
	(else (error "Bad tagged datum: TYPE-TAG" datum))))

;; The contents of ordinary numbers is the datum itself. Again we use
;; the primitive predicate number? to check when this is the case and
;; if so return the primitive as is.
(define (contents datum)
  (cond ((number? datum) datum)
	((pair? datum) (cdr datum))
	(else (error "Bad tagged datum: CONTENTS" datum))))
