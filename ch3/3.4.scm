(define (make-account balance password)
  (define num-pwd-try 0)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (signal-incorrect-password)
    "Incorrect password")
  (define (call-the-cops)
    "Calling the cops")
  (define (handle-incorrect-password x)
    (set! num-pwd-try (+ num-pwd-try 1))
    (if (>= num-pwd-try 7)
	(call-the-cops)
	(signal-incorrect-password)))
  (define (handle-request request)
    (set! num-pwd-try 0)
    (cond ((eq? request 'withdraw) withdraw)
	  ((eq? request 'deposit) deposit)
	  (else (error "Unknown request: MAKE-ACCOUNT" request))))
  (define (wrong-password? pwd)
    (not (eq? pwd password)))
  (define (dispatch pwd m)
    (if (wrong-password? pwd)
	handle-incorrect-password
	(handle-request m)))
    dispatch)

(define acc (make-account 100 'secret-password))
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")
(string=? ((acc 'some-other-password 'deposit) 40) "Calling the cops")
(= ((acc 'secret-password 'deposit) 40) 140)
(string=? ((acc 'some-other-password 'deposit) 40) "Incorrect password")