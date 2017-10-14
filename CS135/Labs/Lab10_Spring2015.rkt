#lang eopl ;Always remember this line so that DrRacket uses 
;the correct interpreter

; Lab10 assignment Spring 2015     
; Tuesday, April 21, 2015

; Objective:  Perform a topolgical sort on a Hasse diagram 
; representation of a partial order.
; (Recursion practice with lists, of course.)

; Make sure you are using #lang eopl in the first line.
; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat

;Part 0:  A Partial Ordering, Hasse/Duple-Style  (Warm Up)
;Part 1:  Minimal Elements
;Part 2:  Rinse
;Part 3:  Toplogical Sort
;Part 4:  Maximal Elements
;GOLDEN TICKET ????????????????????


;PART 0:  A Partial Ordering, Hasse/Duple-Style  (Warm Up)

;We're going to implement a topological sort of a partial order 
;represented by the edges (lines) in a Hasse diagram.  Here is such a 
;representation for the partial order "divides" on the divisors of 72: 

(define Hasse72 '((6 12) (6 18) (9 18) (8 24) (12 24) (12 36) (18 36) (24 72) (36 72) (1 2) (1 3) (2 4) (2 6) (3 6) (3 9) (4 8) (4 12)))

;And its reverse: 
(define RevHasse72 (reverse Hasse72))

;(topological-sort Hasse72) -> (1 2 3 6 9 18 4 8 12 24 36 72)

;NOTE: Hasse72 is a list of duples, so we can view it as a relation, 
;but understand that we stripped out the reflexive edges (loops) 
;as well as any edges that can be inferred from transitivity.  Even 
;though it doesn't LOOK like a partial ordering, we know it represents 
;one--we need only the essential skeleton--the Hasse lines. 
;(Technically, it's a DAG: a Directed, Acyclic Graph.  You'll see them 
;again in CS385, or perhaps you've seen them already in CS182.)

;Just so we're clear:  The lists of duples we used last week WERE 
;equivalence relations.  All the duples/edges were there, but this week 
;we are NOT using an actual partial order.  We're stripping out all the 
;reflexive edges and all the redundant (for our purposes) edges that 
;make it transitive.  We are looking at just those edges that would 
;appear in a Hasse diagram of the partial order.

;So, in a way, rather than a data structure, we have structured data.  

;Your overall task: Write a program 'topological-sort' (and whatever 
;helper functions you might need) to create a list of the elements of 
;the underlying set (divisors of 72) which preserves the partial order.  
;That is, if a divides b, a appears to the left of b in the list.

;Of course, this ordering is not unique: (1 3 2 6 4 9 18 12 8 36 24 72) 
;is an equally acceptable result.  Why?

;Here's what I get when I run my code:  
;(top-sort Hasse72)->(1 2 3 6 9 18 4 8 12 24 36 72)
;(top-sort RevHasse72)->(1 3 2 4 8 9 6 18 12 36 24 72)


;And for testing purposes, here's a HasseDupleList of the letter X:
;(Hasse72 has just 1 minimal element and just one maximal element.  You
;might write could that finds those but misses the others, so this one 
;has 2 of each.  Draw the Hasse diagram, and you'll see it's an 'X'.

(define HasseX '((LowerLeft Middle) (Middle UpperRight) (LowerRight Middle) (Middle UpperLeft)))


;One last reminder:

;((caar cadar)(caadr cadadr)(more-stuf back-here)(duple-me duple-you)...)

;PART 1:  Minimal Elements
;
;Write a procedure "minimal-elements" that creates a list of all the 
;elements that appear as a first element of a duple in a list BUT never
;as a second element of a duple in a list.  (Remember, the reflexive 
;edges are being left out...for now.)

(define (minimal-elements HasseDuples)
  "Your definition goes here")

;(minimal-elements Hasse72) --> (1)
;(minimal-elements HasseX)  --> (LowerLeft LowerRight)

;You have complete freedom to do this as you please.
;You can check each "car/caar" to see whether it is ever a "cadr/cadar", 
;or you can make a list of all the first entries and a list of all the
;second entries and finally do a set-difference.
;Of course, all our set functions are available at the end of this lab.

(define (helpers arg1 arg2 arg-or-naut)
  "Your helper functions might or might not go here--mine did!")


;Your TA will test your "minimal-elements".


;PART 2:  Rinse

;As we do the topological sort, we will choose a minimal element (how?!?)
;and then we will need to remove all the edges from the Hasse diagram
;coming from that minimal element. 

;It's a classic keep & chuck recursion--we did one last week.
;HINT:  Use "equal?" rather than "=" so you can apply it to HasseX.

;Write "rinse" to remove all the edges emanating from a minimal element:

;HINT:  You will supply a minimal element (from your list of 
;minimal-elements). The function just has to chuck anything that starts
;with what you give it--it's not checking min-element status.  

(define (rinse min-element HasseDuples)
  "Your definition goes here")

;(rinse 1 Hasse72) --> ((6 12)(6 18)(9 18)(8 24)(12 24)(12 36)(18 36)(24 72)(36 72)(2 4)(2 6)(3 6)(3 9)(4 8)(4 12))

;(rinse 'LowerRight HasseX) --> ((LowerLeft Middle) (Middle UpperRight) (Middle UpperLeft))
                                     
;Your TA will test your "rinse"


;PART 3:  Topological Sort

;Now all you have to do is put them together in "topological-sort":
;Find a minimal element, add it to your growing output list, and 
;recur on the HasseDuples with that minimal element rinsed out.

;Write "topological-sort" to identify minimal elements, rinse, and 
;repeat.  (There's a hidden hiccup in here, but we'll fix it in PART 4.)
;Do you see what's wrong, what we're missing?

(define (topological-sort HasseDuples)
  "Your definition goes here")

;(topological-sort Hasse72)    --> (1 2 3 6 9 18 4 8 12 24 36)
;(topological-sort RevHasse72) --> (1 3 2 4 8 9 6 18 12 36 24)
;(topological-sort HasseX) --> (LowerLeft LowerRight Middle)

;Well, that's MOSTLY ok.  Just missing a little off the topo!

;Your TA will test your "topological-sort"


;PART 4:  Maximal-Elements

;We're almost home!  Everything works, except that the maximal elements
;all get rinsed out before they can become part of our sorted list.

;In our process, the maximal elements never change--anything that is a 
;maximal element at the start remains a maximal element until it is
;accidentally rinsed out.  So write "maximal elements" just as you
;did for "minimal-elements" in PART 1.

(define (maximal-elements HasseDuples)
  "Your definition goes here")

;So, "topological-sort" gives you one piece, and "maximal-elements" gets 
;you the other piece you need. So just write "topo-sort" to put the 
;pieces together correctly.

(define (topo-sort HasseDuples)
  "Your definition goes here")

;(topo-sort Hasse72)    --> (1 2 3 6 9 18 4 8 12 24 36 72)
;(topo-sort RevHasse72) --> (1 3 2 4 8 9 6 18 12 36 24 72)
;(topo-sort HasseX)--> (LowerLeft LowerRight Middle UpperRight UpperLeft)

;Your TA will test your "maximal-elements" and "topo-sort".


;(optional-just for fun) PART 53rd Street:    The Late Show

;May 20, 2015 will be the final original broadcast of "The Late Show 
;with David Letterman".  That's right.  After more than 33 years on 
;television he's hanging up the microphone.  You may not know that 
;April 12 is his birthday.  We JUST missed it this year. Really.  So to 
;honor everyone's favorite gap-toothed late night talkshow host....

;Here is a HassePoset representing the things that go into an 
;episode of the LateShow with David Letterman.
;OK, sure, it's a little over-full, but we're having fun with our new 
;programs.

(define LateShow '((WriteJokes Rehearsal) (TuneInstruments Rehearsal) (SetStage Rehearsal) (Rehearsal AudienceLoadIn) (AudienceLoadIn WarmUpComicEddieBrill) (WarmUpComicEddieBrill IntroduceCBSorchestra) (IntroduceCBSorchestra DaveQ&AwithAudience) (DaveQ&AwithAudience AlanKalterOpeningIntro) (AlanKalterOpeningIntro Monologue) (Monologue TalkToPaulShaffer) (TalkToPaulShaffer FirstGuest) (TalkToPaulShaffer TopTenList) (TopTenList JibPanOfAudience) (FirstGuest WillItFloat?) (WillItFloat? JibPanOfAudience) (TalkToPaulShaffer 53rdStreetHijinx) (53rdStreetHijinx FirstGuest)(TalkToPaulShaffer StaffComedySkit) (StaffComedySkit BandOrComic) (RollCredits DaveThanksGuestsPersonally)(DaveAdLibsAboutShecky RollCredits)(AlanKalterOpeningIntro DaveAdLibsAboutShecky)(FirstGuest IsThisAnything?)(IsThisAnything? JibPanOfAudience)(FirstGuest SecondGuest) (SecondGuest BandOrComic)(FirstGuest JibPanOfAudience) (JibPanOfAudience BandOrComic)(BandOrComic RollCredits) (RollCredits AudienceLoadOut)(TalkToPaulShaffer TapedBitWithBiffHenderson)(TapedBitWithBiffHenderson JibPanOfAudience)));



;Do a (topo-sort LateShow) to get a sample sorting of the running order 
;of a show.  Then do it with (top-sort (reverse LateShow)) and see all 
;the differences in the total ordering!

;And this one has more than one maximal element, so if you top-sort it 
;and the top-sort the reverse of it, you'll probably get two different 
;things to be the VERY last element.

;And points-off if you're a Leno fan, or one of the Jimmies.
;But Team Coco is welcome.

;Happy birthday, Dave!  And thanks for the memories!  Or is that 
;somebody else?


;GOLDEN TICKET    The Fashionable Willy Wonka

;Mr. Willy Wonka is quite a dandy.  He believes that fashionable is as
;fashionable does, and to that end, when he welcomes guests to his 
;factory, he puts on his shoes before his spats, his waistcoat before 
;his ascot, his bottle green trousers before his suspenders, his ruffled 
;shirt before his waistcoat, his ascot before his ... well... take a 
;look:

(define Wonka '((PlumVelvetTailCoat Gold-TippedWalkingCane)(Boxers Undershirt)(Socks PatentLeatherShoes)(PatentLeatherShoes Spats)(Spats Gold-TippedWalkingCane)(Spats Waistcoat)(Boxers BottleGreenTrousers)(Boxers Socks)(PearlGrayGloves PearlGrayGloves)(BottleGreenTrousers Suspenders)(Suspenders PlumVelvetTailCoat)(Undershirt Ruffles)(PlumVelvetTailCoat ChocolateTopHat)(PlumVelvetTailCoat PaisleyPocketSquare)(Waistcoat PlatinumPocketWatch)(Ascot PlumVelvetTailCoat)(BottleGreenTrousers PatentLeatherShoes) (Ruffles SterlingSilverCufflinks)(Ruffles Suspenders)(Ruffles Waistcoat)(SterlingSilverCufflinks PlumVelvetTailCoat)(TortoiseShellEyeGlasses TortoiseShellEyeGlasses)(Waistcoat Ascot)))

;Your job is to create a  couple of total orderings of the 18 items Mr. 
;Wonka wears (or carries) that is compatible with the partial order 
;(Hasse-style) depicted here.

;A word of warning, though: There are a couple of items that are BOTH
;minimal AND maximal elements.  That's a wrinkle we didn't encounter
;earlier, and it's the ONLY wrinkle associated with Willy Wonka's 
;haberdashery

;You have to figure out how to handle stand-alone items like 
;(wristwatch wristwatch).  You can assume that anything like that is
;disconnected from everything else.

;(define (top-sort HasseDuples)
;  ("Your definition goes here"))

;(top-sort Wonka)           --> ????????
;(top-sort (reverse Wonka)) --> ????????

(define (top-sort HasseDuples)
  "Your definition goes here")

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


(define DapperDan '((tie jacket) (pants belt) (pants shoes) (boxers shoes) (boxers pants) (socks shoes) (shirt tie) (shirt belt) (belt jacket) (watch watch)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
