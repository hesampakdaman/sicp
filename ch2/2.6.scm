(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define zero (lambda (f) (lambda (x) x)))
;;
;; zero is defined by the identiy function, in effect applying f
;; naught times.

;; (add-1 zero)
;; (add-1 (lambda (g) (lambda (y) y)))
;; (lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) y)) f) x))))
;; (lambda (f) (lambda (x) (f ((lambda (y) y) x))))
;; (lambda (f) (lambda (x) (f x)))
;;
;; That is, one is defined as applying the function f once to its
;; argument x.
(define one (lambda (f) (lambda (x) (f x))))

;; (add-1 one)
;; (add-1 (lambda (g) (lambda (y) (g y))))
;; (lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) (g y))) f) x))))
;; (lambda (f) (lambda (x) (f ((lambda (y) (f y)) x))))
;; (lambda (f) (lambda (x) (f (f x))))
;;
;; We see that two is by applying function f twice in succession.
(define two (lambda (f) (lambda (x) (f (f x)))))

;; We define (add m n) by first evaluating numeral m. This means that
;; we first feed m the procedure f to get the function of the numeral
;; and then the argument x. In doing so, we can let it be the
;; inner-argument to numeral n. To achieve the latter we first need to
;; evaluate the numeral n by feeding it f, then we can access the
;; inner-argument.
(define (add m n)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))

;; We can test (add m n) with (add two one) and expect it to behave as
;; (add-1 two).
(define three (add two one))
