;; Given
(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (/ (width i) (center i) 0.01))

;; Ex. 2.13
;;
;; All numbers are positive and percentages are small. It is therefore
;; reasonable to assert that an interval has no negative end-point
;; seeing as the tolarance is small.
;;
;; Let x be an interval with center c_1 and width w_1, wheras y is the
;; interval with center c_2 and width w_2.  Then for positive range
;; intervals x, y the multiplication is simply a new interval with
;; lower-bound (c_1 - w_1) * (c_2 - w_2) and upper-bound (c_1 + w_1) *
;; (c_2 + w_2) -- see Ex. 2.11.
;;
;; Hence, the new interval has the center
;;
;; [(c_1 + w_1) * (c_2 + w_2) + (c_1 - w_1) * (c_2 - w_2)] / 2
;;
;; which equals c_1 * c_2 + w_1 * w_2 ~ c_1 * c_2, since the
;; (tolrances and therefore widths) are small.
;;
;; The width is
;;
;; [(c_1 + w_1) * (c_2 + w_2) - (c_1 - w_1) * (c_2 - w_2)] / 2
;;
;; which equals c_1 * w_2 + c_2 * w_1. We can now calculate the
;; tolrance as
;;
;; 100*(width z) / (center z) ~ 100*(c_1*w_2 + c_2*w_1) / (c_1*c_2)
;;                            = 100*(w_1 / c_1 + w_2 / c_2)
;;                            = (percent x) + (percent y).
;;
;; With this in mind, we can define a procedure that works under the
;; assumption of small tolrances with no negative end-points.
(define (percent-small-approx x y)
  (+ (percent x) (percent y)))
