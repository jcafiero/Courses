#lang eopl
;BELOW ARE SET DATA STRUCTURE FUNCTIONS AVAILABLE FOR USE IN THIS LAB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (element? item list-of-items)
  (if (null? list-of-items)                  ;Is our "set" empty?
      #f                                     ;If empty, not an element!
      (if (equal? item (car list-of-items))  ;Is our item first in list?
          #t                                 ;Yes?  Then it's an element!
          (element? item (cdr list-of-items)))));No? Check the rest.

(define (make-set list-of-items)
  (if (null? list-of-items) ;An empty list can have no duplicates,
      '()                   ;so just return an empty list.
      (if (element? (car list-of-items) (cdr list-of-items))
          (make-set (cdr list-of-items))
          (cons (car list-of-items) (make-set (cdr list-of-items))))))
         
(define (union setA setB)
  (make-set (append setA setB))) 

(define (intersection setA setB)
  (make-set (Intersection (make-set setA) (make-set setB))))

(define (Intersection setA setB)
  (if (null? setA) 
      '()
      (if (element? (car setA) setB)
          (cons (car setA) (intersection (cdr setA) setB))
          (intersection (cdr setA) setB))))

(define (subset? setA setB)
  (if (null? setA)
      #t
      (if (element? (car setA) setB)
          (subset? (cdr setA)  setB)
          #f)))

(define (set-equal? setA setB)
   (and (subset? setA setB) (subset? setB setA)))

(define (proper-subset? setA setB)
  (and (subset? setA setB) (not (set-equal? setA setB))))

(define (set-difference setA setB)
  (make-set (Set-Difference setA setB)))

(define (Set-Difference setA setB)
  (if (null? setA)
      '()
      (if (element? (car setA) setB)
          (Set-Difference (cdr setA) setB)
          (cons (car setA) (Set-Difference (cdr setA) setB)))))

(define (sym-diff setA setB)
  (union (set-difference setA setB) (set-difference setB setA)))

(define (cardinality set)
  (length (make-set set)))

(define (disjoint? setA setB)
  (null? (intersection setA setB)))

(define (superset? setA setB)
  (subset? setB setA))

(define (insert element set)
  (make-set (cons element set)))

(define (remove element set)
  (set-difference set (list element)))




;PART 0

(define Hasse72 '((6 12) (6 18) (9 18) (8 24) (12 24) (12 36) (18 36) (24 72) (36 72) (1 2) (1 3) (2 4) (2 6) (3 6) (3 9) (4 8) (4 12))) 
(define RevHasse72 (reverse Hasse72))
(define HasseX '((LowerLeft Middle) (Middle UpperRight) (LowerRight Middle) (Middle UpperLeft)))

;PART 1

(define (minimal-elements HasseDuples)
  (set-difference (make-first-list HasseDuples) (make-first-list (make-second-list HasseDuples))))
  
(define (make-first-list duples) 
  (if (equal? duples '())
      '()
      (cons (caar duples) (make-first-list (cdr duples)))))

(define (make-second-list duples) 
  (if (equal? duples '())
      '()
      (cons (reverse (car duples)) (make-second-list (cdr duples)))))

(display (minimal-elements Hasse72))
(display (minimal-elements HasseX))

;PART 2

(define (rinse min-element HasseDuples)
  (if (equal? HasseDuples '())
      '()
      (if (equal? min-element (caar HasseDuples))
          (rinse min-element (cdr HasseDuples))
          (cons (car HasseDuples) (rinse min-element (cdr HasseDuples))))))

(display (rinse 1 Hasse72))
(display (rinse 'LowerRight HasseX))

;PART 3

(define (topological-sort HasseDuples)
  (if (equal? HasseDuples '())
      '()
      (cons (car (minimal-elements HasseDuples)) (topological-sort (rinse (car (minimal-elements HasseDuples)) HasseDuples))))) 
                                                                                
(display (topological-sort Hasse72))                                                                          
                                                                                
;PART 4
                                                                                
(define (create-list duples)
  (if (equal? duples '())
      '()
      (append (cdar duples) (create-list (cdr duples)))))

(define (maximal-elements HasseDuples)
  (set-difference (create-list HasseDuples) (create-list (make-second-list HasseDuples))))

(define (topo-sort HasseDuples)
  (append (topological-sort HasseDuples) (maximal-elements HasseDuples)))

(display (topo-sort Hasse72))
                                                                              