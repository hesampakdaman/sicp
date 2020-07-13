;; We have that (define (f g) (g 2)) and use the substitution model to
;; gain insight on how the interperter will evaluate (f f). We assume
;; applicative-order evaluation.
;;
;; (f f)
;;
;; Step 1. The operand f is evaluated first. The interperter evaluates
;; f to a function. Since f is a higher-order function accepting other
;; functions as arguments, it accepts f as input.
;;
;; (f 2)
;;
;; Step 2. f has been applied with its argument f to yield the
;; expression above. First the operand 2 is evaluated. Since 2 is
;; primitive it will evaluate to the numeral it represents. Next the
;; operator f is evaluated by subsituting its argument in its body.
;;
;; (2 2)
;;
;; Step 3. The resulting combination above treats the second "2" in
;; the list as an operand which evaluates to the numeral it
;; represents.  But the first "2" in the list is understood as an
;; operator, which the interperter tries applying to its
;; argument. This gives an error since 2 is not a operator.
