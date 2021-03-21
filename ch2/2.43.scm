;; If we change the order of the nested mappings, then at step k the
;; algorithmic steps will be the following:
;;
;; For each new-row we want to put a queen at column k we first solve
;; the queens puzzle with board-size k-1. Then we put in the queen at
;; first row at column k. Next we again solve the queens puzzle with
;; board-size k-1 so that we thereafter can put the new queen at the
;; second row of column k. Step k stops whenever column k is filled
;; with the new queens.
;;
;; This means that if the queen's puzzle takes time T, then
;; this algorithm will take row-size * T = k * T time.
