;; (fold-right / 1 (list 1 2 3)) => (/ 1 (/ 2 (/ 3 1))) => 3/2
;;
;; (fold-left / 1 (list 1 2 3)) => (/ (/ (/ 1 1) 2) 3) => 1/6
;;
;; (fold-right list '() (list 1 2 3)) => (list 1 (list 2 (list 3 '()))) => (1 (2 (3 ())))
;;
;; (fold-left list '() (list 1 2 3)) => (list (list (list '() 1) 2) 3) => (((() 1) 2) 3)
;;
;; If op is commutative, then fold-right and fold-left yields same
;; result. This follows straight from the definition of commutative
;; operators, since chaning the order in which we do the computation
;; does not alter the result.
;;
;; Two examples using +, * which are commutative
;; (fold-right * 1 (list 1 2 3)) = (fold-left * 1 (list 1 2 3))
;; (fold-right + 0 (list 1 2 3)) = (fold-left + 0 (list 1 2 3))
