#lang racket

(define (parse lst)
  (define (prse lst)
    (let loop ((lst lst) (res null))
      (cond
        ((null? lst) (values null res))
        ((string=? (car lst) "[")
         (let-values ([(lst2 res2) (prse (cdr lst))])
           (loop lst2 (append res (list res2)))))
        ((string=? (car lst) "]")
         (values (cdr lst) res))
        (else
         (loop (cdr lst) (append res (list (car lst))))))))
  (let-values ([(lst res) (prse lst)])
    res))
  