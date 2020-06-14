;; The expansion phase of the local evolution is
;;
;; (sin 12.5)
;; (p (sin 4.05))
;; (p (p (sin 1.35)))
;; (p (p (p (sin 0.45))))
;; (p (p (p (p (sin 0.15)))))
;; (p (p (p (p (p (sin 0.05))))))
;;
;; After this point the contraction phase will begin and no new calls
;; to (p x) is made. The number of total calls is therefore 5.
;;
;; For each new step we are allowed to make, we can calculate the sine
;; of an angle 3 times as large. This means that the problem size n is
;; related to the number of steps as n = 3^k. Thus, this algorithm
;; grows logarithmically with n: O(log n).
;;
;; We only need to store one number at each step in the local
;; evolution (constant). However, we need to track the number of calls
;; to (p x) we have made in each step during the expansion. For each
;; new step one additional call to (p x) is made, therefore the
;; space-complexity is the same as the time-complexity: O(log n).
