#lang racket
(require eopl/eopl)

;;LECTURE 3, slide 13
(define-datatype binTree binTree?
  (leaf-node
   (datum number?))
  (interior-node
   (left binTree?)
   (right binTree?)))

(define tree (interior-node
              (leaf-node 3)
              (interior-node (leaf-node 7) (leaf-node 10))))

(define (binTree-flip t)
  (cases binTree t
    (leaf-node (datum) (leaf-node datum))
    (interior-node (left right)
                   (append (interior-node (binTree-flip right) (binTree-flip left))))))

;;Quiz #1, Number 2
(define-datatype BTree BTree?
       (leaf-t
          (data number?))
       (node-t
          (left BTree?)
          (right BTree?)))
;;BTree -> bool
(define (isNode t)
  (cases BTree t
    (leaf-t (data) #f)
    (node-t (left right) #t)))

;;BTree -> string
(define (prettyPrint t)
  (cases BTree t
    (leaf-t (data) (number->string data))
    (node-t (left right) (string-append "(" (prettyPrint left) " " (prettyPrint right) ")"))))

;;Quiz #3
(define queue
  (let ((data '()))
    (lambda (message)
      (case message
        ((empty?) (lambda ()
                    (null? data)))
        ((add!) (lambda (x)
                  (set! data (append data (list x)))))
        ((remove!) (lambda ()
                     (if (null? data)
                         (error "remove!: The queue is empty")
                         (cdr data))))
        ((peek) (lambda ()
                  (if (null? data)
                      (error "peek: The queue is empty")
                      (car data))))
        (else (error "queue: Invalide message" message))))))