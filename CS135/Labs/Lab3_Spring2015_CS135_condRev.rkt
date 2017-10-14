#lang eopl  ;Always remember this line so that DrRacket uses 
;the correct interpreter

; lab3 assignment Spring 2015     
; Tuesday, February 24, 2015

; Objective: Build a working SET data structure implementation.

; Make sure you are using #lang eopl in the first line.

; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat.

;A data structure is a collection of data and operations that
;can be used to manipulate that data.  We will implement operations
;sufficent to make a real working SET data structure.

;PART 0   element?  and make-set
;PART 1   union and intersection
;PART 2   subset? set-equal? propersubset?
;PART 3   set-difference and symmetric-difference
;PART 4   Extras: disjoint? superset? insert-element complement
;GOLDEN TICKET   ????????

;PART 0   element? and make-set

;Sets are very basic structures.

;They consist of "elements" that are either in a specific set or not.
;That is a very Boolean notion.
;Here is a recursive function that takes an "item" and a "list-of-items".
;It returns #t if the item IS an element and #f otherwise.

(define (element? item list-of-items)
  (if (null? list-of-items)                  ;Is our "set" empty?
      #f                                     ;If empty, not an element!
      (if (equal? item (car list-of-items))  ;Is our item first in list?
          #t                                 ;Yes?  Then it's an element!
          (element? item (cdr list-of-items)))));No? Check the rest.

;Note:  We have used the predicate "equal?"  This will allow us to have
;elements which are not necessarily numbers.  If you KNOW your list will
;consist ONLY of numeric data, then "=" will be much faster.  But we are
;going to manipulate non-numeric data later.  We need "equal?"

;This procedure uses a nested if-then-else structure for control flow.  
;The 'if' procedure takes three procedures as arguments; the first must 
;be predicate. The second is the procedure executed when the predicate
;evaluates #t.  The third (last) is the procedure executed when the 
;predicate evaluates #f.  (Else.)  Here, the 'else' is itself another
;'if' statement.  In this way, we can build arbitrarily-deep nested
;lists of 'if's.  Indeed, the second procedure could also be an 'if'.

;The other aspect of sets we need to concern ourselves with is their
;lack of duplication.  We need a routine that will remove duplicates.

;Here is a function that takes a list and removes duplicates in an
;intriguing way.  Rather than keeping the FIRST occurence of an item
;in the list-of-items, it retains the LAST one.  That makes it very
;easy to implement with naive recursion.

;(We'll re-vist this later in the semester when we do tail recursion.
;But for now, this simple implementation will work wonders.)

