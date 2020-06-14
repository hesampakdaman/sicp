;; In applicative the operands are evaluated first before application
;; of the operand. Before (expmod) was called once in each step. In
;; this case however, this means that in each step we roughly make two
;; new calls to (expmod). Thus, the number of calls to (expmod) grows
;; exponentially with the number of steps k, i.e. 2^k.
;;
;; From before we know the number of steps is related to the problem
;; size n as k = log_2 n. Therefore, the number of calls to (expmod)
;; must be related to n as 2^k = 2^{log_2 n} = n. So the total number
;; of calls to (expmod) is now O(n) due to the additional two calls to
;; (expmod) in every step.
