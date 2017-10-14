#lang eopl ;Always remember this line so that DrRacket uses 
;the correct interpreter

; Lab7 assignment Spring 2015     
; Tuesday, March 31, 2015

; Objective: Explore some more Scheme and do some of the things from 
; lecture in Scheme:
; Fun with modular arithmetic and number representations

; Make sure you are using #lang eopl in the first line.
; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat

;Part 0:  Warm Up (Digitize)
;Part 1:  Partity Check Bits / Check Sums
;Part 2:  Universal Product Code  (UPC)
;Part 3:  International Standard Book Number (ISBN-10)
;Part 4:  Hexspeak
;GOLDEN TICKET ????????????????????


;PART 0: Warm Up (Digitize)

;There are lots of fun things to do with the digits that make up integers

;Write a recursive procedure "digitize" that breaks a positive integer 
;into a list consisting of its respective digits:

;You'll probably need both "modulo" and "quotient", and your first
;attempt will probably give a backwards list, but by now you know how
;to fix that.

(define (digitize n)
  "Your definition goes here")

;(digitize 123) --> (1 2 3)
;(digitize 9876543210) --> (9 8 7 6 5 4 3 2 1 0)

;If you want a fun thing to do with "digitize" you can find the sum of
;the digits:  (sum-digits n)

;(sum-digits 123) --> 6
;(sum-digits 9876543210) --> 45

;You could also write the predicate "palindrome?" that returns #t iff the
;integers reads the same backwards as forwards:

;(palindrome? 12321) --> #t
;(palindrome? 12345) --> #f

;Or you can invent your own fun thing to do with the digits of an integer

;Your TA won't ask you for any of this, but it might come in handy later.


;PART 1: Partity Check Bits / Check Sums
;http://en.wikipedia.org/wiki/Checksum

;Digital information is transmitted in streams of 1's & 0's.
;How can you tell when the information gets corrupted?
;That is, how can you detect a bit flip, a 0 that gets turned into a 1, 
;or a 1 that gets turned into a 0?
;
;Well, one thing to do is to reserve a small part of your transmission
;for a parity check bit.  Then you can insist that any block of a 
;certain size has an even number of 1's in it.
;
;If the message piece already has an even number of 1's, tack on a 0.
;If the message piece has an odd number of 1's, tack on a 1 to make it 
;even.
;
;Write a predicate "even-parity?" that takes a bitstring --  (list of 0s 
;& 1s) and returns #t iff the number of 1s is even.

(define (even-parity? bitstring)
  "Your definition goes here")

