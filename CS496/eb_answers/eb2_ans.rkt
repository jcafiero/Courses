#lang racket

(module data-structures (lib "eopl.ss" "eopl")


  (define-datatype SimpleBTree SimpleBTree?
    (leaf-t
     (data number?))
    (node-t
     (left SimpleBTree?)
     (right SimpleBTree?)))


;;SimpleBTree? -> boolean?
(define (isNode t)
  (cases SimpleBTree t
    (leaf-t (data) #f)
    (node-t (left right) #t)))

;;SimpleBTree? -> boolean?
(define (isLeaf t)
  (cases SimpleBTree t
    (leaf-t (data) #t)
    (node-t (left right) #f)))

;;SimpleBTree? -> String
(define (prettyPrint t)
  (cases SimpleBTree t
    (leaf-t (data) (number->string data))
    (node-t (left right) (string-append "(" (prettyPrint left) " " (prettyPrint right) ")"))))


  )

  