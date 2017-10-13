#lang racket

(define (seven x)
  7)

(define (sign n)
  (if (= n 0)
      0
      (if (> n 0)
          1
          -1)))

(define (absolute n)
  (if (< n 0)
      (* n -1)
      n))

(define (andp n m)
  (if (equal? n #t)
      (if (equal? m #t)
          #t
          #f)
      #f)
  )

;; {bool, bool} -> bool
(define (orp n m)
  (if (not(equal? n #t))
      (if (not(equal? m #t))
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
      (if (equal? m #t)
          #f
          #t)
      (if (equal? m #t)
          #t
          #f)))

;;{num, num} -> bool
(define (dividesBy n m)
  (if (equal? (modulo n m) 0)
      #t
      #f))

;; (a -> b), a -> b
(define (app fn x)
  (fn x))

;;(a -> a), a -> a
(define (twice fn x)
  (fn (fn x)))

;;{a, b, c} => (a (b (c)))
(define (compose fn gn x)
  (fn (gn x)))


;;;;;;;;;;;;;;;;;;;;;;EXERCISE 3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; [a] -> {a , b}
(define (split l)
  (if (or (null? l) (null? (cdr l)))
      (list l)
      (cons (list (car l)) (list (cdr l)))))

;;[a] -> [a]
(define (doublelist xs)
  (cond
    ((null? xs) '())
    ((list? (car xs)) (cons (doublelist (car xs)) (doublelist (cdr xs))))
    (else (cons (* 2 (car xs)) (doublelist (cdr xs))))))

;;[a] -> [a]
(define (allOdd xs)
  (if (null? xs)
      #t
      (if (odd? (car xs))
          (allOdd (cdr xs))
          #f)))

;; [a] -> [a]
(define (removeEven xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (if (even? (car xs))
          (removeEven (cdr xs))
           (cons (car xs) (removeEven (cdr xs))))))

(define (belongsTo n xs)
  (if (null? xs)
      #f
      (if (equal? n (car xs))
          #t
          (belongsTo n (cdr xs)))))

;;[a] -> [a]
(define (removeDuplicates xs)
  (if (null? xs)
      '()
      (if (belongsTo (car xs) (cdr xs))
          (removeDuplicates (cdr xs))
          (cons (car xs) (removeDuplicates (cdr xs))))))

;;[a] -> [a]
(define (removeAdjacentDuplicates xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (if (equal? (car xs) (cadr xs))
          (removeAdjacentDuplicates (cdr xs))
          (cons (car xs) (removeAdjacentDuplicates (cdr xs))))))
      