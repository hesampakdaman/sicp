;; Given
(define (make-mobile left right) (list left right))
(define (make-branch length structure)
  (list length structure))

;; a)
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cadr mobile))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cadr branch))

;; b)
(define (weight? structure) (number? structure))
(define (branch-weight branch)
  (let ((struct (branch-structure branch)))
    (if (weight? struct)
	struct
	(total-weight struct))))
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

;; c)
;; test data
;; balenced x, y, z
(define x (make-mobile (make-branch 2 6) (make-branch 3 4)))
(define y (make-mobile (make-branch 10 3) (make-branch 15 2)))
(define z (make-mobile (make-branch 3 x) (make-branch 6 y)))
(define (branch-torque branch)
  (* (branch-length branch) (branch-weight branch)))
(define (torque-eq? mobile)
  (= (branch-torque (left-branch mobile))
     (branch-torque (right-branch mobile))))
(define (balenced? mobile)
  (if (weight? mobile)
      #t
      (and (torque-eq? mobile)
	   (balenced? (branch-structure (left-branch mobile)))
	   (balenced? (branch-structure (right-branch mobile))))))
  
;; d)
;; For these new constuctors that return pairs
(define (make-mobile left right) (cons left right))
(define (make-branch length structure)
  (cons length structure))

;; we have to re-define two selectors. Before when dealing with lists,
;; any cdr operation returns the rest of the list. In this new case a
;; cdr will return the other pair. Therefore, we can replace cadr with
;; cdr to get
(define (right-branch mobile) (cdr mobile))
(define (branch-structure branch) (cdr branch))
