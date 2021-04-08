;; Quotation does not nest. After the first occurrence everything else
;; is seen as data. Here is what happens. The following expression
;; (car ''abracadabra) is equivalent to
;;
;; (car (quote (quote abracadabra)))
;;
;; Since we the inner quote is engulfed by the outer quote it will be
;; regarded as data object. Thus (quote (quote abracadabra)) is
;; evaluated to a list of symbols (quote abracadabra). Note here that
;; the word quote is not the actual operator but a symbol (same as if
;; we would have given the interpter 'quote). car extract the first
;; element in the list above, which is the symbol quote. Another way
;; to write this
;;
;; (car (quote (quote abracadabra))) => (car '(quote abracadabra)) => 'quote
