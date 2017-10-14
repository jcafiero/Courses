#lang eopl ;Always remember this line so that DrRacket uses 
;the correct interpreter

; Lab8 assignment Spring 2015     
; Tuesday, April 7, 2015

; Objective: Explore some more Scheme and do some of the things from 
; lecture in Scheme:
; Relations (as ordered pairs / subsets of a Cartesian product)
; Properties of Relations, and 
; Closures of Relations

; Make sure you are using #lang eopl in the first line.
; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat

;Part 0:  Relations and Ordered Pairs Revisited  (Warm Up)
;Part 1:  Reflexivity
;Part 2:  Symmetry
;Part 3:  Anti-Symmetry
;Part 4:  Composition of Relations
;GOLDEN TICKET ????????????????????


;PART 0:  Relations and Ordered Pairs Revisited  (Warm Up)

;Let's start by creating some ordered pairs: 
(define sample '((old new) (borrowed blue) (thing1 thing2) (oneFish twoFish) (redFish blueFish)))
;That's what a relation will look like: a list of pairs.  Now, in 
;Scheme, pair? asks whether something is a non-empty list, something 
;with a car and a (possibly empty) cdr.  So we want to be more specific 
;when WE say "pairs".  For us, we want our relations to be nested lists 
;of lists of length 2, duples.  (By default, the empty list will be the 
;empty relation; it simply consists of zero lists of length 2.) 
;
;So "sample" is a silly toy.  Let's invent some more serious relations.
;
;Here's a relation with authors as domain and fictional characters 
;(created by them) as codomain:
(define author-character '((Doyle Holmes) (Poe Dupin) (Dickens Dodger) (Shakespeare Macbeth) (Shakespeare Lear) (Shakespeare Hamlet) (Twain Finn) (Hugo Valjean) (Shakespeare Romeo) (Shakespeare Juliet) (Tolstoy Karenina) (Dumas Athos) (Dumas Porthos) (Dahl WillyWonka) (Dumas Aramis) (Melville Ahab) (Stevenson Silver) (Christie Marple) (Christie Poirot) (Carroll Alice)))

;Here's a relation with fictional characters as domain and attributes 
;of those characters as codomain:
(define character-attributes '((Holmes detective) (Dupin detective) (Macbeth villain) (Lear king) (Hamlet prince) (Dodger rascal) (Finn rascal) (CharlieBucket GoodBoy) (WillyWonka Chocolatier) (valJean hero) (Romeo lover) (Juliet lover) (Macbeth king) (Karenina lover) (Athos musketeer) (Porthos musketeer) (Aramis musketeer) (Ahab captain) (Ahab whaler) (Silver pirate) (Marple detective) (Poirot detective) (Alice dreamer)))

;Most of what we'll do will center on relations on a set.  Here are four 
;such relations on ;U={1,2,3,4,5,6}.                                                    
(define cycle6 '((1 2) (2 3) (3 4) (4 5) (5 6) (6 1)))
(define david '((1 3) (3 1) (2 4) (4 2) (3 5) (5 3) (4 6) (6 4) (5 1) (1 5) (6 2) (2 6)))
(define study '((1 6) (2 2) (2 3) (3 1) (4 1) (5 1) (5 6) (6 5)))
(define test '((1 2) (2 3) (2 1) (3 3) (4 5) (5 2)))

;And something NOT a relation:
(define not-relation '((1 2 3) (1 2) (4 5) 6))
(define U '(1 2 3 4 5 6))

;Write a predicate "relation?" which takes a list as an argument and 
;returns #t iff the input is a list (possibly empty) of 2-element lists.

;[Feel free to write a predicate (duple? input) which return #t iff its
;input argument is a list of length 2.  That might make your "relation?"
;code look cleaner.]

(define (relation? list-of-duples-we-hope)
  "your definition goes here")

;You can test that on each of our defined relations separately, or you 
;can use:

;(define test-relations (and (relation? sample)
;                            (relation? author-character)
;                            (relation? character-attributes)
;                            (relation? cycle6)
;                            (relation? david)
;                            (relation? test)
;                            (relation? study)))
;[Knock out those semicolons to define test-relations after you've 
;written (relation? list-of-duples).  It should have value #t.]

;Throughout today's lab you'll be dealing with relations expressed as
;lists of duples.  Don't forget that we have syntactic sugar available:
;realtion = ((caar cadar)(caadr cadadr)(a b)(c d)(e f)...) when you want
;to read pieces of a structured list.

;Throughout today's lab you'll be dealing with relations which ARE sets.
;I've included all the set operations we've done this semester for your
;use, including:  element?, make-set, union, intersection, subset?, 
;set-equal?, and more.  The whole point of building them is to use them
;where appropriate.  Use them today where appropriate.

;NOTE:  Our operations work on sets of lists, which is what we want for 
;our work with realtions:

;(set-equal? '(1 2) '(2 1)) --> #t     (sets of atoms)
;(set-equal? '((1 2)) '((2 1))) --> #f  (ordered pairs NOT equal)
;(set-equal? '((1 2)(3 4)) '((3 4)(1 2))) --> #t


;PART 1:  Reflexivity

;Reflexive relations on a set contain all ordered pairs of the form 
;(a a) for all the elements of the set on which they are defined.
;
;So reflexive relations on a set with 6 elements will have the  
;set delta6 = {(1 1),(2 2),(3 3),(4 4),(5 5),(6 6)} as a subset.

(define delta6 '((1 1) (2 2) (3 3) (4 4) (5 5) (6 6)))

;We called that set 'delta6' for the identity relation on a six-element 
;set because Rosen calls it that referring to the main 'diagonal' 
;of the matrix representation of the relation.  

;We haven't emphasized the matrix representations very much, so let's 
;instead call it "id" for identity.

;Write a recursive (id n) that creates the identity relation on a set of 
;n elements. Don't forget the 'list' function that puts its arguments into a list for you. You can use that here.

(define (id n)
    "your definition goes here")

;(id 6) --> ((6 6) (5 5) (4 4) (3 3) (2 2) (1 1))
;(id 1) --> ((1 1))
;(id 0) --> ()

;Check that this (id 6) is a relation with (relation? (id 6)).
;(relation? (id 6)) --> #t

;Now relation (id 6) should be equal to relation (delta 6), as sets.  
;I've included the procedures from our set data structure for you, so
;test:
;(set-equal? (id 6) delta6) --> #t

;So far so good.

;Now, a relation R on a set of size n is reflexive, if it contains (a a) 
;for each a <= n, that is, if (id n) is a subset of R
;
;So write a routine that checks a relation on {1,2,...,n} for 
;reflexivity:  (HINT:  It's a one-liner.)
;
(define (reflexive? relation n)  
    "your definition goes here")

;None of our relations is actually reflexive, so no matter which you 
;use to test, it should return #f.
;But (reflexive? (id 6) 6) and (reflexive? delta6 6) should return #t

;Finally for this section, let's compute the reflexive-closure for a 
;relation on a set of size n.

;The "closure" of a relation regarding some property, is the smallest 
;realtion that HAS the property AND contains (as a subset) the relation 
;we are trying to "close".

;So, first, a reflexive relation is its own reflexive closure.  That 
;is, it is the smallest reflexive relation (set) that contains itself as 
;a subset.

;Reflexive closures are ALWAYS easy to "compute".  You simply take 
;the union of your relation with the appropriate identity 
;relation.
;
(define (reflexive-closure relation n)  ;Where n is the cardinality of 
;the set on which the relation is defined.
    "your definition goes here")

;Your TA will check your "reflexive?" and "reflexive-closure" procedures.
;(You'll need a working (id n) for that, too, probably.)

;If you'd like an additional challenge:
;A relation is "irreflexive" iff it contains NO duples of the form (a a),
;that is, if NOTHING in the set is related to itself.
;Write a predicate "irreflexive?" which checks for this condition:
(define (irreflexive? relation)
    "your definition goes here")

;(irreflexive? cycle6) --> #t
;(irreflexive? delta6) --> #f
;(irreflexive? test)   --> #f

;Must a relation be either reflexive or irreflexive?  Can a relation be 
;neither?


;PART 2:  Symmetry

;We want a predicate 'symmetric?' and a procedure for symmetric closure 
;just as we did for the reflexive property.

;Let's attack the problems in a clever way.  We know that a relation R is
;symmetric if it is equal to R^(-1), the inverse relation of R where all 
;the duples are reversed, and we know the symmetric closure of R can be 
;formed easily by taking: R U R^(-1).

;So we need that R^(-1) to make both a snap.  Write (R-minus-1 relation)
;to reverse all the ordered pairs in a relation:
;[I'm calling it R-minus-1 to match Rosen's notation, but you can call it
;(inverse relation) if you like.]

(define (R-minus-1 relation)
    "your definition goes here")

;(R-minus-1 cycle6) --> ((2 1) (3 2) (4 3) (5 4) (6 5) (1 6))
;(R-minus-1 (id 6)) -->((6 6) (5 5) (4 4) (3 3) (2 2) (1 1))
;(R-minus-1 test)   -->((2 1) (3 2) (1 2) (3 3) (5 4) (2 5))
;
;BANG!
;
;So now (symmetric? relation) is just a subset? call.  Or something.
;
(define (symmetric? relation)
    "your definition goes here")
;
;ZOOM!
;
;And now the symmetric closure just involved including any missing 
;backward edges.  [The symmetric closure of R is the smallest symmetric 
;relation that contains R (as a subset).  If the R is already symmetric, 
;its symmetric closure is itself.  If it is not symmetric, that means 
;there are some duples (a b) in the relation where (b a) is no tin the 
;relation.  We just need to add them.]  You can walk down the list, 
;carefully, or you can notice how the inverse and a symmetric closure 
;are "related" and just dump in the reverse edges with a set operation:

(define (symmetric-closure relation) 
   "your definition goes here")
;
;DONE!
;
;(symmetric-closure cycle6) --> ((1 2) (2 3) (3 4) (4 5) (5 6) (6 1) (2 1) (3 2) (4 3) (5 4) (6 5) (1 6))

;(symmetric? (symmetric-closure cycle6)) -> #t
;The symmetric closure of any of our relations must be symmetric.
;
;
;One last question:  Is it true that relation R is symmetric iff R = 
;R^-1.  That is, could we have used set=? instead of subset?  ?

;Your TA will test your "symmetric?" and "symmetric-closure" procedures.


;PART 3:  Anti-Symmetry

;A relation is antisymmetric if (a b) and (b a) both in R implies a=b.
;
;So we need (antisymmetric? relation) which tests this property.
;It should return false iff an (a b) / (b a) pair is present with 
;a and b not equal.  

;Write (antisymmetric? relation)

(define (antisymmetric? relation)
    "your definition goes here")

;(antisymmetric? cycle6) --> #t
;(antisymmetric? (id 5)  --> #t
;(antisymmetric? test)   --> #f
;
;It doesn't make sense to talk about an antisymmetric closure.
;Unlike the reflexive, symmetric, and transitive relations, adding 
;duples to a relation can cause the relation to LOSE the desired 
;property rather than acquire it.  

;So, since we have an opening for another procedure...
;Let's create a list of things that something is related to in a 
;relation:

(define (related-to element relation)
   "your definition goes here")
              
;(related-to 1 (id 6)   --> (1)    [Why?]
;(related-to 1 david)   --> (3 5)  [Accidentally list of length 2.]  
;(related-to 'Shakespeare author-character) -> (Macbeth Lear Hamlet Romeo Juliet)
;
;
;PART 4:  Composition of Relations

;Transitivity, the next (and final) property of relations we have looked 
;at, is quite a handful.  We'll dedicate a significant part of next 
;week's lab to "transitive?" and "transitive-closure".  In fact, we 
;might do them in the reverse order.  Why?  

;However, since transitive depends fundamentally on the concept of 
;the composite of two relations, let's finish this week by writing
;a procedure to compute the composite of two relations R and S:

(define (composite relationOuter relationInner)
  "your definition goes here")

;(composite cycle6 cycle6) --> ((1 3) (2 4) (3 5) (4 6) (5 1) (6 2))
;(composite (id 6) (id 6)) --> ((6 6) (5 5) (4 4) (3 3) (2 2) (1 1))
;(composite test test) --> 
;                       ((1 3) (1 1) (2 3) (2 2) (3 3) (4 2) (5 3) (5 1))
;(composite test cycle6)   --> ((1 3) (1 1) (2 3) (3 5) (4 2) (6 2))
;(composite cycle6 test)   --> ((1 3) (2 4) (2 2) (3 4) (4 6) (5 3))
;
;NOTE:  test o cycle6   NOTequal   cycle6 o test
;     
;
;Your TA will test your composite procedure.
;(Is/are your procedure(s) tail recursive?  Not necessary, but can you 
;tell?)
;
;
;If you want a little help here...read on:
;
;We want to put together a relation of things that look like (a b)
;where there is an (a x) in relationInner and an (x b) in relationOuter.
;
;So we need to take every element of relationInner and check it against
;every element of relationOuter to see whether there is a match.
;
;This is the equivalent of nested loops.  The problem is that after one
;pass through relationInner, you will have destroyed your relationOuter.
;
;If you want to do this with a single procedure, you'll need to pass a 
;pristine copy of relationOuter with every call, so you'll need a
;launcher with THREE parameters.
;
;Otherwise, you can use a pair of procedures.  The first will recur on
;(cdr relationInner) always passing relationOuter intact.  And somewhere
;in there, it will call a procedure with (car relationInner) and 
;relationOuter that will recur on (cdr realtionOuter) comparing the first
;ordered pair of Inner to every ordered pair in Outer.


;GOLDEN TICKET    The (Antisymmetric) Chocolate Factory

;"Oh, you can't get out backwards. You've got to go forwards to go back, 
;better press on." --Willy Wonka

;The Chocolate Factory is antisymmetric--all the doors are one-way. The
;doors we saw last week open INTO the ChocolateRoom from the Caca0Room 
;and the C0c0aRoom, and nothing goes through them the other way.

;The layout of Chocolate Factory consists of 37 doors connecting 19 
;rooms.  See for yourself:

(define chocolateFactory '((Lobby ChocolateRoom)(Lobby BoilerRoom)(ChocolateRoom Tunnel)(Tunnel StoreRoom)(Tunnel InventingRoom)(Wonka-Office Lobby) (C0c0aRoom ChocolateRoom )(Caca0Room ChocolateRoom)(ChocolateRoom FudgeRoom)(FudgeRoom StoreRoom)(StoreRoom FizzyLiftingDrinkRoom)(ChocolateRoom ControlRoom)(BoilerRoom ChocolateRoom)(GoldenEggRoom FurnaceRoom)(FizzyLiftingDrinkRoom JuicingRoom)(FizzyLiftingDrinkRoom NutRoom)(FizzyLiftingDrinkRoom GoldenEggRoom)(MarshmallowRoom Wonka-Office)(BoilerRoom Wonka-Office)(GoldenEggRoom MarshmallowRoom)(NutRoom Wonka-Office)(GoldenEggRoom Wonka-Office)(InventingRoom Wonka-Office)(ControlRoom Caca0Room) (ControlRoom C0c0aRoom)(BoilerRoom ControlRoom)(MarshmallowRoom FurnaceRoom)(BoilerRoom InventingRoom)(TaffyPullingRoom FurnaceRoom) (GoldenEggRoom WonkaVisionRoom)(NutRoom WonkaVisionRoom)(WonkaVisionRoom FurnaceRoom)(WonkaVisionRoom TaffyPullingRoom)(JuicingRoom FurnaceRoom)(JuicingRoom Lobby)(TaffyPullingRoom Lobby)(BoilerRoom FizzyLiftingDrinkRoom))) 

;You would think the entire Chocolate Factory would smell like heavenly 
;chocolate, but something strange happens.  The only rooms where the 
;aroma can be detected are the those which are three doors downwind from
;the waterfall in the ChocolateRoom.  Can you determine in which three 
;rooms the glorious scent of chocolate can be enjoyed?

;HINT:  You need nothing more than what you've already done today.  You 
;must simply put them all together correctly.


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


(define (complement setA)
  (set-difference universe setA))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
