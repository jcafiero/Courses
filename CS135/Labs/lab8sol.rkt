#lang eopl
;FUNCTIONS WE'RE ALLOWED TO USE
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


;(define (complement setA)
;  (set-difference universe setA))




;PART 0: Relations Warm Up

(define sample '((old new) (borrowed blue) (thing1 thing2) (oneFish twoFish) (redFish blueFish)))
(define author-character '((Doyle Holmes) (Poe Dupin) (Dickens Dodger) (Shakespeare Macbeth) (Shakespeare Lear) (Shakespeare Hamlet) (Twain Finn) (Hugo Valjean) (Shakespeare Romeo) (Shakespeare Juliet) (Tolstoy Karenina) (Dumas Athos) (Dumas Porthos) (Dahl WillyWonka) (Dumas Aramis) (Melville Ahab) (Stevenson Silver) (Christie Marple) (Christie Poirot) (Carroll Alice)))
(define character-attributes '((Holmes detective) (Dupin detective) (Macbeth villain) (Lear king) (Hamlet prince) (Dodger rascal) (Finn rascal) (CharlieBucket GoodBoy) (WillyWonka Chocolatier) (valJean hero) (Romeo lover) (Juliet lover) (Macbeth king) (Karenina lover) (Athos musketeer) (Porthos musketeer) (Aramis musketeer) (Ahab captain) (Ahab whaler) (Silver pirate) (Marple detective) (Poirot detective) (Alice dreamer)))
(define cycle6 '((1 2) (2 3) (3 4) (4 5) (5 6) (6 1)))
(define david '((1 3) (3 1) (2 4) (4 2) (3 5) (5 3) (4 6) (6 4) (5 1) (1 5) (6 2) (2 6)))
(define study '((1 6) (2 2) (2 3) (3 1) (4 1) (5 1) (5 6) (6 5)))
(define test '((1 2) (2 3) (2 1) (3 3) (4 5) (5 2)))

(define not-relation '((1 2 3) (1 2) (4 5) 6))
(define U '(1 2 3 4 5 6))

(define (relation? list-of-duples-we-hope)
  (if (equal? list-of-duples-we-hope '())
  	#t
  	(if (equal? (length (car list-of-duples-we-hope)) 2)
      	(relation? (cdr list-of-duples-we-hope))
      	#f)))

(define test-relations (and (relation? sample)
                            (relation? author-character)
                            (relation? character-attributes)
                            (relation? cycle6)
                            (relation? david)
                            (relation? test)
                            (relation? study)))

;PART 1: Reflexivity
(define delta6 '((1 1) (2 2) (3 3) (4 4) (5 5) (6 6)))
(define (id n)
  (if (equal? n 0)
  	'()
  	(append (list (append (list n) (list n))) (id (- n 1)))))
(display (id 6))
;(display (id 1))
;(display (id 0))

(define (reflexive? relation n)
  (set-equal? (id n) relation))
(display (reflexive? (id 6) 6))
;(display (reflexive? delta6 6))

(define (reflexive-closure relation n)
  (if (equal? relation '())
  	(reverse (id n))
  	(if (member (car relation) (id n))
      	(reflexive-closure (cdr relation) n)
      	(append (reflexive-closure (cdr relation) n) (list (car relation))))))

;PART 2: Symmetry
(define (R-minus-1 relation)
  (if (equal? relation '())
  	'()
  	(append (list (reverse (car relation))) (R-minus-1 (cdr relation)))))

;(display (R-minus-1 cycle6))
;(display (R-minus-1 (id 6)))
;(display (R-minus-1 test))

(define (symmetric? relation)
  (subset? relation (R-minus-1 relation)))

(define (symm relation starting)
  (if (equal? relation '())
 	(R-minus-1 starting)
 	(if (member (car relation) (R-minus-1 relation))
     	(symm (cdr relation) starting)
     	(cons (car relation) (symm (cdr relation) starting) ))))

(define (symmetric-closure relation)
  (symm relation relation))

(display (symmetric-closure cycle6))

(display (symmetric? (symmetric-closure cycle6)))

;PART 3: Anti-Symmetry
(define (antisymmetric? relation)
  (if (equal? relation '())
  	#t
  	(if (member (reverse (car relation) ) relation)
      	#f
      	(antisymmetric? (cdr relation)))))
(display (antisymmetric? cycle6))
;(display (antisymmetric? (id 5)))
;(display (antisymmetric? test))

(define (related-to element relation)
  (if (equal? relation '())
  	'()
  	(if (equal? (caar relation) element)
      	(append (cdar relation) (related-to element (cdr relation)))
      	(related-to element (cdr relation)))))

(display (related-to 1 (id 6)))
;(display (related-to 1 david))
;(display (related-to 'Shakespeare author-character))

;PART 4: Composition of Relations
(define (comp element list1)
  (if (equal? list1 '())
  	'()
  	(cons (append (list element) (list(car list1))) (comp element (cdr list1)))))

(define (composite relationOuter relationInner)
  (if (equal? relationOuter '())
  	'()
  	(append (comp (caar relationOuter) (related-to (cadar relationOuter) relationInner)) (composite (cdr relationOuter) relationInner))))
(display (composite cycle6 cycle6))
;(display (composite (id 6) (id 6)))
;(display (composite test test))       	 
;(display (composite test cycle6))
;(display (composite cycle6 test))