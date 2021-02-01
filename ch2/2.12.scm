;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;; Ex. 2.12
(define (make-center-percent c tol)
  (make-center-width c (* 0.01 c tol)))

(define (percent i)
  (/ (width i) (center i) 0.01))
