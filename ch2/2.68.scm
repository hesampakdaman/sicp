(load "2.67.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
	      (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((not (memq symbol (symbols tree))) (error "symbol not in tree" symbol))
	((leaf? tree) '())
	((memq symbol (symbols (left-branch tree)))
	 (cons 0 (encode-symbol symbol (left-branch tree))))
	(else (cons 1 (encode-symbol symbol (right-branch tree))))))

;; evaluates to true
(equal? (encode '(a d a b b c a) sample-tree) sample-message)
