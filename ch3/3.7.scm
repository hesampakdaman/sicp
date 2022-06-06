(define (signal-incorrect-password x)
  "Incorrect password")

(define (wrong-password? input-password account-password)
  (not (eq? input-password account-password)))

(define (make-account balance account-password)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-pwd m)
    (cond ((wrong-password? input-pwd account-password) signal-incorrect-password)
	  ((eq? m 'withdraw) withdraw)
	  ((eq? m 'deposit) deposit)
	  (else (error "Unknown request: MAKE-ACCOUNT" m))))
  dispatch)

(define (make-joint account account-password joint-password)
  (lambda (input-pwd request)
    (if (wrong-password? input-pwd joint-password)
	signal-incorrect-password
	(account account-password request))))

(define peter-acc (make-account 100 'open-sesame))
(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

;; test linked account
(= ((peter-acc 'open-sesame 'withdraw) 40) 60)
(= ((paul-acc 'rosebud 'deposit) 40) 100)

;; test wrong password for Paul
(string=? ((paul-acc 'open-sesame 'withdraw) 100) "Incorrect password")

;; test insufficient funds for Peter
(= ((paul-acc 'rosebud 'withdraw) 100) 0)
(string=? ((peter-acc 'open-sesame 'withdraw) 1) "Insufficient funds")
