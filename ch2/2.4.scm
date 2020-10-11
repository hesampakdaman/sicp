(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))

;; We use the substitution model to verify that the conditions are
;; fulfilled.
;;
;; (car (cons x y))                              ;; Eval arguemnt
;; (car (lambda (m) (m x y)))                    ;; Expand car
;; ((lambda (m) (m x y)) (lambda (p q) p))       ;; Replace argument with m symbol
;; ((lambda (p q) p) x y)                        ;; Apply lambda
;; x
;;
;; We do the same to verify (cdr z) procedure.
;;
;; (cdr (cons x y))                              ;; Eval arguemnt
;; (cdr (lambda (m) (m x y)))                    ;; Expand car
;; ((lambda (m) (m x y)) (lambda (p q) q))       ;; Replace argument with m symbol
;; ((lambda (p q) q) x y)                        ;; Apply lambda
;; y
