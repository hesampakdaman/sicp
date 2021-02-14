;; If the last element of the pair is the end-of-list marker, then
;; return the first element in that pair. Otherwise apply last-pair on
;; the rest of the list.
(define (last-pair items)
  (if (null? (cdr items))
      (list (car items))
      (last-pair (cdr items))))