(define (make-set list-of-items)
  (cond [(null? list-of-items);An empty list can have no duplicates,
         '()]                 ;So just return an empty list.
        [(element? (car list-of-items) (cdr list-of-items))
         (make-set (cdr list-of-items))];We keep only the LAST item
        [else                           ;if there are duplicates
         (cons (car list-of-items) (make-set (cdr list-of-items)))]))
         ;this cons keeps an item ONLY if no more are available in list

;If the element at the head of the list is also deeper down the list,
;just make a set out of the later part.
;Otherwise, keep the head of the list and add it to the set you get from 
;the rest of the list.  By taking the LAST occurrence of every element
;we guarantee ourselves that each element will be in the final list just
;once.

;This procedure uses the 'cond' syntax for control flow in place of the 
;nested ifs from above.  (You've seen it if you've been reading "The 
;Little Schemer".) 'cond' executes only the procedure in the list of 
;pairs which first has a predicate which evaluates #t.  Instead of using 
;two 'if's, you can place the base case first in the list of 
;predicate/procedure pairs.  (And you can put checks for bad input 
;'zeroeth' in the list.)  We'll discuss cond in more detail in the next 
;lab.  In the meantime, think of the 'if' and 'cond' forms as 
;interchangeable, syntactic sugar, and feel free to use whichever 
;construction you find more natural in any given procedure.  Indulge 
;your sweet tooth.



;Give these a try on the following "lists":

;(make-set '(1 2 3))
;(make-set '(1 1 2 3 5 5))
;(make-set '(1 5 2 3 5 1))  Does the order of the output make sense?

;(element? 1 '(1 2 3))
;(element? 5 '(1 1 2 3 5 5))
;(element? 7 '(1 2 3))

;These are our building blocks.  We'll need them in almost every function
;we create today.

;PART 1   union and intersection

;The simplest operatons on sets are union and intersection.

;The union of A and B is all the elements in either A or B.
;Scheme's use of lists makes "union" a snap, a one-liner!

(define (union setA setB)
  ("your definition goes here"))

;Check your work!

;(union '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6) Order doesn't matter here!
;(union '(1 2 3) '(1 2 3)) --> '(1 2 3)  Make sure to remove duplicates!


;The intersection is just as easy to describe--it's all the elements
;of A that are also elements of B.

;But it's a little trickier to implement.
;There are two things to worry about.
;First, if you're doing it recursively (and you're doing it recursively) 
;something has to get smaller with each iteration.  But only one thing.

;Here's an 'if' skeleton.  Substitute a 'cond' construction if you like:

(define (intersection setA setB)
  (if (null? setA) 
      '()
      (if (element? (car setA) setB)
          (cons (car setA) (intersection (cdr setA) setB))
          (intersection (cdr setA) setB))))

;Here we tear setA apart, checking to see whether each element of setA
;is an element of setB.  We keep the common elements with "cons" and
;recursively call (intersection (cdr setA) setB) whether we keep an 
;element or not.

;But there's a problem:

;(intersection '(1 2 3) '(3 4 5))   --> '(3) is correct, but
;(intersection '(1 2 3 3) '(3 4 5)) --> '(3 3) is NOT a set.

;You must repair this aspect of the program.
;HINT:  There are two simple ways to do this.
;First, because of the nature of intersection, it will suffice to 
;make sure the INPUT sets are sets.  Later, we will see that this does
;NOT always work.  (Intersection is benevolent in this regard.)
;Second, you can remove duplicates form the OUTPUT of the function.
;This will always work for us.

;You may re-name the given function, you may define your own helper 
;function, you may (inefficiently) merely add to the existing fucntion.
;For now, fix it however comes to mind.

;Does it work for (intersect '(3 3 4 5) '(3)) ?

;Your TA will check your union & intersection.


;PART 2   subset? set-equal? propersubset?

;We're also interested in comparing sets in several ways.

;We say that A is a subset of B iff every element of A is also an element
;of B.  This predicate will check that...once you supply the missing 
;pieces.

;Here's a 'cond' skeleton.  Substitute an 'if' construction if you like:

(define (subset? setA setB)
  (cond [(null? setA) 
         "a Boolean goes here"]
        [(element? (car setA) setB)
         (subset? (cdr setA)  setB)]
        [else "the other Boolean goes here"]))

;You'll know you have it right when:
;(subset? '(1 2 3) '(5 4 3 2 1)) --> #t
;(subset? '(1 2 3) '(5))         --> #f

;What should you get with these:

;(subset? '(1 2 3 3) '(1 2 3))
;(subset? '() '(1 2 3))
;(subset? '() '())

;If you got the first two up there, these should all return the correct
;answers.

;Furthermore, we say that two subsets are equal iff they contain
;exactly the same elements.

;Another way of putting that is, A and B are equal iff they are subsets 
;of each other.  Using a little logic "and" the function we defined
;above...

(define (set-equal? setA setB)
  ("your one-line definition goes here"))

;Check your work:
;(set-equal? '() '()) --> #t
;(set-equal? '(1 2 3) '(3 2 1)) --> #t
;(set-equal? '(1 1 2 3) '(1 2 3 3)) --> #t

;Note that these last two will return #f if we use just "equal?"
;As lists Scheme sees them as distinct.  We have taught Scheme
;to see them as the same.  We are building a useful (and usable) data
;structure.

;Finally, we are interested (occasionally) in proper subsets.
;Set A is a proper subset of B iff A is a subset of B and A is not
;equal to B.  Again, using a little logic and the functions we've
;just developed...

(define (proper-subset? setA setB)
  ("your one-line definition goes here"))


;(proper-subset? '(1 2) '(1 2 3))   --> #t
;(proper-subset? '(1 2 3) '(1 2 3)) --> #f
;(proper-subset? '() '(1 2 3))      --> #t
;(proper-subset? '() '() )          --> #f

;Your TA will check your set-equal? and proper-subset?


;PART 3   set difference and symmetric difference

;In a crude way, union and intersection are similar to "addition" or 
;"multiplication". They are commutative and associative like addition 
;and multiplication.  The empty set acts like zero.  In a way.

;So it might make sense to think of an analog to "subtraction".  
;We have a couple of them.

;The symmetric difference of A and B, or A - B is all the elements
;of A that are NOT elements of B.

;This is another of those troublesome functions that might yield 
;duplicates in the final list unless we take measures to prevent it.
;We'll frequently have reason to treat the first function call in a 
;recursive sequence differently from all the others.  Sometimes (later
;in the semester) we'll have reason to hide details--like initializing 
;parameters--from our users, and sometimes (today) there will be 
;something we want done LAST, after all the real work is done.
;If we insist that sets are used as arguments, we don't need to bother
;with this; as long as setA really is a set, the output WILL be a set.
;But just to be sure and to allow non-set lists to give us good results, 
;we'll apply "make-set" to the result returned by the real workhorse
;function.  My style is to name the 'launching' function in lower case
;and the subsequent function with an initial upper case letter or 
;letters.       (Your style may vary, but you'll see this idea again.)
;Like this:

(define (set-difference setA setB)
  (make-set (Set-Difference setA setB)))

;Your recursive Set-Difference function should examine all the entries 
;in the list representing setA and keep only those NOT in the list 
;representing setB.

;Hint:  This will look a lot like "intersection" with appropriate 
;modifications.  

(define (Set-Difference setA setB)
  ("your multi-line recursive definition goes here"))

;(set-difference '(1 2 3) '(2 3 4)) --> '(1)
;(set-difference '(1 2 3) '(1 2 3)) --> '()
;(set-difference '(1 2 3) '(4 5 6)) --> '(1 2 3)
;(set-difference '() '(1 2 3))      --> '()
;(set-difference '(1 1 2 3 3) '())  --> '(1 2 3)

;Our other analog of subtraction is the symmetric difference of two sets.
;It is easily computed by combining other things we've already done.

;The symmetric difference of A and B is all the elements which
;are elements of EXACTLY one of the two sets. 

;That is, the elements of the symmetric difference of A and B are
;all those elements that are in A but not in B OR in B but not in A.
;(If you're a computer scientist, feel free to rename the next 
;function "xor".)


(define (sym-diff setA setB)
  ("your one-line definition goes here"))

;(sym-diff '(1 2 3) '(3 4 5)) --> '(1 2 4 5)
;(sym-diff '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)
;(sym-diff '(1 2 3) '(1 2 3)) --> '()
;(sym-diff '(1 2) '(1 2 3 4)) --> '(3 4)


;Your TA will check your sym-diff (or xor), but it won't work if your 
;set-difference doesn't work...so you need to do both!

;PART 4   Extras:  Cardinality, Complement, 
;                  disjoint?, superset?, 
;                  insert element

;A fully formed data structure implementation for sets might contain many
;other functions.  Often these are very simple.  We've seen several so
;far which consisted of one-line definitions.  We're about to see several
;more.

;The cardinality of a set is the number of elements it contains.
;(OK, that's true for finite sets, and all our sets will be finite.)

(define (cardinality set)
  ("your one-line definition goes here"))

;(cardinality '(1 2 3))    --> 3
;(cardinality '(1 1 2 3 3) --> 3
;(cardinality '(1 1 1 1 1) --> 1
;(cardinality '() )        --> 0

;Two sets are said to be "disjoint" if they have no intersection.  
;That is, if their intersection is the empty set.

(define (disjoint? setA setB)
  ("your one-line definition goes here"))

;Set A is called a "superset" of B if every element of B is conatined in 
;set A.  There's another way to think of that...a way we've already done:

(define (superset? setA setB)
  ("your ridiculously simple one-line definition goes here"))

;So far we've only performed creative operation using sets with other
;sets.  Most data structures allow a user to add individual items to
;data structures.

;If we wanted to INSERT an element into a set we could cheat and 
;insist that our user treat the element as a singleton set, like this:

;(union (list element) set))

;That would work perfectly well, but it insists our user think like 
;a programmer rather than as a simple user.

;Write a function that inserts an element by treating it as an element
;rather than as a singleton set.  That is, without using union:

(define (insert element set)
  ("your 1-line def that doesn't use union goes here"))

;(insert 0 '(1 2 3)) --> '(0 1 2 3)  [or '(1 2 3 0) etc.]
;(insert 1 '(1 2 3)) --> '(1 2 3)
;(insert 0 '(0 0 0)) --> '(0)

;And while we're at it...
;If we have a way of inserting new elements, shouldn't we have a 
;procedure to remove them, too?

(define (remove element set)
  ("your definition goes here"))

;(remove 2 '(1 2 3)) --> '(1 3)
;(remove 3 '(3))     --> '()
;(remove 4 '(1 2 3)) --> '(1 2 3)

;NOTE:  We could raise an error here, alertign the user that
;the desired element was absent.  Some languages include 2 remove
;procedures to allow one with & one without a warning.
;We'll keep it simple for now.  Plus, that'll let you use our
;set procedures already developed in a one-liner.


;There's at least one more important operation that we ought to discuss.
;That is the notion of the complement of a set.
;The complement of a set is the set of all things NOT in the set.
;The complement COMPLEtes the set.  In order for this to make sense, we
;need the idea of a universe of elements.  A sort of "everything under
;discussion".  The universe of things will, of course, change with
;context, but the idea of "complement" is just set difference where
;the first (larger) set is the universal set.  Like this:

(define (complement setA)
  (set-difference universe setA))

;Notice that the "universe" is baked in.  Here it's a global variable 
;unbound by our definition.

;I've included a universe for you.  It's the names of all the Broadway
;theaters.  Go ahead--type "universe" in the window below.

;I've also included a great many other data elements for you to tinker
;with.  The Theater District runs from 41st Street up to 54th Street.  ;But there's a theater even farther north, so I've included:
; on40 , on41 , on 42 , ... , on65 .  Go ahead.  Try it.

;Also, these: 

;on7th (theaters on 7th Avenue)
;onBroadway (Broadway theaters actually ON Broadway -- not many!)
;EastOf7th 
;WestOf8th 
;ShubertAlley  (Theaters on Shubert Alley)
;Nederlander   (Theaters owned by the Nederlander organization) 
;Jujamcyn      (Theaters owned by the Jujamcyn organization)
;Shubert       (Theaters owned by the Shubert organization)
;independent   (independently run theaters)
;Disney        (Theaters owned by the Disney corporation)
;Ambassador    (Theaters run by the Ambassador theater group)
;non-profit    (Theaters run by non-profit organizations)
;Roundabout    (Theaters run by the Rounadbout Theater Company)
;LincolnCenter (Theaters run by Lincoln Center Theater)
;MTC           (Theaters run by the Manhattan Theater Company)
;initialB      (Theaters with the first letter B)
;critic        (Theaters named for drama critics)
;producer      (Theaters named for producers)
;playwright    (Theaters named for playwrights)
;composer      (Theaters named for composers)
;actress       (Theaters named for actresses)
;actor         (Theaters named for actors)
;cartoonist    (Yes, there is a theater named for a cartoonist!)
;people        (Theaters named in honor of people)
;notPeople     (Theaters not named in honor of people)

;OK, so now you have a REAL data structure at your disposal.
;It's not just a bunch of functions, but real data, too.
;You can now answer questions like this:

;1.) Which Broadway theaters are named for "critic"s or "playwright"s?
;2.) Which Broadway theaters "on44" are named for "people"
;3.) Which Broadway theaters are between 48th and 50th, inclusive?
;4.) Which Broadway theaters are on45 th BUT NOT WestOf8th?
;5.) How many Broadway theaters are there?
;6.) There's a theater with entrances on45 th AND on46 th.  Which one?
;7.) Which Broadway theaters are not run by Shubert?  
;8.) Who runs more theaters: Shubert, Nederlander, or Jujamcyn?
;9.) What is (intersection actor actress) and what do you think that 
;answer means?  Google wil tell you whether you are correct!


;Your TA will check your answers to a couple questions like those above.
;Make sure your "cardinality" and "disjoint" and 




;GOLDEN TICKET:  The Oompah-Loompahs

;Mondays are busy days in the chocolate factory.
;There are seven rooms up and running:

;chocolate
;fudge
;inventing
;juicing
;marshmallow
;teevee
;taffypulling

;Each room is staffed by a set of Oompah-Loompahs.
;You can type the names of the rooms below to see who was working 
;in each room yesterday.

;Each room has its own boss who works ONLY in that room.
;Use the set functions you developed above to find the Boss for each 
;room!  (You can even develop more here to help avoid all that typing, if
;you like!  Functions that take lists of sets and find 
;unions/intersections for a whole list would be useful.)

;There is one worker who acts as supervisor to the bosses.
;Find the worker who works in EVERY room.

;All the other workers rotate among three different rooms.
;But be careful!  Each time they report to a room, they sign the 
;attendance sheet.  That's why the lists look so long.
;Yesterday, OompahFlupah was out sick.  Ironic!
;What three rooms were understaffed yesterday?

;How many Oompah-Loompahs reported to work yesterday?






(define on40 '())
(define on41 '(Nederlander))
(define on42 '(NewAmsterdam Lyric Selwyn))
(define on43 '(StephenSondheim))
(define on44 '(St.James HelenHayes Majestic Broadhurst Shubert Belasco Minskoff))
(define on45 '(Hirschfeld Golden Jacobs Schoenfeld Booth Lyceum Imperial MusicBox Minskoff Marquis))
(define on46 '(RichardRodgers Lunt-Fontanne Imperial Marquis))
(define on47 '(BrooksAtkinson Palace Barrymore Friedman))
(define on48 '(Longacre WalterKerr Cort))
(define on49 '(O-Neill, Ambassador))
(define on50 '(Gershwin CircleInTheSquare))
(define on51 '(Gershwin))
(define on52 '(NeilSimon AugustWilson))
(define on53 '(Broadway))
(define on54 '(Studio54))
(define on55 '())
(define on56 '())
(define on57 '())
(define on58 '())
(define on59 '())
(define on60 '())
(define on61 '())
(define on62 '())
(define on63 '())
(define on64 '())
(define on65 '(VivianBeaumont))
(define on7th '(WinterGarden Palace))
(define onBroadway '(Marquis Minskoff Broadway Palace WinterGarden))
(define EastOf7th '(Palace Cort Lyceum Belasco Sondheim))
(define WestOf8th '(Hirschfeld))
(define Nederlander '(Nederlander Palace BrooksAtkinson Lunt-Fontanne Gershwin NeilSimon Marquis Minskoff RichardRodgers)) 
(define Jujamcyn '(St.James AugustWilson O-Neill Hirschfeld WalterKerr))
(define Shubert '(WinterGarden Shubert MusicBox Majestic Lyceum Longacre Golden Imperial Schoenfeld Barrymore Cort Jacobs Booth Broadway Broadhurst Belasco Ambassador))
(define independent '(HelenHayes CircleInTheSquare))
(define Disney '(NewAmsterdam))
(define Ambassador '(Lyric))
(define non-profit '(VivianBeaumont Selwyn StephenSondheim Studio54 Friedman))
(define Roundabout '(Selwyn StephenSondheim Studio54))
(define LincolnCenter '(VivianBeaumont))
(define MTC '(Friedman))
(define initialB '(Booth Broadhurst Belasco Broadway Barrymore BrooksAtkinson))
(define critic '(BrooksAtkinson WalterKerr))
(define producer '(Belasco Nederlander Shubert Golden Cort))
(define playwright '(O-Neill NeilSimon AugustWilson Broadhurst))
(define composer '(StephenSondheim Gershwin RichardRodgers))
(define actress '(VivianBeaumont Barrymore Lunt-Fontanne HelenHayes))
(define actor '(Booth Lunt-Fontanne))
(define cartoonist '(Hirschfeld))
(define people '(Nederlander StephenSondheim HelenHayes Shubert Belasco Booth Schoenfeld Jacobs Golden RichardRodgers Cort WalterKerr BrooksAtkinson VivianBeaumont NeilSimon AugustWilson O-Neill Minskoff Selwyn Gershwin Friedman Broadhurst Lunt-Fontanne WalterKerr Barrymore))
(define notPeople '(Palace Lyceum Majestic Lyric St.James WinterGarden Broadway Studio54 Ambassador CircleInTheSquare MusicBox Imperial Longacre NewAmsterdam Marquis)) 
(define ShubertAlley '(Shubert Booth))
(define universe (append people notPeople))


(define chocolate '(OompahBluempah OompahBaboonpah OopmahBalloonpah OopmahBoonpah OompahBuffoonpah OompahBroompah OompahFlewmpah OompahFumpah OompahKaboompah OompahCrewmpah OompahGoonpah OompahIgloompah OompahStewnpah OompahMaroonpah OompahZoompah OompahNoonpah OompahSaloonpah OompahRangoonpah Bob OompahBluempah OompahBaboonpah OopmahBalloonpah OopmahBoonpah OompahBuffoonpah OompahBroompah OompahFlewmpah OompahFumpah OompahKaboompah OompahCrewmpah OompahGoonpah OompahIgloompah OompahStewnpah OompahMaroonpah OompahZoompah OompahNoonpah OompahSaloonpah OompahRangoonpah GranfallOompah OompahBluempah OompahBaboonpah OopmahBalloonpah OopmahBoonpah OompahBuffoonpah OompahBroompah OompahFlewmpah OompahFumpah OompahKaboompah OompahCrewmpah OompahGoonpah OompahIgloompah OompahStewnpah OompahMaroonpah OompahZoompah OompahNoonpah OompahSaloonpah OompahRangoonpah)) 

(define fudge '(OompahFluempah OompahFlewmpah OompahFloompah OompahFoompah OompahFumpah OompahBluempah OopmahBoonpah OompahCroonpah OompahCrewmpah OompahGruempah OompahGrewmpah OompahSpoonpah OompahMonsoonpah OompahMoonpah OompahTunepah OompahSaloonpah OompahPontoonpah Fob OompahFluempah OompahFlewmpah OompahFloompah OompahFoompah OompahFumpah OompahBluempah OopmahBoonpah OompahCroonpah OompahCrewmpah OompahGruempah OompahGrewmpah OompahSpoonpah OompahMonsoonpah OompahMoonpah OompahTunepah OompahSaloonpah OompahPontoonpah GranfallOompah OompahFluempah OompahFlewmpah OompahFloompah OompahFoompah OompahFumpah OompahBluempah OopmahBoonpah OompahCroonpah OompahCrewmpah OompahGruempah OompahGrewmpah OompahSpoonpah OompahMonsoonpah OompahMoonpah OompahTunepah OompahSaloonpah OompahPontoonpah))

(define inventing '(OompahKazoompah OompahCroonpah OompahCukoompah OompahKaboompah OompahCrewmpah OompahBluempah OompahBaboonpah OompahFloompah OompahGloompah OompahGrewmpah OompahMaroonpah OompahMacaroonpah OompahNoonpah OompahLoonpah OompahRacoonpah OompahBarroompah Hobnob OompahCluempah OompahKazoompah OompahCroonpah OompahCukoompah OompahKaboompah OompahCrewmpah OompahBluempah OompahBaboonpah OompahFloompah OompahGloompah OompahGrewmpah OompahMaroonpah OompahMacaroonpah OompahNoonpah OompahLoonpah OompahRacoonpah OompahBarroompah GranfallOompah OompahCluempah OompahKazoompah OompahCroonpah OompahCukoompah OompahKaboompah OompahCrewmpah OompahBluempah OompahBaboonpah OompahFloompah OompahGloompah OompahGrewmpah OompahMaroonpah OompahMacaroonpah OompahNoonpah OompahLoonpah OompahRacoonpah OompahBarroompah))

(define juicing '(OompahIgloompah OompahGruempah OompahGrewmpah OopmahBalloonpah OompahBuffoonpah OompahFluempah OompahCluempah OompahCukoompah OompahStewnpah OompahMacaroonpah OompahTunepah OompahPrunepah OompahPontoonpah OompahRangoonpah Slob OompahGluempah OompahGoonpah OompahGloompah OompahIgloompah OompahGruempah OompahGrewmpah OopmahBalloonpah OompahBuffoonpah OompahFluempah OompahCluempah OompahCukoompah OompahStewnpah OompahMacaroonpah OompahTunepah OompahPrunepah OompahPontoonpah OompahRangoonpah GranfallOompah OompahGluempah OompahGoonpah OompahGloompah OompahIgloompah OompahGruempah OompahGrewmpah OopmahBalloonpah OompahBuffoonpah OompahFluempah OompahCluempah OompahCukoompah OompahStewnpah OompahMacaroonpah OompahTunepah OompahPrunepah OompahPontoonpah OompahRangoonpah))

(define marshmallow '(OompahStewnpah OompahMonsoonpah OompahMaroonpah OompahMacaroonpah OompahBaboonpah OopmahBoonpah OompahFlewmpah OompahFoompah OompahCluempah OompahKazoompah OompahGluempah OompahIgloompah OompahMoonpah OompahPrunepah OompahBarroompah OompahBrigadoonpah Kabob OompahSoonpah OompahSpoonpah OompahStewnpah OompahMonsoonpah OompahMaroonpah OompahMacaroonpah OompahBaboonpah OopmahBoonpah OompahFlewmpah OompahFoompah OompahCluempah OompahKazoompah OompahGluempah OompahIgloompah OompahMoonpah OompahPrunepah OompahBarroompah OompahBrigadoonpah GranfallOompah OompahSoonpah OompahSpoonpah OompahStewnpah OompahMonsoonpah OompahMaroonpah OompahMacaroonpah OompahBaboonpah OopmahBoonpah OompahFlewmpah OompahFoompah OompahCluempah OompahKazoompah OompahGluempah OompahIgloompah OompahMoonpah OompahPrunepah OompahBarroompah OompahBrigadoonpah))

(define teevee '(OompahZoompah OompahNoonpah OompahMoonpah OompahLoonpah OompahTunepah OompahPrunepah OompahBuffoonpah OompahFluempah OompahFloompah OompahCroonpah OompahKaboompah OompahGluempah OompahGoonpah OompahSoonpah OompahMonsoonpah OompahRacoonpah OompahBrigadoonpah Nabob OompahZoompah OompahNoonpah OompahMoonpah OompahLoonpah OompahTunepah OompahPrunepah OompahBuffoonpah OompahBroompah OompahFluempah OompahFloompah OompahCroonpah OompahKaboompah OompahGluempah OompahGoonpah OompahSoonpah OompahMonsoonpah OompahRacoonpah OompahBrigadoonpah GranfallOompah OompahZoompah OompahNoonpah OompahMoonpah OompahLoonpah OompahTunepah OompahPrunepah OompahBuffoonpah OompahBroompah OompahFluempah OompahFloompah OompahCroonpah OompahKaboompah OompahGluempah OompahGoonpah OompahSoonpah OompahMonsoonpah OompahRacoonpah OompahBrigadoonpah))

(define taffypulling '(OompahSaloonpah OompahPontoonpah OompahRacoonpah OompahRangoonpah OompahBarroompah OompahBrigadoonpah OopmahBalloonpah OompahBroompah OompahFoompah OompahFumpah OompahKazoompah OompahCukoompah OompahGloompah OompahGruempah OompahSoonpah OompahSpoonpah OompahZoompah OompahLoonpah Gob OompahSaloonpah OompahPontoonpah OompahRacoonpah OompahRangoonpah OompahBarroompah OompahGruempah OompahSoonpah OompahSpoonpah OompahZoompah OompahLoonpah GranfallOompah OompahSaloonpah OompahPontoonpah OompahRacoonpah OompahRangoonpah OompahBarroompah OompahBrigadoonpah OopmahBalloonpah OompahBroompah OompahFoompah OompahFumpah OompahKazoompah OompahCukoompah OompahGloompah OompahGruempah OompahSoonpah OompahSpoonpah OompahZoompah OompahLoonpah))

                         


;February 2015
;Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))

