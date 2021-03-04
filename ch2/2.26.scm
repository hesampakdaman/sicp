;; (define x (list 1 2 3))
;; (define y (list 4 5 6))
;;
;; append function as we saw before merges two lists back-to-front
;;
;; (append x y) -> (1 2 3 4 5 6)
;;
;;
;; Here the first cons cell will be a list and the cdr cell will point
;; a list structure of nested cons:
;;
;; (cons x y) -> ((1 2 3) 4 5 6)
;;
;;
;; Both elements are put in a list and each of them are lists
;; themselves:
;;
;; (list x y) -> ((1 2 3) (4 5 6))
