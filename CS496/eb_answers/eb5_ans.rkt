#lang racket
(require compatibility/mlist)

;;;;;;;;EXERCISE 1;;;;;;;
;(define x 2)

;;;;;;;;EXERCISE 2;;;;;;;
(define x 2)
(define y x)

;;;;;;;;EXERCISE 3;;;;;;;
(define u '(1 2))
(define v u)

;;;;;;;;EXERCISE 4;;;;;;;
(define counter
  (let ((local-state 0))
    (lambda ()
      (let ((dummy (set! local-state (+ local-state 1))))
        local-state))))

;;;;;;;;EXERCISE 5;;;;;;;
(define stack
  (let ((stk '()))
    (lambda (message)
      (case message
        ((empty?) (lambda ()
                    (null? stk)))
        ((push!) (lambda (x)
                   (if (null? stk)
                       (error "push!: the stack is empty")
                       (set! stk (append stk (list x))))))
        ((pop!)(lambda ()
                  (if (null? stk)
                      (error "pop!: the stack is empty")
                      (cdr stk))))
        ((top) (lambda ()
                  (if (null? stk)
                      (error "top: the stack is empty")
                      (car stk))))
        (else (error "stack: Invalid message" message))))))

;;;;;;;;EXERCISE 6;;;;;;;


;;;;;;;;EXERCISE 7;;;;;;;
(define c (mcons 1 2))
(define d (mcons 0 c))
(define e (mcons 0 c))


;;;;;;;;EXERCISE 9;;;;;;;
(define xx 2)
(define (modify y)
  (set! y 5))

;;;;;;;;EXERCISE 10;;;;;;
(define x1 (mcons 1 2))
(define (modify1 y)
  (set-mcdr! y 5))