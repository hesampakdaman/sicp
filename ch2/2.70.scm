(load "2.68.scm")
(load "2.69.scm")

(define symbol-freq-pairs
  '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1)
    (JOB 2) (NA 16) (YIP 9)))

(define lyrics-message
  '(Get a job
    Sha na na na na na na na na
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip yip yip yip yip yip
    Sha boom))

(define lyrics-tree (generate-huffman-tree symbol-freq-pairs))

;; The number of bits used to encode lyrics-message is 84.
(length (encode lyrics-message lyrics-tree))

;; We want to distinguish between 8 symbols and hence need log_2 8 = 3
;; bits for each symbol for a fixed-length encoding. If we evaluate

(length lyrics-message)

;; we see that the message consists of 36 symbols. Therefore the total
;; number of bits in the message using a fixed-length code is

(* (length lyrics-message) 3)

;; which is 108 bits. This is roughly 30% increase compared to using
;; the Huffman-tree above.
