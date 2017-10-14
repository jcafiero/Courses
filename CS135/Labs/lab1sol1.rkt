#lang eopl

;PART 1
;(a) nand
(define (nand p q)
  (not (and p q)))

;(display (nand #f #f))

;(b) if then
(define (if->then p q)
  (or (not p) q))

;(display (if->then #t #t))
;(display (if->then #t #f)) 
;(display (if->then #f #t)) 
;(display (if->then #f #f))

;(c) xor
(define (xor p q)
  (and (or p q)
       (not (and p q))
       )
  )

;(display (xor #t #t))
;(display (xor #t #f))
;(display (xor #f #t))
;(display (xor #f #f))

;PART 2

;(a) nand

(define (nand-commute? p q)
  (equal? (nand p q) (nand q p)))

;(display (nand-commute? #t #t))
;(display (nand-commute? #t #f))
;(display (nand-commute? #f #t))
;(display (nand-commute? #f #f))

;(b) if then

(define (if->then-commute? p q)
  (and (equal? (if->then #t #t) (if->then (#t #t))
       (equal? (if->then #t #f) (if->then #f #t))
       (equal? (if->then #f #t) (if->then #f #t))
       (equal? (if->then #f #f) (if->then #f #f))))
  )
 
(define (if->then-com? p q)     
  (equal? (if->then #t #f) (if->then #f #t)))

(define (if->then-c?)
  (equal? (if->then #t #f) (if->then #f #t)))

(define (commutes? operator)
  (equal? (operator #t #f) (operator #f #t)))

;(display (commutes? nand))
;(display (commutes? if->then))

(define (or2 p q)
  (or p q))
(define (and2 p q)
  (and p q))

;(display (commutes? or2))
;(display (commutes? and2))

;PART 3

(define (law-binary? left right)
  (and (equal? (left #t #t) (right #t #t))
       (equal? (left #t #f) (right #t #f))
       (equal? (left #f #t) (right #f #t))
       (equal? (left #f #f) (right #f #f))))

;(1) 
(define (not-p-or-not-q p q)
  (or (not p) (not q)))

;(display (law-binary? nand not-p-or-not-q))

;(2)
(define (nor p q)
  (not (or p q)))

(define (not-p-and-not-q p q)
  (and (not p) (not q)))

;(display (law-binary? nor not-p-and-not-q))
;(display (law-binary? nand nor))

;PART 4
;(1) 3majority

(define (3majority p q r)
  (or (or (and p q) (and q r)) (and p r)))

;(display (3majority #t #t #f))

;(2) isosceles

(define (isosceles p q r)
  (and (or (or (and p q) (and q r)) (and p r)) (not (and p q r))))

;(display (isosceles #f #t #t))

