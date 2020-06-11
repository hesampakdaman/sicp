;; No this is not appropriate for our (fast-prime) function. Until now
;; we have assumed constant time for multiplying numbers. This is
;; acceptable seeing as we take remainders in (expmod), which means
;; that problem size for the multiplications will never exceede
;; 2n:bits where n is the prime we want to check.
;;
;; Our new (expmod) uses (fast-expt) which does not use remainders
;; between each calculation. This means that the numbers we multiply
;; grows rapidily (much bigger than our problem size n). No longer can
;; we expect contant time for the multiplications. In fact our
;; (fast-prime) function will become much slower due to this.