;(even-parity? '(0 0 0)) --> #t
;(even-parity? '(0 1 1)) --> #t
;(even-parity? '(1 0 0)) --> #f
;(even-parity? '(1 1 1)) --> #f


;Now, write a procedure that computes the needed parity bit to make a 
;bitstring a legal message, i.e. one with an even number of 1's.

(define (parity-bit bitstring)
  "Your definition goes here")

;(parity-bit '(0 0 0)) --> 0
;(parity-bit '(0 1 1)) --> 0
;(parity-bit '(1 0 0)) --> 1
;(parity-bit '(1 1 1)) --> 1

;Your TA will check both of your procedures on simple bitstrings.

;OK.  Maybe that was TOO easy.  Let's look at a couple of everyday
;check digit schemes that are a little bit more complicated.


;PART 2: Universal Procuct Codes 
;             (UPC)http://en.wikipedia.org/wiki/Universal_Product_Code

;Universal Procuct Codes include a more advanced sort of check sum.
;The last digit of a product's UPC must be chosen so that the check sum 
;algorithm produces a number n, where n mod 10 = 0, rather than 
;n mod 2 = 0 as we saw above. This means that only 10% of 
;possible numbers is a legitimate number.  
;(A simple parity check bit allows 50% of numbers to be "legit".)

;UPC's are 12-digit identifiers.  The check algorithm sums the all the
;even-position digits and three-times the odd-position digits.

;A 305-gram can of Campbell's Tomato Soup bears this UPC:
(define tomato-soup '(0 5 1 0 0 0 1 4 8 7 2 8))

;The digit sum looks like this:
;0x3 + 5 + 1x3 + 0 + 0x3 + 0 + 1x3 + 4 + 8x3 + 7 + 2x3 + 8 =
;0 + 5 + 3 + 0 + 0 + 0 + 3 + 4 + 24 + 7 + 6 + 8 = 60
;And 60 IS 0 mod 10.  So that's a legit number.

;Write predicate "upc?" that takes a length-12 list of ints and returns
;#t iff the list corresponds to a legal UPC:

(define (upc? list-of-ints)
  "Your definition goes here")

;(upc? tomato-soup) --> #t
;(upc? '(0 5 1 0 0 0 1 4 8 7 2 8)) --> #t   (same thing)
;(upc? '(1 5 1 0 0 0 1 4 8 7 2 8)) --> #f   (changed first digit)
;(upc? '(0 7 1 0 0 0 1 4 8 7 2 8)) --> #f   (changed second digit)
;(upc? '(0 5 1 0 0 0 1 4 8 7 2 9)) --> #f   (changed last digit)

;Here are a couple more UPCs for you:
(define Aleve320 '(3 2 5 8 6 6 5 5 1 1 2 2))
(define hotSalsa '(0 2 8 4 0 0 0 5 5 9 9 4))
;Try it out on your bottle of water, your chewing gum, your ...

;Additionally, we want to be able to assign legal UPCs to our products,
;so you need to write a procedure that computes the necessary check digit
;for a length-11 UPC ID number.

;I recently bought a FlipSide puzzle by ThinkFun.  It's UPC ID is:
;0-19275-05460-*

;Your procedure should compute that "*".

;0x3+1+9x3+2+7x3+5+0x3+5+4x3+6+0x3 = ...
;0+1+27+2+21+5+0+5+12+6+0 = 79
;79 mod 10 = 9, so we need to add 1 to that to get make
;the remainder 0 mod 10.  Indeed, its check digit IS 1.

(define FlipSide '(0 1 9 2 7 5 0 5 4 6 0 1))

;Write procedure "upc-check-digit" that takes a length-11 list-of-ints 
;and returns the needed UPC check digit for that ID number.

(define (upc-check-digit list-of-ints)
   "Your definition goes here")

;WARNING!  Cannibalizing your code from upc? is perfectly acceptable, but
;your list will be 11-long rather than 12-long.  Beware the change in 
;parity.

;Also WARNING!  Make sure your recursive calls refer to some appropriate
;new procedure, not the one associated with upc?  (I made this error.)

;Here are a couple of 11-digit UPC IDs missing their check digits:
(define PuffsTissues '(0 3 7 0 0 0 6 2 2 6 2))
(define ChunkyChickenNoodle '(0 5 1 0 0 0 1 6 7 7 5))
;That one's tricky.  Do you see why?

;Tag the check digits onto the UPCs and use your own upc? to check
;whether you got the check digits right.

;Your TA will check your "upc?" and "upc-check-digit" on good & bad
;numbers.


;PART 3: International Standard Book Number  (ISBN-10)
;http://en.wikipedia.org/wiki/International_Standard_Book_Number

;Next we'll look at ISBN-10
;The International Standard Book Number is a check-digit scheme 
;designed to catch substitution and transposition errors when people 
;enter orders in a computer.  (The newer ISBN-13 is slightly different 
;and similar to the UPC barcode system.)
;
;Feel free to Google this if you find any of it confusing.
;
;The system uses the first 9 digits of the number as an ID number, but 
;the tenth and final number is a check digit.  It is completely 
;determined by the previous nine digits, like this:
;
;We compute a sum (of the following numbers:)
;
;The first digit is multiplied by 10,
;The second digit is multiplied by 9,
;The third digit is multiplied by 8,
; ...
;The eighth digit is multiplied by 3,
;The ninth digit is multiplied by 2.
;
;These numbers are summed, and the tenth number is whatever is required
;to make the overall (sum mod 11) = 0.  That is, a multiple of 11.
;
;So if your intermediate sum is 4, the tenth digit must be 7.
;If it is 1, the tenth digit must be ten.  That is why some ISBNs have 
;an X (a Roman Numeral ten) in the final spot.
;
;Let's do a sample calculation on "The Little Schemer", 
;ISBN 0-262-56099-2:
;Ignoring the hyphens, we get 0x10+2x9+6x8+2x7+5x6+6x5+0x4+9x3+9x2=  
;(we're COMPUTING the check digit 2)
;                              0 + 18 + 48 +14 +30 +30 +0 +27 +18 = 185
;The nearest multiple of 11 is 187, so the check digit should be 2, and 
;it is.  Another way to see this is: 185 = 9 mod 11, and 11-9=2.

;Write a recursive predicate ISBN? that checks lists of 10 integers and 
;returns #t iff they are legitimate ISBNs.

;Of course, you can use whatever books you have with you to test your 
;program (or get all the ISBNs you want from Amazon or Barnes&Noble.com 
;or wherever you please.)  

;Note: Books published after 2007 may have only the newer ISBN-13 
;standard. So be aware of that.
;
;Here's a HINT you may find useful.  As you recur on the list of 
;numbers, it will shrink, but its length is an important number in each
;step of the process.  You don't have to figure out a way to count or 
;pass an extra parameter from one call to the next.
;
;Here's a hint of how to go with it.  This is a straightforward method.
;There are better, more clever ways.
;
(define (ISBN? tenlist)
   "Your recursive procedure(s) goes here")
;
;You can test it on the Little Schemer:
;(ISBN? '(0 2 6 2 5 6 0 9 9 2)) -> #t
;
;And then try it swapping adjacent entries (transposition) or changing a single entry (alteration).  
;The ISBN? check is guaranteed to catch these errors:
;(ISBN? '(2 0 6 2 5 6 0 9 9 2)) -> #f   (transposed first pair)
;(ISBN? '(0 2 6 2 5 6 0 6 9 2)) -> #f   (altered 8th digit)
;
;Here are some numbers to try and show your TA:  (Some are good, and 
;some are not.  You can do a pencil and paper check like we did on the 
;Schemer to know the correct answers in advance.)  I'll name them by 
;their authors/titles, so you can investigate them on Amazon, etc. if 
;you like...!  They're great books....
;
(define winningways1 '(1 5 6 8 8 1 1 3 0 6))   ;#t
(define winningways2 '(1 5 6 8 8 1 1 4 2 10))  ;#t  that 10 is "X"
(define winningways3 '(1 6 5 8 8 1 1 4 3 8))   ;#f  Look closely and you can see the probable transposition error
(define winningways4 '(1 5 6 8 8 1 1 4 4 6))   ;#t
(define ritchie '(0 1 3 1 1 0 3 7 0 8))        ;#f  Check digit altered
(define ritchiePBK '(0 1 3 1 1 0 3 6 2 8))     ;#t

;[Show your TA a good one (#t) and a bad one (#f).]
(define hofstadter '(0 4 6 5 0 8 6 4 3 8))     ;#t     
;OK, sorry, Hofstadter is a bit tough to spell!
(define knuth '(0 3 2 1 5 3 4 9 7 4))          ;#f  Altered digit somewhere.  (I did it intentionally.)

;This will ALWAYS catch any single number which is incorrectly entered, 
;and this will ALWAYS catch any pair of consecutive numbers which are ;transposed. (The ISBN-13 misses a few transpositions, but it doesn't 
;use the "X" for ten--it uses numerals ONLY.)
;
;If you're feeling mathematical, you COULD try to prove the statements 
;about what ISBN-10 always catches.  They're TRUE!
;If you're feeling computer sciencical, you COULD try to code up a 
;predicate like this one for ISBN-13 or UPC bar codes.
;(And since you'd be feeling computer sciencical, you wouldn't mind my 
;pointing out that that or is inclusive!)

;Of course, as we did with the UPC, you should write a procedure to
;compute the check digit for a length-9 list of integers.  Again, you 
;can think of the algorithm as computing a hash of the 9-digit ID number 
;and then supply the necessary check digit to make the whole thing a 
;multiple of 11.  But at this point, it's just a little repetitve, so 
;your TA won't ask you for that.

;Your TA will check a real ISBN as well as a slipped digit and a pair
;of swapped digits on your "ISBN?"

;Did you try to use "digitize" for your UPC and ISBN procedures?  
;It's a little difficult because leading zeroes are allowed in both, and
;ISBN uses that "X" for a check digit of 10.  So digitize isn't useful
;without modifications that take more work than NOT using digitize.
;It was still a fun warm-up!


;PART 4:  HexSpeak            http://en.wikipedia.org/wiki/Hexspeak

;A few weeks ago we did representations of integers in different bases.

;You wrote:

(define (convert number base)
  (reverse (Convert number base)))

(define (Convert number base)
  (if (= number 0)
      '()
      (cons (modulo number base) (Convert (quotient number base) base))))

(define (base10 oldbase numberlist)
  (Base10 oldbase (reverse numberlist) 0))

(define (Base10 oldbase numberlist kount)
  (if (null? numberlist)
      0
      (+ (* (expt oldbase kount)(car numberlist)) (Base10 oldbase (cdr numberlist) (+ kount 1))))) 

;This allowed you to write integers in ANY base you like:

;(convert 123 2)  --> (1 1 1 1 0 1 1)   binary
;(convert 123 8)  --> (1 7 3)           octal
;(convert 123 16) --> (7 11)            hexadecimal

;In order to display hexadecimal numbers with letters for digits, we 
;need a routine to do the substitution:
;It's a little tedious to create, so I've provided hexconvert for you:

;(hexconvert hexnumber-as-list)
;(hexconvert (convert 123 16)) --> (7 B)

;And you can go backwards with:
;(base10 16 (numconvert '(7 B))) --> 123

;So that's decimal --> number list --> alpha-numerics
;with             convert         hexconvert

;and back again
;     alpha-numerics --> number list --> decimal
;with            numconvert        base10
;
;Again, you get those gratis.  (I've included them for you.)
;(Upper-case letters only today, please!)
;Just be careful to supply the right arguments in the right order.

;And now we can have some fun:

;How many sheep are there in New Zealand?  Lots!
;In fact, there are 12233642 of them in decimal.
;(It's obviously right in hexadecimal ....)

;(hexconvert (convert 12233642 16)) -->  Aha Haha!

;What do you call the toughest bull in the rodeo?  
;You know, the one that's thrown 195935983 cowboys?
;Convert to hexadecimal to find out!

;In Vienna, I saw 3405705229 different kinds of pastries.  Convert to 
;hexadecimal...
;
;Write your own "HEXSPEAK" joke.  It's fun!  Unleash your right brain!
;
;Take a hex string:  '(A B A C A B A) and turn it into a decimal:
;(base10 16 (numconvert '(A B A C A B A))) --> 180013754
;Now a joke about Peter Gabriel / Phil Collins / Genesis

;If you're really witty, you can incorporate numerals, too...

;I've probably heard "Hey, Jude" 64180 times.  
;Again, funnier in hexadecimal.
;
;
;These routines will allow you to use not just hexadecimal, but also 
;base 11, base 12, ... base 36 (or more?!?), as long as you use a
;substitution system of A=10, B=11, ... ,Z=35 (up to whatever you need 
;for, say, base 24.)  Military time uses a modulus of 24.  Degrees 
;(hours), minutes, seconds is essentially a (limited) base 60 system,
;but that would be a little crazy...
;
;Like this: (numconvert '(H E L L O W O R L D)) will give you a list 
;representation of the "number" in base 33, I think. (W = 32.)
;
;
;What we're doing here is ENCODING numbers, not ENCRYPTING them.  
;Typically, encoding refers to using a system to convert from one form 
;to another, more convenient, form for some purpose.  ASCII is the 
;American Standard CODE for Information Interchange; in ASCII an 
;upper-case A is enCODED as decimal 65 (or 41 in hexadecimal or 1000001 
;in binary).  Converting all characters to numbers makes it "easier" to 
;transmit them as bits across communications media.  The receiver then 
;just has to invert the process on the other end to recover the message.
;
;On the other hand, ENCRYPTION involves some secret piece of 
;information (a key) that not only encodes information but also makes 
;recovering that information difficult for those not in possession of 
;the secret.  We saw this earlier this semester with the Caesar shift 
;and affine transformations from lab5.
;
;Here's a secret I ENCRYPTED using simple ideas from these labs:
(define secret 48420295610439194978804589923121515475455500393246020365720930824673275)

;That number actually contains a nifty message.

;I ENCODED my message using hexconvert on base 37 where the digits are
;the ten "regular" numerals 0-9, plus 26 letters for 10-35 and finally 
;a '-' to act as a "space" and stand for 36.  0-36 in base 37.  

;(Although I originally wrote hexconvert for hexadecimal, I have extended
;it so that there is alphabetic support for any base up to base 37.)

;(numconvert '(S E C R E T))) produced a list-of-ints, then
;(base10 37 list-of-ints) turned that into a base10 number.  I then 
;ENCRYPTED that number by multipling it by a secret number and adding a 
;small random amount to disguise the multiplication.  (So factoring the 
;number won't reveal the key.)
;
;All you need to do is take the quotient of that number using the 
;correct (secret!) modulus, and you'll have back the base10 number that 
;is the encoding of my base 37 number.  You can recover (convert) the 
;base 37 number from that, and hexconvert will transform it back into 
;"alphabetic" numerals.  (Just like we did for hexspeak jokes -- after
;performing quotient X).
;
;But you need the secret number to use as a modulus.  (Why don't you 
;need the random amount I added to disguise the multiplication?)
;
;And I'm not telling you the secret number.  I'll only tell you that 
;when I was at Lehigh University, I always enjoyed watching the Marching 
;Band.  The Lehigh Marching Band sure was fun to watch during halftime 
;the football games.  I wonder what number is associated with the 
;Lehigh Marching Band....?
;
;Show your TA your own Hexspeak joke and your decryption of my secret.


;GOLDEN TICKET    The Chocolate Room

;The Chocolate Room is actually deep underground.  Thirteen floors below
;ground, in fact.  There are two strange doors with numbers on them:
;
;                  366860       and           344770
;
;You can reveal the secret of what lies behind the doors by transforming
;them from numeric form to alphabetic form.  If you're unlucky ...



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (hexconvert hexvalue)
  (if (null? hexvalue)
      '()
      (cons (altHEXsubletter (car hexvalue)) (hexconvert (cdr hexvalue)))))

(define (altHEXsubletter value)
  (cond ((= 10 value) 'A)
        ((= 11 value) 'B)
        ((= 12 value) 'C)
        ((= 13 value) 'D)
        ((= 14 value) 'E)
        ((= 15 value) 'F)
        ((= 16 value) 'G)
        ((= 17 value) 'H)
        ((= 18 value) 'I)
        ((= 19 value) 'J)
        ((= 20 value) 'K)
        ((= 21 value) 'L)
        ((= 22 value) 'M)
        ((= 23 value) 'N)
        ((= 24 value) 'O)
        ((= 25 value) 'P)
        ((= 26 value) 'Q)
        ((= 27 value) 'R)
        ((= 28 value) 'S)
        ((= 29 value) 'T)
        ((= 30 value) 'U)
        ((= 31 value) 'V)
        ((= 32 value) 'W)
        ((= 33 value) 'X)
        ((= 34 value) 'Y)
        ((= 35 value) 'Z)
        ((= 36 value) '-)
        ((= 37 value) '!)
        (else value)))

(define (numconvert numberlist)
  (if (null? numberlist)
      '()
      (cond ((eq? (car numberlist) 'A) (cons 10 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'B) (cons 11 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'C) (cons 12 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'D) (cons 13 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'E) (cons 14 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'F) (cons 15 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'G) (cons 16 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'H) (cons 17 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'I) (cons 18 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'J) (cons 19 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'K) (cons 20 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'L) (cons 21 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'M) (cons 22 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'N) (cons 23 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'O) (cons 24 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'P) (cons 25 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'Q) (cons 26 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'R) (cons 27 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'S) (cons 28 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'T) (cons 29 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'U) (cons 30 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'V) (cons 31 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'W) (cons 32 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'X) (cons 33 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'Y) (cons 34 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) 'Z) (cons 35 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) '-) (cons 36 (numconvert (cdr numberlist))))
            ((eq? (car numberlist) '!) (cons 37 (numconvert (cdr numberlist))))
            (else (cons (car numberlist) (numconvert (cdr numberlist)))))))




;March 2015
;Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures


(define Rosen '(0 0 7 3 3 8 3 0 9 0))
(define RosenSlip '(0 0 7 3 3 8 3 0 9 8))
(define RosenSwap '(0 0 3 7 3 8 3 0 9 0))

(define chips '(0 2 8 4 0 0 3 7 2 1 6 ))
(define upc-find1 chips)

(define HuntsTomatoPaste '(0 2 7 0 0 0 3 8 8 1 5))
(define upc-find2 HuntsTomatoPaste)


(define huntsTomatoPaste '(0 2 7 0 0 0 3 8 8 1 5 0))
(define huntsTomatoePast '(0 2 7 0 0 0 3 8 8 1 5 7))
(define huntsTomatoPayst '(0 7 2 0 0 0 3 8 8 1 5 0));#t!  Should be #f.
(define huntsTomatopaste '(0 2 7 0 0 0 8 3 8 1 5 0));This too!
(define huntstomatopaste '(0 2 7 0 0 0 8 8 3 1 5 0));And this!
(define huntstomatoPaste '(0 2 7 0 0 0 3 5 8 1 8 0))

(define upc-good huntsTomatoPaste)
(define upc-bad1 huntsTomatoePast)
(define upc-bad2 huntstomatoPaste)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
