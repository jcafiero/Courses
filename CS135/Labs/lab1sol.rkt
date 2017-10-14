#lang eopl

(+ 3 5)
(* 3 5)
(- 3 5)
(/ 3 5)

(- 5 3)
(/ 5 3)

(+ 1 2 3 4)
(* 1 2 3 4 5)

(- 1 2 3 4)
(/ 1 2 3 4 5)

(= 3 5)
(< 3 5)
(not(= 3 5))


(number? 23)
(number? #t)
(equal? 3 5)
(odd? 3)
(positive? -7)
(even? 5)
(zero? 15)

(equal? #f #f)
(= (/ 2 5) (/ .2 .5))
(zero? (- (/ 2 5) .4))

"Hello, World!"
(number? 5)
(boolean? 5)
(integer? 3.2)
(string? "Hello, World!")

(procedure? +)
(procedure? #f)
(procedure? odd?)
(procedure? 17)

(string? "3")
(number? 3)
(not(equal? 3 "3"))

(sqrt 100)
(sqrt 2)

(log 100)
(/ (log 1024) (log 2))

(define (log2 x) (/ (log x) (log 2)))
(log2 1024)
(log2 16)
(log2 1000)

(define (lg x)
  (/ (log x) (log 2)))

(exp -1)
(exp 0)
(exp 1)
(exp 5)


;GOLDEN TICKET
(define pi 3.14159265)

(define root2
  (sqrt 2))


(define phi (/ (+ 1 (sqrt 5)) 2))

(display phi)



