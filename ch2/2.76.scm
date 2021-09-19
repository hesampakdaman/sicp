;; Dispatch on type
;;
;; Adding a new operation requires us to define it for each data
;; representation in the system.
;;
;; Adding a new data representation will have us change all generic
;; operators in the system by adding a new clause in their
;; dispatch. Each new clause includes an appropriate procedure for the
;; new data.


;; Data-directed dispatch
;;
;; To install a new operation we'll need to add it to each package in
;; the system and then put it in the operator-and-type lookup
;; table. In effect we add a new row to our table.
;;
;; Installing a new data representation will have us writing an entire
;; new package and for every generic operator implement an appropriate
;; procedure. These are all then put into the operator-and-type
;; table. That is, we create a new column in the table.


;; Message parsing
;;
;; If we want to add a new operation we have to change the internal
;; dispatch procedure of each data type we have in the system.
;;
;; Creating a new data type equates to creating a new procedure for it
;; and implement the internal dispatch.


;; Comparison
;;
;; Suppose we foresee that we need to add more operators than data
;; representations. Then explicit dispatch is preferred.  It's easier
;; to add a new operation by writing a new procedure than by changing
;; all internal dispatch in every data representation we have (as is
;; the case with message parsing). If we imagine we have hundreds of
;; data representations, then its extra cumbersome to add a new
;; operation with message parsing. Explicit dispatch is also easier
;; than creating an entire new package, as is done in data-directed
;; dispatch, and accessing the new operator through a lookup table
;; instead of directly. Hence, explicit dispatch is preferred in this
;; case.
;;
;;
;; Now assume we want to add new data representations more often. In
;; the case of message parsing we simply create the constructor with
;; an internal dispatch. Nothing more is needed. This is preferred,
;; because for explicit dispatch we have to edit all generic
;; operations which is very cumbersome if we have many of them. Again,
;; this would be easier than creating a new column in the
;; operator-type table with the same reason given in the paragraph
;; above.
