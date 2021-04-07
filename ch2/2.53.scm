(list 'a 'b 'c)				; returns a list of symbols: (a b c)
(list (list 'george))			; returns a list of list: ((george)) with one symbol
(cdr '((x1 x2) (y1 y2)))		; returns list of list ((y1 y2)) with symbols
(cadr '((x1 x2) (y1 y2)))		; returns a list (y1 y2) with symbols
(pair? (car '(a short list)))		; false since 'a is not a pair
(memq 'red '((red shoes) (blue socks)))	; false since 'red does not appear in the list
(memq 'red '(red shoes blue socks))	; list of symbols '(red shoes blue socks)
