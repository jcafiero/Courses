#lang racket
(require eopl/eopl)

;;EXERCISE 6
;1
;2
;3 b/c it is not a pair or a list
;4 #f
;5 #t
;6 BTree

    (define-datatype BTree BTree?
    (leaf-t
     (data number?))
    (node-t
     (data number?)
     (left BTree?)
     (right BTree?)))

(define ex
  (node-t 2
          (node-t 12 (leaf-t 7) (leaf-t 11))
          (node-t 4 (leaf-t 1) (leaf-t 9))))

(define t
  (node-t 6
          (node-t 2 (leaf-t 1)
                  (node-t 4 (leaf-t 3)
                          (leaf-t 5)))
          (node-t 7 (leaf-t 8) (leaf-t 9))))

 
  (define (inorder t)
    (cases BTree t
      (leaf-t (data) (list data))
      (node-t (data left right) (append (inorder left) (append (list data) (inorder right))))))

  (define (preorder t)
    (cases BTree t
      (leaf-t (data) (list data))
      (node-t (data left right) (append (list data) (append (preorder left) (preorder right))))))

  (define (postorder t)
    (cases BTree t
      (leaf-t (data) (list data))
      (node-t (data left right) (append (postorder left) (append (postorder right)(list data))))))

(define (btree-product t)
  (cases BTree t
    (leaf-t (data) data)
    (node-t (data left right) (* data (* (btree-product left) (btree-product right))))))

(define (btree-element n t)
  (cases BTree t
    (leaf-t (data) (if (equal? data n)
                       #t
                       #f))
    (node-t (data left right) (if (equal? data n)
                                  #t
                                  (or (btree-element n left) (btree-element n right))))))

(define (btree-bimap fLeaf fNode t)
  (cases BTree t
    (leaf-t (data) (leaf-t (fLeaf data)))
    (node-t (data left right) (node-t (fNode data) (btree-bimap fLeaf fNode left) (btree-bimap fLeaf fNode right)))))

;;FIX
(define (btree-max t)
    (cases BTree t
      (leaf-t (data) (lambda (x) (max data x)))

      (node-t (data left right) (lambda (x) (max data x) (btree-max left) (btree-max right)))))

;;(define (btree-bst t))   
