;; We've added new operators to our lookup table. The system now knows
;; how to dispatch '(complex) data that requires the operation
;; 'magnitude. Essentially, we have added a route for operations on
;; the complex-package that require implementations in
;; rectangular/polar packages.
;;
;; z is represented as a box-and-pointer in Fig. 2.24. As a list
;; structure z can be written as
;;
;; z = ('(complex) '(rectangular) 3 . 4)
;;
;; Now we use the substitution model with applicative order to follow
;; along what the interpreter does.

(magnitude z)                                                   ; generic interface
(apply-generic 'magnitude ('(complex) ('(rectangular) 3 . 4)))
((get 'magnitude '(complex)) ('(rectangular) 3 . 4))
(magnitude ('(rectangular) 3 . 4))                              ; complex arithmetic package
(apply-generic 'magnitude ('(rectangular) 3 . 4))
((get 'magnitude '(rectangular)) (3 . 4))
(magnitude (3 . 4))                                             ; rectangular package procedure
(sqrt (+ (square 3) (square 4)))

;; We see that apply-generic is invoked twice, once for each level of
;; types.
