#lang eopl ;Always remember this line so that DrRacket uses 
;the correct interpreter

; Lab4 assignment Spring 2015     
; Tuesday, March 3, 2015

; Objective: Explore some more Scheme and do some of the things from 
; lecture in Scheme.

; Make sure you are using #lang eopl in the first line.

; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat

;PART 1:    map   / pig-latin revisited
;PART 2:    cond  / The Taxman comes and he gets a workout
;PART 3:    apply / Arithmetic and Geometric Progressions
;PART 4:    Cartesian Product
;GOLDEN TICKET ????????????????????


;PART 1:  map / pig-latin revisited

;Let's make our pig-latin program do a little more work.
;The last time we saw it we were restricted to doing one
;word at a time.  But it's often the case that we need to 
;do the same thing to all the entries of a list.  Scheme 
;provides the map function--a shortcut way to do this:
;map takes two arguments: a procedure and a list; it 
;returns a list in which the procedure has been applied, 
;er, MAPPED, to each entry in the list...in the original 
;order:

(map abs '(1 -1 2 -2 3 -5)) ;Neat?
(map even? '(0 1 2 3 4 5))  ;Make sense?

;In Scheme nearly everything is a "first-class" object: 
;values, list, procedures, strings, etc. so they can be 
;passed to and returned from procedures.  It's one of the 
;things Scheme-ophiles just love about the language.  It 
;makes it very flexible.

;Now, this is true for ANY procedure, not just the simple ones that 
;come built into the language.  Anything you define can be used this 
;way.  So let's warm up by keeping our pig-latin example going.

;Two weeks ago (was it three?) we took the first letter off a word, 
;stuck it to the back, and added "ay", so Happy Birthday became appyhay 
;irthdaybay.  But we had to do that one word at a time.  Let's use map 
;to translate a list of words (a phrase) and do this to each word in the 
;phrase:

;(map pig-latin '( (h a p p y) (b i r t h d a y) )) -->
  ;( (a p p y h a y) (i r t h d a y b a y) )

;Use YOUR program that you wrote two weeks ago.  Get used to upgrading 
;and improving your own code.  (OK, I've included a version if you can't 
;find yours, but use yours!)

;That was so easy, I think we should add a piece to our pig-latin 
;program.  There are several problems we should fix, but we'll just do 
;one easy one today: Words that start with "Q".  Obviously, 
;(pig-latin '(q u e s t i o n)) should return (e s t i o n q u a y), 
;that is, we want the 'u' to go with the 'q'.

;So write that into your pig-latin program.  Check to see if the word 
;starts with "q", and if it does, treat it differently from all the 
;other.  (Or check to see that it does NOT start with "q" and treat it 
;differently if it does.)

;It's OK to assume that the second letter will always be a "u".  When 
;you start planning your trip to Qatar (World Cup 2022?), we'll deal 
;with that then.

;(map pig-latin '((q u i r k y) (q u e a s y) (q u e s t))) -->
;((i r k y q u a y) (e a s y q u a y) (e s t q u a y))

(define (pig-latin word)
   (if (null? word)
        '()
        ;your "q" check should probably go here.
        (append (cdr word) (cons (car word) '(a y)))))

;Your TA will check your pig-latin procedure with something quirky.


;PART 2:  The Taxman gets a conditional workout     

;Now, perhaps it occurs that there are lots of other words that don't 
;get handled correctly by our pig-latin program.
;(pig-latin '(s t e p)) --> (t e p s a y) but 
;it SHOULD be (e p s t a y)

;(pig-latin '(e a r t h)) --> (a r t h e a y) but
;it SHOULD be (e a r t h w a y) or something else we might agree on.

;We have a number of CONDitions we might want to check for, and we will 
;in the coming weeks (if I don't get tired of it.)

;You've probably noticed that "The Little Schemer" uses "cond" rather 
;than "if" in most places.  ("if" doesn't even appear in the index.)
;We saw it last time with the SET lab, and I promised we'd explore it 
;more deeply here.

;Java, Python, and C(++) all use a "switch/case" structure to 
;accomplish what Scheme does with cond. In Basic it's ON <var> GOTO.  
;The idea is that there is a dial with many possible positions.  (Why 
;all the cool languages use "switch" which suggests just 2 positions, 
;baffles me.)

;So cond runs down a sequence of conditions and executes the code 
;associated with the first one that is true.  An "else" line can be 
;placed at the end.  "else" always evaluates as #t, so if you get that 
;far, that code is always evaluated, just like the #f line in "if".

;First, a little toy example

(define (oddevenzero n)
  (cond [(odd? n) (display "your number is odd")]
        [(even? n) (display "your number is even")]
        [(zero? n) (display "you entered zero!")]))

; Try (oddevenzero n)  for 0, 3, and 4  (and more, if you like)

; This function works fine, but the last condition will NEVER be used.  
;If you enter zero, the even test is satisfied before the zero test is 
;ever reached.  So let's switch things around (including the name of the 
;function):

(define (zerooddeven n)
  (cond [(zero? n) (display "you entered zero!")]
        [(odd? n)  (display "your number is odd")]
        [(even? n) (display "your number is even")]))

; This now will correctly identify zero:

; Try (zerooddeven n)  for 0, 3, and 4  (and more, if you like)

; We didn't actually NEED the even test, since once the odd test fails, what remains is guaranteed to be even:
(define (zerooddelse n)
  (cond [(zero? n) (display "you entered zero!")]
        [(odd? n)  (display "your number is odd")]
        [else (display "your number is even")]))

; Try (zerooddelse n)  for 0, 3, and 4  (and more, if you like)

;So cond (or switch/case) provide a way for us to write cleaner code 
;than a tower of if/elseif/.../elseif/else stuff.

;Let me show you with a REAL example computing taxed owed from taxable 
;income for 2012:  

(define (tax2012if income)
  (if (< income 0)
      (display "You made less than zero?")
      (if (<= income 8700)
          (* income 0.10)
          (if (<= income 35350)
              (+ 870 (* (- income 8700) 0.15))
              (if (<= income 85650)
                  (+ 4867.5 (* (- income 35350) 0.25))
                  (if (<= income 178650)
                      (+ 17442.5 (* (- income 85650) 0.28))
                      (if (<= income 388350)
                          (+ 43482.5 (* (- income 178650) 0.33))
                          (+ 112683.15 (* (- income 388350) 0.35)))))))))

;Go ahead and calculate your tax. (tax2012if 10000)
;Or Donald Trump's taxes.

;It looks pretty; it looks ugly; it looks pretty ugly.
;Here is the same calculation with cond:

(define (tax2012cond income)
  (cond ((<  income 0)     (display "You made less than zero?"))
        ((<= income 8700)               (*    income         0.10))
        ((<= income 35350) (+ 870       (* (- income 8700)   0.15)))
        ((<= income 85650) (+ 4867.5    (* (- income 35350)  0.25)))
        ((<= income 178650)(+ 17442.5   (* (- income 85650)  0.28)))
        ((<= income 388350)(+ 43482.5   (* (- income 178650) 0.33)))
        (else              (+ 112683.15 (* (- income 388350) 0.35))) ) )

;And you can see how much nicer this looks.

;So do (tax2012cond 2000000) and (tax2012if 2000000) and any other 
;comparisons you like!

;The point is that here "income" is the switch (dial) with lots of 
;possible settings rather than just #t & #f, so this sort of set up 
;makes sense here.  Notice that cond takes a list of lists as arguments, 
;so this is one of the few times I know of where '((' appears without a 
;procedure after that first '('.  And as you've seen, you can use 
;brackets: [ & ] to make the parsing even easier.

;cond takes a list of lists made up of ((condition) (procedure)) with 
;an optional (else (procedure)) as the final entry.  It executes the 
;procedure associated with the first #t evaluation among the conditions, 
;where 'else' always evaluates #t.

;(I'm not sure what happens if you put an 'else' higher in the list.  I 
;might be checking that out right now....)

;"cond" can always be used in place of "if", and "if" can always be 
;used in place of "cond".  Programming is an art that includes elements 
;of style.  The goal should be to write code that others can readily 
;understand.  And we've discussed syntactic sugar in a previous lab.

;I reserve "cond" for specific situations.  When designing a GUI with a 
;menu that returns numbers {1,2,...,n} it makes perfect sense as a 
;"switch" or "dial".  (For future reference, MATLAB makes that really 
;easy...)  

;Oh, and did you notice that I sneaked a new keyword in there?  I promised that during the week:

(display "Anything between quotes");This shows below on every "run".
(display (+ 99 36))

;So now it's YOUR turn to use cond ...
   
; The Body Mass Index (BMI) is a tool physicians use to determine 
;whether a patient is underweight, overweight, or just right.

; BMI is calculated by taking a person's mass (weight) in kilograms, 
;and dividing by the square of the person's height in meters.

; A BMI below 16 is considered Severely Underweight.
; A BMI between 16 and 18.5 is considered Underweight
; A BMI between 18.5 and 25 is considered Normal
; A BMI between 25 and 30 is considered Overweight
; A BMI between 30 and 40 is considered Obese
; A BMI over 40 is considered Morbidly Obese

; Use "cond" to write a function BMI that takes real arguments height 
;(in INCHES) and weight (in POUNDS) and returns a list with BMI value 
;and a designation from the table above.

; Note:  You'll need to do some metric convertions.  Your figures 
;should be quite close to these below, but a little variability is to be 
;expected with the metric conversions.  

; Note, too:  We are sloppy in our categories above. Do we mean < or <=?
;It's very unlikely that your computation will land you right on a 
;border between two categories, but make sure that no value can slip 
;through without finding an appropriate category.

; Note also: the BMI is a thumbnail sketch of a person that is often 
;misused.  Muscular athletes often fall into the Overweight and even 
;Obese categories.  It is meant to be a means of classifying physically 
;inactive people with normal body compostions. 

;Your TA will check you BMI program with a lineman and a ballerina.


;PART 3:  Arithmetic and Geometric Progressions

;An arithmetic progression is a sequence in which successive terms differ
;by some constant.  We'll use the idea and similar ideas frequently, so
;write a procedure that generates the first n terms of the arthimetic
;progression starting at 'a' where the terms differ by 'd'.
;(This may look very similar to the "build-seq" program you wrote for
;HW4.  Feel free to consult that code or reuse parts of it, if you like.

(define (arithmetic-prog a_0 difference iNdex)
  ("Your definition goes here"))

;(arithmetic-prog 2 3 5)  --> '(2 5 8 11 14)
;(arithmetic-prog 0 1 10) --> '(0 1 2 3 4 5 6 7 8 9)
;(arithmetic-prog 0 -1 5) --> '(0 -1 -2 -3 -4)

;Now you should be able to make a couple of simple modifications to
;turn your arithmetic progressions into geometric progressions.
;Go ahead:

(define (geometric-prog a_0 ratio iNdex)
  ("Your definition goes here"))

;(geometric-prog 1 10 5) --> '(1 10 100 1000 10000)
;(geometric-prog 1 2 11) --> '(1 2 4 8 16 32 64 128 256 512 1024)
;(geometric-prog 7 -3 5)  --> '(7 -21 63 -189 567)
 
;Having created progressions (sequences), we'd like to be able to sum
;their corresponding series.

;There are three ways we could do this:

;First, you should write a recursive procedure that takes a list of
;numbers and returns its sum:

(define (sum list-of-nums)
  ("Your definition goes here"))

;(sum '(1 2 3 4))     --> 10
;(sum '(0.1 0.2 0.3)) --> 0.6

;Second, we can take advantage of built-in procedure "apply".
;"apply" takes two arguments:  a procedure and a list and returns the a
;value computed by, well, applying the procedure to all the entries in
;the list.
;So, (apply + '(1 2 3 4)) returns (+ 1 2 3 4) --> 10
;and (apply * '(1 2 3 4)) returns (* 1 2 3 4) --> 24
;and (apply max '(1 5 2)) returns (max 1 5 2) --> 5

;Take a brief moment to note the difference between "map" and "apply".
;We saw in PART 1 that "map" applies a prodecure to every element in a
;list and returns a list as long as the one to which it was applied.
;On the other hand, "apply" generally returns a single (numeric?) value
;from the list to which its procedure is applied.

;These are VERY useful procedues we'll call upon frequently in the coming
;weeks.

;Third (finally), we can compute the sum of an arithmetic or geometric
;series directly with the formulas from Rosen.

;The sum of n terms (a + dk) of an arithmetic series is:
;Sigma(a + dk) from k=0 to n-1, and that is
;a*n + d*Sigma(k) from k=0 to n-1, and that is
;a*n + d*n*(n-1)/2.

;Write procedure "arith-sum" that computes this directly.

(define (arith-sum a_0 difference iNdex)
  ("Your definition goes here"))

;You now have three ways to sum these arithmetic series.
;Test them on the sequences you generated above.

;The sum of n terms (a*r^k) of a geometric series is:
;Sigma(a*r^k) from k=0 to n-1, and that is
;a*Sigma(r^k) from k=0 to n-1, and that is
;a*(r^(n+1)-1)/(r-1) where r is not equal to 1.

;Write procedure "geo-sum" that computes this directly.

(define (geo-sum a_0 difference iNdex)
  ("Your definition goes here"))

;You now have three ways to sum these geometric series.
;Test them on the sequences you generated above.

;Your TA will check your sequence generators and your series summers.
;Ah...summer.  Maybe sum day!


;PART 4:  Cartesian Product

;We've seen that the Cartesian Product of two sets A and B, or A x B
;is the set of all ordered pairs with first entry from set A and
;second entry from set B.

;So let's do that.  Write a procedure that takes two sets as arguments
;and returns their Cartesian Product.

;OK.  That might be a bit ambitious for a single procedure.  
;Perhaps you should first write a procedure that takes an item and
;a list and returns a list of "duples" (short for "ordered pairs") 
;with the item as the first entry in each.  Like this:


(define (make-duples item list-of-items)
  ("Your definition goes here"))

;(make-duples 0 '(1 2 3 4)) --> '((0 1) (0 2) (0 3) (0 4))

;We'll use lists of duples extensively in the coming weeks, so it's a 
;good idea to get familiar with them now.

;With "make-duples" that in your tool kit, now write "cart-prod" that 
;computes the Cartesian Product of a couple of sets.  (You can assume 
;the inputs are sets, but if you're feeling ambitious, you can also 
;re-use your set data structure to ensure that the inputs are sets.  If 
;you're feeling ambitious.)

;So now you have what you need for cart-prod:

(define (cart-prod setA setB)
  ("your definition goes here"))

;(cart-prod '(1 2) '(a b c)) --> ((1 a) (1 b) (1 c) (2 a) (2 b) (2 c))
;or
;(cart-prod '(1 2) '(a b c)) --> ((1 a) (2 a) (1 b) (2 b) (1 c) (2 c))
;
;A Cartesian Product IS a set, so any ordering is acceptable as long as
;the pieces--the elements--are all there.


;Your TA will check your product.  Don't make him or her cross!


;GOLDEN TICKET        The Inventing Room

;After the unfortunate incident with Miss Violet Beauregard, three-course
;gum had to be re-vamped.  Happily, several desserts besides blueberry
;pie have proved to be, um, juicy alternatives. 

(define dessert '(CremeBrulee StrawberryShortcake BakedAlaska))

;Additionally, we've been able to add a new soup:

(define soup    '(Tomato ChickenNoodle))

;And in order to convince parents of the wonderfulness and nutritional
;quality of three-course gum, several delicious entrees have been added:

(define entree  '(RoastBeef SteamedLobster FriedTofu Liver&Onions))

;All this means that instead of just one meal combination, we have, um
;a plethora of them.

;Write a procedure that lists every possible combination of meals by 
;computing the Cartesian Product: soup x entree x dessert

(define (triple-cart-prod setA setB setC) 
  ("Your definition goes here."))

;Oh, it's perfectly fine to use previous cart-prod, but be sure your 
;entries have the form: (soup entree dessert) and not
;(soup (entree dessert)) or ((soup entree) dessert).
;See the difference?

;Oh, and just how many different sticks of three-course gum can be made?

;Is your code robust enough to entend to the Belly-Buster-Buffet?
;It's seven-course wonder!  One of the Seven WONKArs of the confectionary
;world!

(define salad  '(Caesar IcebergWedge Cobb Waldorf))
(define side   '(MixedVeggies Spinach Asparagus))
(define starch '(BakedPotato RicePilaf  Mac&Cheese Succotash)) 
(define bev    '(coffee tea cappuccino cognac port))

;Can you compute: soup x salad x entree x starch x side x dessert x bev? 

;How many different sticks of Belly-Buster-Buffet gum can be made?




;March 2015
;Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))

