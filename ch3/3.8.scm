(define state 0)

;; f is a function that for two calls will reset its state to the
;; initial value. A call to f will always have the side-effect of
;; changing the state variable, which takes values either 0 or 1. The
;; state variable will alternate between calls, beginning from 0.
;; * (f 0) will change the state and then output 0 and,
;; * (f 1) will change the state and output its new value.
(define (f n)
  (set! state (if (= state 0) 1 0))
  (if (= n 0)
      0
      state))

(+ (f 0) (f 1))

;; If argument evaluation is left-to-right we get
;;
;; (+ (f 0) (f 1))     state=0
;; (+ 0 (f 1))         state=1
;; (+ 0 0)             state=0
;; 0

;; and right-to-left yields
;;
;; (+ (f 0) (f 1))     state=0
;; (+ (f 0) 1)         state=1
;; (+ 0 1)             state=0
;; 1

;; Both above have equal state transitions and the only difference
;; would be order of evaluation. Another fun expression to try out is
;; the following
(define divisor 0)
(define (set-and-return-divisor new-value)
  (set! divisor new-value)
  new-value)
(+ (set-and-return-divisor 1) (/ 1 divisor))

;; right-to-left evaluation would give us error
;;
;; (+ (set-and-return-divisor 1) (/ 1 divisor))      divisor=0
;; (+ (set-and-return-divisor 1) (/ 1 0))            divisor=0
;; Division by zero signalled by /.

;; while left-to-right would work
;;
;; (+ (set-and-return-divisor 1) (/ 1 divisor))      divisor=0
;; (+ 1 (/ 1 divisor))			             divisor=1
;; (+ 1 (/ 1 1))			             divisor=1
;; (+ 1 1)				             divisor=1
;; 2
