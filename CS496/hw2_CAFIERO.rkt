;;Author: Jennifer Cafiero
;;I pledge my honor that I have abided by the Stevens Honor System
#lang racket
(require eopl/eopl)

;;EXERCISE 1

(define-datatype dTree dTree?
          (leaf-t
              (data number?))
          (node-t
              (symbol symbol?)
              (left dTree?)
              (right dTree?)))


;;EXERCISE 2

(define tLeft (node-t 'w
                      (node-t 'x (leaf-t 2) (leaf-t 5))
                      (leaf-t 8)))

(define tRight (node-t 'w
                       (node-t 'x (leaf-t 2) (leaf-t 5))
                       (node-t 'y (leaf-t 7) (leaf-t 5))))

;;EXERCISE 3

;;Part A
;;dTree -> num
(define (dTree-height tree)
  (cases dTree tree
    (leaf-t (n) 0)
    (node-t (x left right) (+ 1 (max (dTree-height left) (dTree-height right))))))

;;Part B
;;dTree -> num
(define (dTree-size tree)
  (cases dTree tree
    (leaf-t (n) 1)
    (node-t (x left right) (+ 1 (dTree-size left) (dTree-size right)))))

;;Part C
;;dTree -> [[a]]
(define (dTree-paths tree)
  (cases dTree tree
    (leaf-t (n) '(()) )
    (node-t (x left right)
            (append (map (lambda (app) (cons 0 app)) (dTree-paths left))
                   (map (lambda (app) (cons 1 app)) (dTree-paths right))))))

;;Part D
;;dTree -> bool
(define (dTree-perfect? tree)
  (cases dTree tree
    (leaf-t (n) #t)
    (node-t (x left right) (equal? (dTree-height left) (dTree-height right)))))

;;Part E

;;symbol? -> symbol?
(define symbol-upcase
  (compose string->symbol (compose string-upcase symbol->string)))

;;number? -> number?
(define (succ x)
  (+ 1 x))

;;{fx, gx, dTree} -> dTree
(define (dTree-map f g t)
  (cases dTree t
    (leaf-t (n) (leaf-t (g n)))
    (node-t (x left right) (node-t (f x) (dTree-map f g left) (dTree-map f g right)))))

;;Exercise 4

;;[a] -> dTree
(define (list->tree xs)
  (if (empty? xs)
      (leaf-t 0)
      (node-t (car xs) (list->tree (cdr xs)) (list->tree (cdr xs)))))
  
;;Exercise 5

(define xyz
  '( (x y z)
   (((0 0 0) . 0)
    ((0 0 1) . 1)
    ((0 1 0) . 1)
    ((0 1 1) . 0)
    ((1 0 0) . 1)
    ((1 0 1) . 0)
    ((1 1 0) . 0)
    ((1 1 1) . 1)
    )))

(define blank_xyz
  '(((0 0 0) . 0)
    ((0 0 1) . 1)
    ((0 1 0) . 1)
    ((0 1 1) . 0)
    ((1 0 0) . 1)
    ((1 0 1) . 0)
    ((1 1 0) . 0)
    ((1 1 1) . 1)
    ))

(define (replaceHelper tree path new)
  (cases dTree tree
    (leaf-t (n) (leaf-t new))
    (node-t (x left right) (node-t x (if (equal? (car path) 0)
                                          (replaceHelper left (cdr path) new)
                                          left)
                                      (if (equal? (car path) 1)
                                          (replaceHelper right (cdr path) new)
                                          right)))))
                                      
                                         
    

  
;;{dTree, graph} -> dTree
(define (replaceLeafAt t f)
  (match f
      ['() t]
      [(cons head tail) (replaceLeafAt (replaceHelper t (car head) (cdr head)) tail)]))
  
;;Exercise 6
;;dTree -> dTree
(define (bf->tree t)
  (replaceLeafAt (list->tree (car t)) (cdr t)))


