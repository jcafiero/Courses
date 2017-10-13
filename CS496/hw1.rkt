#lang racket

;Author: Jennifer Cafiero
;CS 496 - Homework 1
;Pledge: I pledge my honor that I have abided by the Stevens Honor System.

;; EXERCISE 1 

;; a -> num
(define (seven n)
  7)

;; num -> num
(define (sign n)
  (if (= n 0)
      0
      (if (> n 0)
          1
          -1)))

;; num -> num
(define (absolute n)
  (if (< n 0)
      (* -1 n)
      n))

;; {bool, bool} -> bool
(define (andp n m)
  (if (equal? n #t)
      (if (= m #t)
          #t
          #f)
      #f)
  )

;; {bool, bool} -> bool
(define (orp n m)
  (if (equal? n #t)
      (if (= m #t)
          #f
          #t)

      #t))

;;bool -> bool
(define (notp n)
  (if (equal? n #t)
      #f
      #t))

;;{bool, bool} -> bool
(define (xorp n m)
  (if (equal? n #t)
      (if (equal? m #f)
          #t
          #f)
          #t)
  (if (equal? n #f)
      (if (equal? m #t)
          #t
          #f)
          #t))

;;{num, num} -> bool
(define (dividesBy n m)
  (if (= (modulo n m) 0)
      #t
      #f))

;;[a] -> bool
(define (singleton? xs)
  (match xs
    [(list xs) #t]
    [_ #f])
  )
;;[a] -> bool
(define (singleton_ii? xs)
  (and (cons? xs) (null? (cdr xs))))

;;{a, b} -> {b, a}
(define (swap x)
  (match x
    [(cons f g) (cons g f)]))

;;(a -> b), a -> b
(define (app fn x)
  (fn x))

;; (a -> a), a -> a
(define (twice fn x)
  (fn (fn x)))

;; {a, b, c} -> (a (b (c)))
(define (compose fn gn x)
  (fn (gn x)))

;;EXERCISE 2

;;{a, [a]} -> bool

(define (belongsTo n xs)
  (if (null? xs)
      #f
      (if (equal? n (car xs))
          #t
          (belongsTo n (cdr xs)))))

;;Helper Function from CS 135 - used to remove all duplicates from a list, including nonconsecutive ones
;;[a] -> [a]
(define (make-set xs)
  (if (null? xs)
      '()
      (if (belongsTo (car xs) (cdr xs))
          (make-set (cdr xs))
          (cons (car xs) (make-set (cdr xs))))))

;;{[a], [a]} -> [a]
(define (union_a xs xt)
  (make-set (append xs xt)))

;;{[a], [a]} -> [a]
(define (intersection_a xs xt)
  (if (or (null? xs) (null? xt))
      '()
      (if (belongsTo (car xs) xt)
          (cons (car xs) (intersection_a (cdr xs) xt))
          (intersection_a (cdr xs) xt))))

;;{a, (a -> bool)} -> (a -> bool)
(define (belongsTo_b item fx)
  (lambda (n) (fx n)))

;;{a -> bool,a -> bool} -> (a -> bool)
(define (union_b fx gx)
  (lambda (x) (or (fx x) (gx x))))

;;{a -> bool,a -> bool} -> (a -> bool)
(define (intersection_b fx gx)
  (lambda (x) (and (fx x) (gx x))))

;;[a] -> [a]
(define (remDups xs)
  (if (null? xs)
      '()
      (if (null? (cdr xs))
          (cons (car xs) (remDups (cdr xs)))
          (if (= (car xs) (cadr xs))
              (remDups (cdr xs))
              (cons (car xs) (remDups (cdr xs)))))))

;;[a] -> [[a]]
(define (sublists xs)
  (if (null? xs)
      '(())
      (apply append (map (lambda (app)
                    (list app (cons (car xs) app)))
                   (sublists (cdr xs))))))
      
;;EXERCISE 3

(define e1
  '(num 2))
(define e2
  '(add (sub (num 2) (num 3)) (num 4)))
;;{a -> bool, exp} -> exp
(define (mapC fn x)
  (if (empty? fn)
      '()
      (match x
        [(? number? x) (fn x)]
        [(cons h t) (cons (mapC fn h) (mapC fn t))]
        [var var])))

;;{(num -> a), ((b, b) -> b), ((b, b) -> b), ((b, b) -> b), ((b, b) -> b, exp) -> b
(define (foldC num add sub mult div exp)
  (match exp
    [(list 'num x) (num x)]
    [(list 'add x y) (add (foldC num add sub mult div x) (foldC num add sub mult div y))]
    [(list 'sub x y) (sub (foldC num add sub mult div x) (foldC num add sub mult div y))]
    [(list 'mult x y) (mult (foldC num add sub mult div x) (foldC num add sub mult div y))]
    [(list 'div x y) (div (foldC num add sub mult div x) (foldC num add sub mult div y))]))

;;exp -> num
(define (numAdd exp)
    (foldC (lambda (x) 0)
           (lambda (x y) (+ 1 x y))
           (lambda (x y) 0)
           (lambda (x y) 0)
           (lambda (x y) 0)
           exp))

;;exp -> exp
(define (dontAddMult exp)
  (foldC (lambda (x) (list 'num x))
         (lambda (x y) (list 'mult x y))
         (lambda (x y) (list 'sub x y))
         (lambda (x y) (list 'mult x y))
         (lambda (x y) (list 'div x y))
         exp))

;;helper function to convert words to calculator symbols
;;exp -> num
(define (convertCalc exp)
  (match exp
    [(list 'num x) x]
    [(list 'add x y) (+ (convertCalc x) (convertCalc y))]
    [(list 'sub x y) (- (convertCalc x) (convertCalc y))]
    [(list 'mult x y) (* (convertCalc x) (convertCalc y))]
    [(list 'div x y) (/ (convertCalc x) (convertCalc y))]))

;;exp -> exp
(define (evalC exp)
  (list 'num (convertCalc exp)))

;;exp -> exp
(define (evalC_foldC exp)
  (list 'num (foldC (lambda (x) x)
                    (lambda (x y) (+ x y))
                    (lambda (x y) (- x y))
                    (lambda (x y) (* x y))
                    (lambda (x y) (/ x y))
                    exp)))


;;EXERCISE 4

(define (f xs)
  (let ((g (lambda (x r) (if (even? x) (+ r 1) r))))
    (foldl g 0 xs)))
;; Function f counts how many even numbers are in the inputted list.
;; Examples I ran:
;; (f '(99))           0
;; (f '(1 2 3 4 5 6)   3
;; (f '(2 4 6))        3


;;[[a]] -> [a]
(define (concat xss)
  (let ((g (lambda (xs h) (append xs h))))
    (foldl g identity xss)))

