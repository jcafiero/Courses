#lang eopl ;Always remember this line so that DrRacket uses 
;the correct interpreter

; Lab9 assignment Spring 2015     
; Tuesday, April 14, 2015

; Objective: Explore some more Scheme and do some of the things from 
; lecture in Scheme:

; Transitive Closure of Relations
; Equivalence Relations

; Make sure you are using #lang eopl in the first line.
; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat

;Part 0:  Review of Compose  (Warm Up)
;Part 1:  Powers of a Relation
;Part 2:  Transitive Closure of a Relation
;Part 3:  Equivalence Relation?
;Part 4:  Partitioning a Set using Equivalence Relations
;GOLDEN TICKET ????????????????????


;PART 0:  Review of Compose  (Warm Up)

;We used these relations last week, so let's start 
;here:                             
(define cycle6 '((1 2) (2 3) (3 4) (4 5) (5 6) (6 1)))
(define david '((1 3) (3 1) (2 4) (4 2) (3 5) (5 3) (4 6) (6 4) (5 1) (1 5) (6 2) (2 6)))
(define study '((1 6) (2 2) (2 3) (3 1) (4 1) (5 1) (5 6) (6 5)))
(define test '((1 2) (2 3) (2 1) (3 3) (4 5) (5 2)))

;We were able to compose them with each other, but this week we will
;limit ourselves to composing relations with themselves in an effort
;to compute the transitive closure of a relation.

;Included at the end of this lab are all the functions you created last 
;week.  Feel free to re-use your own if you like.  (All our set 
;operations are still available, too.  We'll definitely use "union" and
;"make-set".  And maybe more.)

;I've included both "compose" and "composite".  One is a single function
;nesting loops; the other is a pair each doing its own loop.

;"composite" nest loops with 2 procedures (after initial launch).
(define (composite relationOuter relationInner)
  (make-set (Composite relationOuter relationInner)))

(define (Composite relationOuter relationInner)
  (if (null? relationInner)
      '()
      (append (addDuples (car relationInner) relationOuter)
            (Composite relationOuter (cdr relationInner)))))

(define (addDuples duple list-of-duples)
  (if (null? list-of-duples)
      '()
      (if (equal? (cadr duple) (caar list-of-duples))
          (cons (list (car duple) (cadar list-of-duples))
                (addDuples duple (cdr list-of-duples)))
          (addDuples duple (cdr list-of-duples)))))

;Here it is as a single procedure that nests lists:
;"if"-version rather than "cond" with a launcher
(define (compose relationOuter relationInner)
  (make-set (Compose relationOuter relationOuter relationInner)))

(define (Compose pristineOuter relationOuter relationInner)
  (if (null? relationInner)
      '()
      (if (null? relationOuter)
          (Compose pristineOuter pristineOuter (cdr relationInner))
          (if (equal? (cadar relationInner) (caar relationOuter))
              (cons (list (caar relationInner) (cadar relationOuter))
                    (Compose pristineOuter 
                             (cdr relationOuter) 
                             relationInner))
              (Compose pristineOuter 
                             (cdr relationOuter) 
                             relationInner)))))

;Convince yourself they do what you expect:

;(compose   test study)
;(composite test study)

;Those should look exactly the same.

;(compose   study test)
;(composite study test)

;Those should look exactly the same, too.  But they should look
;different from the first two pairs above because the composition
;process is not commutative.

;(compose   cycle6 cycle6)
;(composite cycle6 cycle6)

;Those should look exactly the same, too.  And we'll do much more of that
;presently...

;Warmed up?  Enough review!


;PART 1:  Powers of a Relation
;
;Write a procedure "power" that computes R^k for relation R.
;(NOTE:  For today it's OK if your code is a little fragile.
;We'd LOVE to be able to get R^0 to be (id n), but n won't be
;clear unless we include another parameter.  Just assume for now
;that you don't have to worry about bogus input.  You get a relation
;and an index k, and you must compute R^k for any positive integer k.
;Yes, that means (power relation 1) should return 'relation'.)

;Here's a potentially useful skeleton:
(define (power relation k)
  ("your definition goes here"))
;      (Power relation relation k-or-kMinus1-or-some-k-thing)))

(define (Power relation power-so-far k-index)
  "Your recursive definition goes here")

;(power cycle6 1)-->  ((1 2) (2 3) (3 4) (4 5) (5 6) (6 1))
;(power cycle6 2) --> ((1 3) (2 4) (3 5) (4 6) (5 1) (6 2))
;(power cycle6 3) --> ((1 4) (2 5) (3 6) (4 1) (5 2) (6 3))
;(power cycle6 4) --> ((1 5) (2 6) (3 1) (4 2) (5 3) (6 4))
;(power cycle6 5) --> ((1 6) (2 1) (3 2) (4 3) (5 4) (6 5))
;(power cycle6 6) --> ((1 1) (2 2) (3 3) (4 4) (5 5) (6 6))
;(power cycle6 7) --> ((1 2) (2 3) (3 4) (4 5) (5 6) (6 1))

;It may be a little tricky lining up your index with your output.
;Be patient.  You'll see how to do it.

;We need "power" for the next PART.

;HINT:  (power relation 2) is (compose relation relation)
;and (power relation 3) is (compose relation (compose relation relation))
;You just need to write a recursive procedure that composes relation
;with previous powers of itself the right number of times.
;Keep feeding relation to itelf (with compose) until it comes out right.

;

;Your TA will test your "power".


;PART 2:  Transitive Closure of a Relation

;The transitive closure is easy:

;R* = R U R^2 U R^3 U ... U R^n, where n = |S| and S is the set on which 
;R is defined.

;So one approach would be to determine the size of S, and then compute
;all those powers and take their union.

;If you choose this route, your function will look like this:
;(define (transitive-closure relation n)

;(You COULD omit the n by scanning all the ordered pairs and counting
;the unique entries and making THAT your n.  That's more work than you
;need to do today...unless you're feeling ambitious....)

;Another slightly more general and exciting way to think about it goes 
;like this: R^k is the relation that represents where I can get with k 
;steps of relation R.  As long as I keep getting to new places, I need 
;to keep adding those powers of R by taking unions with what I've done 
;before.  But once I can't get anywhere new, I can stop.

;As long as R^k is not a subset of our partial union of powers, we need
;to add its union to the mix.  Once R^k IS a subset of the union so far,
;we can output the union-so-far as our transitive closure.  You'll never 
;have to do more work with this version than the previous one (often 
;less!), and you don't need to know the size of your underlying set this 
;way.

(define (transitive-closure relation)
  ("Your recursive definition goes here"))
                                          
;Your TA will test your "transitive-closure"


;PART 3:  Equivalence Relations

;An Equivalence Relation is a relation that is reflexive, AND symmetric, ;AND transitive.  Last week, you created:

;(relation? relation)
;(reflexive? relation n)
;(symmetric? relation)
;Working versions of those are appended to this lab.

;In order to complete (EQ-relation? relation n), all we're missing is:
;(transitive? relation)

;A relation is transitive iff it contains its transitive-closure as 
;subset.

(define (transitive? relation)
  ("Your definition goes here"))

;With that in your pocket, write (EQ-relation? relation n)
;(You need that pesky n for "reflexive?" to work.  Bummer.)

(define (EQ-relation? relation n)
  ("Your definition goes here"))

;Here's a for-real equivalence relation for testing purposes:
(define EQrel10 '((1 1) (1 2) (2 2) (2 1) (3 3) (4 4) (4 5) (4 6) (5 4) (6 4) (5 5) (6 6) (5 6) (6 5) (7 7) (7 8) (8 7) (7 9) (9 7) (7 10) (10 7) (8 8) (8 9) (9 8) (8 10) (10 8) (9 9) (9 10) (10 9) (10 10)))

;(EQ-relation? EQrel10 10) --> #t
;(EQ-relation? EQrel10 11) --> #f
;(EQ-relation? cycle6  6) --> #f
;(EQ-relation? '() 0) --> #t

    
;Your TA will test your "transitive?" and your "EQ-relation?"


;PART 4:  Partitions of Sets Using Equivalence Relations

;The last thing we'd like to do is to partition our equivalence relation:

;(partition EQrel10) -> ((1 2) (3) (4 5 6) (7 8 9 10))

;That is, return a list of the equivalence classes of our relation.
;Take the first "thing" that shows up in the EQrelation.
;Make a list of all the things it's "related-to" and add that to the list
;to be returned.  As you recur, make sure you remove all the duples from
;our relation that have ANY of the elements of that equivalence class in 
;them.  (It's a keep & chuck procedure you need to write -- I called mine
;(rinse eq-class eq-relation).  It chucks any duple for which 
;(intersection eq-class (car eq-relation)) is non-empty and keeps the 
;rest.  (I've said too much!)

;I've included "related-to" from last week.  That will create your
;equivalence classes straightaway.  (Now I've REALLY said too much)

;(related-to 5 EQrel10) --> (4 5 6)

;(Again, it's OK if our code is a little fragile.  You can assume the
;input relation is a well-defined Equivalence Relation, hence our use
;of EQ in the following definition:  )

;Here's a potentially useful skeleton:
(define (partition EQ)
  ("your recursive definition goes here"))
;      (cons 'new equiv class' (partition 'EQ with new class rinsed out')

(define (rinse EQ-class relation)
  ("your recursive definition of a keep & chuck procedure goes here"))
          
;(partition EQrel10) -> ((1 2) (3) (4 5 6) (7 8 9 10))

;Of course, the order OF the classes and the order IN the classes is
;meaningless.  If you get differnt orders, I'd LOVE to see your code.
;If you follow my recipe, this is what you'll get.  If you get something
;else, we're thinking about it differently, and I'd love the chance to 
;peek inside your brain....

;Your TA will test your "partition".


;GOLDEN TICKET    Wonka World

;We've spent some time in WonkaWorld these last weeks and months, and we
;have encountered many of its denizens.

;There are heros and villains, bosses and workers, fargles and bargles.

;Just how many different equivalence classes are there in WonkaWorld?

;(You can test:
;(symmetric? WonkaWorld)
;(transitive? WonkaWorld)
;But not (reflexive? WonkaWorld) because we defined that only for 
;relations defined on sets of positive integers.  You'll have to take my
;word for it that WonkaWorld is reflexive.  Or you could write a new 
;procedure that makes sure all possible (denizen denizen) duples are 
;there.

;WonkaWorld below is an equivalence relation.  Into how many equivalence 
;classes does it partition the denizens of Wonka World?

;How many denizens of WonkaWorld are included here?


(define WonkaWorld '((Vavoompa-Vavoompa Vavoompa-Vavoompa)      (Oompa-Floompa Oompa-Vavoompa) (Oompa-Boompa Oompa-Boompa)(Boompa-Loompa Zoompa-Loompa)  (Oompa-Boompa Oompa-Roompa)(Oompa-Boompa Oompa-Vavoompa)(Oompa-Boompa Oompa-Broompa)(Oompa-Boompa Oompa-Floompa)(MikeTeevee MikeTeevee)(Oompa-Zoompa Oompa-Boompa)(Oompa-Zoompa Oompa-Zoompa)(Oompa-Zoompa Oompa-Doompa)(Prodnose Prodnose)(Oompa-Zoompa Oompa-Roompa)(Oompa-Zoompa Oompa-Vavoompa)(Oompa-Zoompa Oompa-Broompa)(Oompa-Zoompa Oompa-Floompa)(Oompa-Doompa Oompa-Boompa)(Oompa-Doompa Oompa-Zoompa)(Oompa-Doompa Oompa-Doompa)(Oompa-Doompa Oompa-Roompa)(Oompa-Doompa Oompa-Vavoompa)(VioletBeauregarde VioletBeauregarde)(Oompa-Doompa Oompa-Broompa)(Oompa-Doompa Oompa-Floompa)(Oompa-Roompa Oompa-Boompa)(Oompa-Roompa Oompa-Zoompa)(Oompa-Roompa Oompa-Doompa)(Oompa-Roompa Oompa-Roompa)(Oompa-Roompa Oompa-Vavoompa)(Oompa-Roompa Oompa-Broompa)(VioletBeauregarde AugustusGloop) (AugustusGloop VerucaSalt) (VerucaSalt AugustusGloop) (AugustusGloop MikeTeevee) (MikeTeevee AugustusGloop)  (VioletBeauregarde VerucaSalt) (VerucaSalt VioletBeauregarde) (VioletBeauregarde MikeTeevee) (MikeTeevee VioletBeauregarde) (VerucaSalt VerucaSalt) (VerucaSalt MikeTeevee) (MikeTeevee VerucaSalt)  (Oompa-Boompa Oompa-Zoompa)(Oompa-Boompa Oompa-Doompa)(Oompa-Roompa Oompa-Floompa)(Oompa-Vavoompa Oompa-Boompa)(Oompa-Vavoompa Oompa-Zoompa)(Oompa-Vavoompa Oompa-Doompa)(Fickelgruber Fickelgruber)(Oompa-Vavoompa Oompa-Roompa)(Oompa-Vavoompa Oompa-Vavoompa)(Oompa-Vavoompa Oompa-Broompa)(Oompa-Vavoompa Oompa-Floompa)(AugustusGloop AugustusGloop)(Oompa-Broompa Oompa-Boompa)(Oompa-Broompa Oompa-Zoompa)(Prodnose Fickelgruber) (Slugworth Fickelgruber)  (Slugworth Slugworth) (Prodnose Slugworth) (Slugworth Prodnose)  (AugustusGloop VioletBeauregarde)(Oompa-Broompa Oompa-Doompa)(Oompa-Broompa Oompa-Roompa)(Oompa-Broompa Oompa-Vavoompa)(Oompa-Broompa Oompa-Broompa)(Oompa-Broompa Oompa-Floompa)(Oompa-Floompa Oompa-Boompa)(Oompa-Floompa Oompa-Zoompa)(Oompa-Floompa Oompa-Doompa)(Oompa-Floompa Oompa-Roompa)(Oompa-Floompa Oompa-Broompa)(Oompa-Floompa Oompa-Floompa)(Boompa-Loompa Boompa-Loompa)(Boompa-Loompa Doompa-Loompa)(Boompa-Loompa Roompa-Loompa)(Boompa-Loompa Vavoompa-Loompa)(Boompa-Loompa Broompa-Loompa)(Boompa-Loompa Floompa-Loompa)(Zoompa-Loompa Boompa-Loompa)(Zoompa-Loompa Zoompa-Loompa)(Zoompa-Loompa Doompa-Loompa)(Zoompa-Loompa Roompa-Loompa)(Zoompa-Loompa Vavoompa-Loompa)(Zoompa-Loompa Broompa-Loompa)(Zoompa-Loompa Floompa-Loompa)(Doompa-Loompa Boompa-Loompa)(Doompa-Loompa Zoompa-Loompa)(Doompa-Loompa Doompa-Loompa)(Doompa-Loompa Roompa-Loompa)(Doompa-Loompa Vavoompa-Loompa)(Doompa-Loompa Broompa-Loompa)(Doompa-Loompa Floompa-Loompa)(Roompa-Loompa Boompa-Loompa)(Roompa-Loompa Zoompa-Loompa)(Roompa-Loompa Doompa-Loompa)(Roompa-Loompa Roompa-Loompa)(Roompa-Loompa Vavoompa-Loompa)(Roompa-Loompa Broompa-Loompa)(Roompa-Loompa Floompa-Loompa)(Vavoompa-Loompa Boompa-Loompa)(Vavoompa-Loompa Zoompa-Loompa)(Vavoompa-Loompa Doompa-Loompa)(Vavoompa-Loompa Roompa-Loompa)(Vavoompa-Loompa Vavoompa-Loompa)(Vavoompa-Loompa Broompa-Loompa)(Vavoompa-Loompa Floompa-Loompa)(Broompa-Loompa Boompa-Loompa)(Broompa-Loompa Zoompa-Loompa)(Broompa-Loompa Doompa-Loompa)(Broompa-Loompa Roompa-Loompa)(Broompa-Loompa Vavoompa-Loompa)(Broompa-Loompa Broompa-Loompa)(Broompa-Loompa Floompa-Loompa)(Floompa-Loompa Boompa-Loompa)(Floompa-Loompa Zoompa-Loompa)(Floompa-Loompa Doompa-Loompa)(Floompa-Loompa Roompa-Loompa)(Floompa-Loompa Vavoompa-Loompa)(Floompa-Loompa Broompa-Loompa)(Floompa-Loompa Floompa-Loompa)(Boompa-Boompa Boompa-Boompa)(Boompa-Boompa Zoompa-Zoompa)(Boompa-Boompa Doompa-Doompa)(Boompa-Boompa Roompa-Roompa)(Boompa-Boompa Vavoompa-Vavoompa)(Boompa-Boompa Broompa-Broompa)(Boompa-Boompa Floompa-Floompa)(Boompa-Boompa Oompa-Oompa)(Boompa-Boompa Loompa-Loompa)(Zoompa-Zoompa Boompa-Boompa)(Zoompa-Zoompa Zoompa-Zoompa)(Zoompa-Zoompa Doompa-Doompa)(Zoompa-Zoompa Roompa-Roompa)(Zoompa-Zoompa Vavoompa-Vavoompa)(Fickelgruber Prodnose)(Zoompa-Zoompa Broompa-Broompa)(Zoompa-Zoompa Floompa-Floompa)(Zoompa-Zoompa Oompa-Oompa)(Zoompa-Zoompa Loompa-Loompa)(Doompa-Doompa Boompa-Boompa)(Doompa-Doompa Zoompa-Zoompa)(Doompa-Doompa Doompa-Doompa)(Doompa-Doompa Roompa-Roompa)(Doompa-Doompa Vavoompa-Vavoompa)(Doompa-Doompa Broompa-Broompa)(Doompa-Doompa Floompa-Floompa)(Doompa-Doompa Oompa-Oompa)(Doompa-Doompa Loompa-Loompa)(Roompa-Roompa Boompa-Boompa)(Roompa-Roompa Zoompa-Zoompa)(Roompa-Roompa Doompa-Doompa)(Fickelgruber Slugworth)(Roompa-Roompa Roompa-Roompa)(Roompa-Roompa Vavoompa-Vavoompa)(Roompa-Roompa Broompa-Broompa)(Roompa-Roompa Floompa-Floompa)(GrandpaJoe GrandpaJoe)(Roompa-Roompa Oompa-Oompa)(Roompa-Roompa Loompa-Loompa)(Vavoompa-Vavoompa Boompa-Boompa)(Vavoompa-Vavoompa Zoompa-Zoompa)(Vavoompa-Vavoompa Doompa-Doompa)(Vavoompa-Vavoompa Roompa-Roompa)(Vavoompa-Vavoompa Broompa-Broompa)(CharlieBucket GrandpaJoe)(Vavoompa-Vavoompa Floompa-Floompa)(Vavoompa-Vavoompa Oompa-Oompa)(Vavoompa-Vavoompa Loompa-Loompa)(Broompa-Broompa Boompa-Boompa)(Broompa-Broompa Zoompa-Zoompa)(Broompa-Broompa Doompa-Doompa)(Broompa-Broompa Roompa-Roompa)(Broompa-Broompa Vavoompa-Vavoompa)(Broompa-Broompa Broompa-Broompa)(Broompa-Broompa Floompa-Floompa)(Broompa-Broompa Oompa-Oompa)(Broompa-Broompa Loompa-Loompa)(Floompa-Floompa Boompa-Boompa)(Floompa-Floompa Zoompa-Zoompa) (Floompa-Floompa Doompa-Doompa)(Floompa-Floompa Roompa-Roompa)(Floompa-Floompa Vavoompa-Vavoompa)(Floompa-Floompa Broompa-Broompa)(Floompa-Floompa Floompa-Floompa)(Floompa-Floompa Oompa-Oompa)(Floompa-Floompa Loompa-Loompa)(Oompa-Oompa Boompa-Boompa)(Oompa-Oompa Zoompa-Zoompa)(Oompa-Oompa Doompa-Doompa)(Oompa-Oompa Roompa-Roompa)(Oompa-Oompa Vavoompa-Vavoompa)(CharlieBucket CharlieBucket)(Oompa-Oompa Broompa-Broompa)(Oompa-Oompa Floompa-Floompa)(Oompa-Oompa Oompa-Oompa)(Oompa-Oompa Loompa-Loompa)(Loompa-Loompa Boompa-Boompa)(Loompa-Loompa Zoompa-Zoompa)(WillyWonka WillyWonka)(Loompa-Loompa Doompa-Doompa)(GrandpaJoe CharlieBucket)(Loompa-Loompa Roompa-Roompa)(Loompa-Loompa Vavoompa-Vavoompa)(Loompa-Loompa Broompa-Broompa)(Loompa-Loompa Floompa-Floompa)(Loompa-Loompa Oompa-Oompa)(Loompa-Loompa Loompa-Loompa)))



;BELOW ARE RELATION FUNCTIONS AVAILABLE FOR USE IN THIS LAB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(define (relation? list-of-duples-we-hope)
  (if (null? list-of-duples-we-hope)
      #t
      (if (or (not (list? (car list-of-duples-we-hope)))
              (not (= 2 (length (car list-of-duples-we-hope)))))
          #f
          (relation? (cdr list-of-duples-we-hope)))))

(define (id n)
  (if (= 0 n)
     '()
     (cons (list n n) (id (- n 1)))))


(define (reflexive? relation n)  
  (subset? (id n) relation))

(define (R-minus-1 relation)
  (if (null? relation)
      '()
      (cons (reverse (car relation)) (R-minus-1 (cdr relation)))))

(define (symmetric? relation)
  (subset? (R-minus-1 relation) relation))

(define (symmetric-closure relation) 
  (union relation (R-minus-1 relation)))

(define (related-to element relation)
  (if (null? relation)
      '()
      (if (equal? element (caar relation))
          (cons (cadar relation) (related-to element (cdr relation)))
          (related-to element (cdr relation)))))



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


;(define (complement setA)
;  (set-difference universe setA))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
