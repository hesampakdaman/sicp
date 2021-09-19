;; a) We need to structure each divison's file with a type unique to
;; it. As an example, let's say we have a divison name "south
;; divison". Then we can attach a tag 'south-divison to its
;; record-file.
(define south-division 'south-divison south-division-file)

;; With the structure above we can write a generic get-record
;; procedure. We assume a lookup table with operator and divison-tags
;; as keys. Given this structure we can simply consult the lookup
;; table for the right procedure to apply.
(define (get-record employee division)
  ((get 'get-record (type-tag division)) employee (contents division)))

;; b) Each division must attach its tag to any record it returns. This
;; structure allows us to use the lookup table with the returned tag
;; in order to know which internal get-salary procedure to apply to
;; the returned record.
(define (get-salary employee division)
  (apply-generic 'get-salary (get-record employee division)))

;; c) Recursively loop each divison-file and apply the generic
;; get-record operator. Here we've assumed that each internal
;; get-record operator returns an empty list if the employee is not
;; associated with that divison.
(define (find-employee-record employee divisions)
  (cond ((null? divisions) '())
	((not (null? (get-record employee (car divisions))))
	 (get-record employee (car divisions)))
	(else (find-employee-record employee (cdr divisions)))))

;; d) First we must agree on a unique tag for the new divison and
;; create the tag-typed data. Next we install all internal procedures
;; for get-record, get-salary etc. under the new tag in the lookup
;; table. We also have to make sure to attach the divison-tag to any
;; records returned. For a new divison named "divison north" we can do
;; like so
(define north-division (attach-tag 'north-divison north-divison-file))
(put 'get-record 'north-divison internal-record-procedure)
(put 'get-salary 'north-divison internal-salary-procedure)
