#lang eopl ;Always remember this line so that DrRacket uses 
;the correct interpreter

; Lab5 assignment Spring 2015     
; Tuesday, March 10, 2015

; Objective: Explore some more Scheme and do some of the things from 
; lecture in Scheme:
; Modular arithmetic applications, integer representation
; Pseudo-random numbers, monosubstitution ciphers

; Make sure you are using #lang eopl in the first line.
; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat

;Part 0:  quotient/remainder/mod
;Part 1:  PRNGs: Pseudo-Random Number Generators
;Part 2:  Integer Representations 
;Part 3:  Back to base10
;Part 4:  Simple Cryptography: Caesar shifts & affine ciphers
;GOLDEN TICKET ????????????????????


;PART 0: quotient/remainder/mod

;Here are three more that you might not have seen before. Perhaps you 
;have.  These are number theoretic functions we'll use a lot later.  
;(Maybe even later today.)  They all take two (integer) arguments...see 
;if you can figure out what they do:

; >(quotient 20 3)
; >(quotient 20 7)
; >(quotient 7 20)

; >(remainder 20 3)
; >(remainder 20 7)
; >(remainder 7 20)

; >(modulo 20 3)
; >(modulo 20 7)
; >(modulo 7 20)

;It looks like remainder and modulo are the same...but they aren't!

; >(remainder -20 3)
; >(remainder -20 7)
; >(remainder -7 20)

; >(modulo -20 3)
; >(modulo -20 7)
; >(modulo -7 20)

; And maybe we should try:

; >(remainder -20 -7)
; >(modulo -20 -7)

;All very interesting.  Worth remembering.
;We will almost always work with 'modulo' rather than 'remainder', but
;if you think of modular arithmetic as "clock arithmetic", then 11 = -1 
;in that you "clock"-wise 11 gets you to the same place on the dial as 
;going 1 counter-"clock"-wise on a 12 hour (modular) clock face.

;In any case, the functions only differ when arguments of different
;signs are used.  We'll almost always use non-negative values anyway
;so it won't make a difference.

;From here on out today we're just going to do some grunt work with 
;remainders.  It's actually amazing how useful such a simple idea can be.

;Part 1: Pseudo-Random Number Generators (PRNGs)

;Making truly random numbers is incredibly hard.  
;Today we'll see part of why that is true as we generate some 
;pseudo-random numbers.

;We'll use the linear congruential method described on page 288 of Rosen.
;Modular arithmetic is often described as "clock arithmetic"--when you 
;reach the end, you start over again.  And you can go around and around
;the face of your clock as many times as you like/need.

;The function you'll use is called "p-random", and it's provided to you
;today.  You'll just explore what happens with different arguments.

;To generate "random" numbers we'll need four numbers; these will be the
;parameters in our (recursive) function:

;  modulus m,        this is the size of our clock
;  multiplier a,     this is the number of "big" steps we take
;  increment c,      this is the size of the extra step we take
;  seed, x0.         this is our starting place on the face of the clock
;                    Of course, the OLD random number will then become 
;                    the new seed.
;
;We will create a sequence of random numbers xn, with this generating 
;formula:
;
; x(n+1)=[ax(n)+c] mod m
;
;This means the NEXT number in a list, x(n+1), comes from multiplying 
;the current value, x(n), by a, then adding c, and finally taking the 
;remainder (using modulo!) when divided by m.
;
;Here's a list-building program that creates 20 (21, actually)
;"random" values from a modulus multiplier increment and seed:
;You can change that hard-coded 20 if you are using a small font size,
;I have it set to stay on a single line for the forthcoming examples,
;but I use a giant font so things can be seen from the last row in 
;class. 

(define (p-random modulus a-mult inC seed)
  (cons seed (next-p-random modulus a-mult inC seed 20)))

;We just make a simple calculation over and over again and put the
;results in a list.  

;This new function will kount down from 20, stopping at 0...or 1 or 
;wherever you like.
;So we need a helper that'll kount down to 0 with all the same 
;parameters we had before.
;
(define (next-p-random modulus a-mult inC seed kount)
   (if (= 0 kount)
       '()  ;We're making a list of 20 (maybe 21?) numbers, and if we kount to 0 we're done.  
;And here's our random-creating formula:
       (cons (modulo (+ (* a-mult seed) inC) modulus) 
             (next-p-random modulus 
                           a-mult 
                           inC 
                           (modulo (+ (* a-mult seed) inC) modulus) 
                           (- kount 1)))))
;
;So that cons line builds the list, and the one below recursively calls 
;a new pseudorandom number into the list.
;Note that we make TWO changes:  The seed changes to the new random 
;number, and kount is decremented, reduced by 1.
;Since the kount is falling, we know we'll hit bottom in our recursion. 
;(Good!)
;And we use each new number to generate the next.  Let's try it out on 
;some real parameters!

;(p-random 7 1 1 0) ;so we start with modulus 7, multiplier 1, increment 
;1, seed 0

;Pay very close attention to what just happened.
;How many numbers did we get?  Is that right?  Why?/Why not?
;
;We decided to start with 0, multiply by 1, add 1, and take the 
;remainder when divided by 7.  Do you see that in the list you generated?
;
;How useful is this as "randomness"?
;
;Hmmmm. Hardly random at all.  Notice the repeating cycle.  Ironically, 
;we'll see that again and again.  We'll just ultimately make it HUGE.
;
;What do you think will happen if you change the modulus?  Try it!
;(p-random 11 1 1 0)
;See what that does?  You get 11 different numbers to show up (maybe).  
;Depends what the modulus is.
;
;(If you can fit it in, make your list kount higher.  Change the 20 to 
;35 or 40 in next-p-random.  The more numbers you can see, the more 
;pattern you can see. This process is about seeing patterns and then 
;obscuring them.  (Just fit them on one line in the window so they don't 
;scroll.) 
;
;Now, let's go back to 7 as the modulus and change the 
;increment--that's the third parameter.  (But keep your kount as big as 
;you can keep on one line--more than 20 is good good good.)
;
;(p-random 7 1 2 0)
;Neat!  Still not random.  Not even close.  What if you change the 
;increment to 6?
;(p-random 7 1 6 0)
;I wonder if that always happens.  (No I don't.  It always happens.  
;The 6 is special here; it works like -1 because it's one less than our 
;modulus, 7.)
;
;So now, let's change the increment back to 1, but see how the 
;multiplier works:
;(p-random 7 2 1 0)
;Uh, oh.  That's pretty bad.  What if we make it a 3?
;(p-random 7 3 1 0)
;Ah.  That's better. But still not great.
;How about we change BOTH the multiplier AND the increment...
;(p-random 7 6 6 0)
;Tinker with it a bit and see what you can get...

;Now let's change the modulus to 101.
;(p-random 101 50 49 79)
;
;How about that?  How many numbers MIGHT we expect?  Yup, 101.
;But as soon as one repeats, things will repeat forever thereafter.
;Does that give a reasonably unpredictable sequence?
;
;Rosen tells us that a system like this with modulus 2^31-1, multiplier 
;7^5=16807 and increment 0 gives 2^31-2  different numbers before 
;beginning to repeat the sequence.  Choice of seed determines
;where in the sequence we jump in.
;
;Let's see if we can make this happen:
;(p-random (- (expt 2 31) 1) 16807 0 1)
;
;Not too shabby.  Crank out a big long list....
;
;Note: 2^31-2=2,147,483,646, so if we tried to put them all in a list, 
;it would be more than 2 billion entries.
;The memory in my machine is 1024megs.  That's a billion bytes, give 
;or take a bit.  Even if the integers in the list took just one byte 
;each (they take more than that) we could put less than half of them in 
;a list.  (So we won't try.)
;
;Of course, that says nothing about the ORDER of the numbers.
;These numbers are generated deterministically.  They have an inherent 
;pattern.  They are NOT random.
;But there are enough of them, and their order is "unpredictable enough" 
;that we can treat them as random for the purposes of rolling dice, 
;dealing cards, Monte Carlo simulations, etc.

;P.S.  Understanding what "unpredictable enough" means can form the 
;foundation for a Ph.D. thesis.  For our purposes, you shouldn't be able 
;to see any obvious patterns: odd/even, bigger/smaller, etc.

;One last thing:  Many programming languages with built-in (pseudo-) 
;random number generating functions always start with the same seed 
;unless you provide a seed of your own or give a separate command to
;"randomize".  Using the same sequence of random numbers is great during
;de-bugging--you know the differences between runs resulted from your 
;changes rather than different random numbers--but it means that every
;time you play solitaire, the deck will get "shuffled" the same way.

;How do you use a different seed each time you start a random process?
;A developer once told me that the number of milliseconds past midnight
;is a good choice.  So, accessing the system clock for your seed, x_0, 
;is a place to start.  (If you're OK accessing the calendar, too, the 
;number of milliseconds past midnight Jan 1, 1900 might be a good 
;choice, too.)


;Show your TA a list of random numbers using numbers in YOUR birthday 
;as the parameters.  Make sure the list is at least 20 numbers long and 
;includes NO duplicates.

;Here's mine: (p-random 1963 7 24 0)


;PART 2: Representing Integers in Different Bases
;
;We want to be nimble in our thinking about numbers.  We want to be 
;able to think about them and write them in any base at all, so we'll 
;now write two procedures: one to turn base 10 numbers to other bases 
;and another (the inverse!) to turn arbitrary base representations to 
;base10.
;
;Write a program 'convert' to change a base10 number to an arbitrary 
;base: 
;
;Just implement the algorithm from page 249 of Rosen (and in recent 
;lecture slides).
;
;(convert number base)  Should produce the basebase expansion of base10 number as a list reading in the normal way, i.e. the least significant digit (numeral) should be the RIGHT-most one.  If you create it backwards, you can fix that by using "reverse" in a launching program.  By now you should be getting used to that...
;
;(convert 50 3) -> (1 2 1 2)
;50 = 1 * 27 + 2 * 9 + 1 * 3 + 2 * 1
;So our list is the first number in each of those products.
;(convert 33 16)  -> (2 1)
;(convert 175 16) -> (10 15)      This shows hexadecimal with "digits" 
;10 and 15.  In the next lab we'll "fix" this by introducing alphabetic 
;"digits".  But that deserves its own "PART".  Next time!
;

;(define (convert number base)
;  ("your definition goes here"))


;(convert 1729 2) --> (1 1 0 1 1 0 0 0 0 0 1)
;(convert 1729 8) --> (3 3 0 1)
;(convert 1729 16)--> (6 12 1)      Hmmmmm, maybe we can fix that 12...

;What does (convert 1729 10) do?

;Next time we'll write programs to turn these lists back to base10 
;numbers.

;Your TA will ask you to convert some numbers to other bases.
;Who knows what numbers he or she will choose?


;PART 3:  Back to base10

;Write a program 'base10' to take a positive integer "oldbase" and a 
;number represented in oldbase in list form (like you just generated in 
;Section A above) and convert it to a base10 number:
;

(define (base10 oldbase numberlist)
  ("Your definition goes here"))


;(base10 oldbase numberlist) 
;(base10 3 '(1 2 1 2)) -> 50

;This means:  1 * 3^3 + 2 * 3^2 + 1*3 + 2 = 27 + 18 + 3 + 2 = 50

;(base10 16 '(10 15)) -> 175
;
;This means 10 * 16^1 + 15 (* 16^0) = 160 + 15 = 175
;
;So this will invert the previous program.
;
;There are a couple of ways to do this.  
;1)  You can use the length of the numberlist to derive the exponent you 
;need at any given time.  (simple/naive recursion)     
;OR
;2)  You can reverse the list (with a launcher/helper function) and use 
;a kounter to keep track of your exponent.  (Probably tail recusion) 
;
;Remember, (expt base power) gives "base" raised to "power".


;Your TA will give you a number in a base other than 10 and ask you
;to represent it as a base10 number.


;PART 4: Cryptography / Substitution Ciphers
;We're going to do a little bit of crypto.
;A substitution cipher is the sort of thing you see in the cryptograms 
;in your local newspaper.
;
;The simplest of these is a Caesar shift.  We simply replace a letter 
;with a letter some distance down the alphabet.  If we run off the end 
;of the alphabet, we cycle back to the beginning of the alphabet.
;That's where modular arithmetic comes in.  (Quick quiz:  What is 5 
;hours after 10 o-clock?  That's modular arithmetic.)
;
;We're going to use an alphabet of size 27, the lowercase letters and -.
;The ASCII alphabet is 128 characters (extended ASCII is 256), and 
;these techniques work perfectly well there, too, we
;would just need a modulus of 128 (256) instead of 27.  But that's some 
;heavy lifting.  We're playing, so we'll keep it small.  Have fun with 
;this.
;
;The Caesar shift has a keyspace of 26 keys, and one of those is the 
;identity shift which leaves a message unchanged.  So we can easily 
;decrypt a shifted message by brute force/exhaustive search.
;
;Create a message that is your name, like this:
(define ME '((m i k e) (e n g l i n g)));Note spaces between letters.
;You can name it by your initials or call it ME.  I get to do both.
;And remember, I put '-' in the alphabet, so if you have a hyphen in 
;your name, you can include it as a character - with spaces around it.
;If your name has an apostophe like, O'Meara, you're out of luck.  Sorry.
;Note: You need to use only lowercase, and you MUST put words inside 
;parentheses, even if there is just one word, like this:
(define alloneword '((a l l o n e w o r d i n e x t r a p a r e n s))) 
;The list must have a caar!
;Sorry, the code is fragile. You also MUST separate letters with spaces!
;
;This is another "playful" part where you get free code.
;You get three functions here:
;1)  (encrypt message key) where message is a nested letter list as 
;above and key is an integer 0-26
;2)  (decrypt message key) where message is a nested number list and
;key is a decryption key (integer 0-26)
;3) (decryptall message) where message is a nested number list
;This one shows all possible decryptions of the message.  It will 
;produce 27 possible messages.  With any luck one will be meaningful.
;The other 26 should be gibberish.

;We can transform the letters into their corresponding numbers in the 
;alphabet by encrypting it with a key that doesn't change anything, in 
;this case 0.  It means we move each letter down the alphabet 0 places:
;(encrypt ME 0) -> ((13 9 11 5) (5 14 7 12 9 14 7))
;"m" is the 13th letter, and "mike" ends with the same letter that 
;"engling" begins with: "e", the 5th letter.  And you can see the double 
;"ng" in there, too.
;
;Now, encrypt your name using your favorite number as the encryption key:
;(encrypt ME 13) -> ((26 22 24 18) (18 0 20 25 22 0 20))
;Kinda neat, no?
;If you have any letters that show up more than once, you should see 
;that they are encoded with the same integer each time.
;The integers in the list are those from 0 to 26, inclusive, and you 
;should be able to see that they have all shifted down the alphabet by 
;the same amount, the amount you gave the function as an argument, the 
;key: "Mike" ends in 'e' and "engling" starts with 'e'.  They both 
;became 18, 13 spaces down from 'e', the 5th letter.
;Both of the 'ng's in my last name became 0 20.
;Really simple.

;Now, cut and paste your list into this: (Perfectly replace MY 
;encrypted name with your own).
;(decryptall '((26 22 24 18) (18 0 20 25 22 0 20)))
;
;The decryptall function gives a pile of all the possible decryptions 
;(and encryptions) of your name.
;All that randomness, and then YOUR name right there in the midst of 
;it.  Somewhere.
;
;Of course, you can also just decrypt your name, like this:
;(decrypt '((26 22 24 18) (18 0 20 25 22 0 20)) 13) ;Note: this time 
;you have to include the encryption/decryption key
;And notice we decrypt into CAPITAL letters, just so we can keep things 
;straight.
;
;Now you can encrypt and decrypt anything:
;How about "the quick brown fox jumps over the lazy dog"
;That's so important I called it 'typingtest'
;(encrypt typingtest 5)
;
;That contains every letter of the alphabet (except '-').
;We'll use it a bit with the next encryption method.
;
;Now decrypt this message [TAmessage1] and tell your TA (in a whisper)...

(define TAmessage1 '((6 21 22 5) (25 14 15) (22 5) (6 1 1) (18 14 5 11)))

;You can try to decrypt TAmessage2 much the same way you did TAmessage1.
;Go ahead.  Try.
;Not so easy this time, huh?  That's because it is not a Caesar shift.
;I encrypted it with a slightly more sophisicated affine cipher, which
;you'll see shortly.

;Definitions used in this lab:
(define TAmessage2 '((15 18 11 22) (17 13 6) (11 22) (22 15 11 17 17) (12 13 22 7)))
(define typingtest '((t h e) (q u i c k) (b r o w n) (f o x) (j u m p s) (o v e r) (t h e) (l a z y) (d o g)))
(define alphabet '((- a b c d e f g h i j k l m n o p q r s t u v w x y z)))
(define allnums '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26))


;Encrypt whatever you like.  Email each other encypted messages.  Go 
;nuts.
;
;Or we can step on the gas.  Caesar shifts are easily broken.  
;The next stage is an affine transformation.  We will stretch the 
;alphabet AND shift it, much like the linear congruences we started with 
;in the random number section.  Each letter takes a new "random" place 
;in the alphabet, and then we shift again.
;
;Where the shift turns a letter p into (p + key) mod 27, we throw in a 
;multiplier:     encrypt(p)= (a * p + b) mod 27.  
;
;See it?  The 'a' is like the multiplier; the b is the increment, the 
;old letter p is the seed; and our alphabet is 27 characters big, so the 
;modulus is 27. We're essentially doing the same thing we did to make 
;random numbers, but instead of doing it over and over with each new 
;letter, we do it so that each letter acts as a seed once and gets 
;mapped to a brand new letter.
;
;Now, the pair (a, b), your multiplier and increment, is the key
;(instead of just one number with a shift), so instead of 25 possible 
;encryptions we'll now have (perhaps) 27 * 27 - 1 (the identity) = 728 
;possible key combinations.  Of course, that's easily broken by a 
;computer, but it's still fun to play with and a first step in a chain 
;of ideas.
;
;For this section of PART 4 you get two things for free:
;(affine message multiplier increment)      which encrypts message
;(inv-affine message muliplier increment)   which decrypts message
;The muliplier and increment make up our encryption "key".  We'll 
;investigate what different combinations do.

;This method is called an affine transformation, so we'll encypt 
;messages with the function:
;(affine message a b)
;
;ENTER: (affine typingtest 1 0)  
;Look closely when you do this one.  
;It's really the identity "the"=(20 8 5).  It's a Caesar shift 0. 
;
;And we decrypt with (inv-affine message a b):
;(inv-affine '((20 8 5)(17 21 9 3 11)(2 18 15 23 14)(6 15 24)(10 21 13 16 19)(15 22 5 18)(20 8 5)(12 1 26 25)(4 15 7)) 1 0)
;Nifty, no?
;
;Let's look a little more closely at a & b.
;
;ENTER: (affine typingtest 2 20)
;
;Look closely, and you'll see that all 26 letters are represented, and 
;there are 26 different numbers in the encryption.
;
;ENTER: (affine typingtest 6 20)
;Look closely at "fox".  All the letters have become the same (2 2 2)
;
;ENTER: (affine typingtest 9 20)
;Now 'fox' is (20 20 20) and 'the' is (11 11 11)!
;In fact, although 26 different letters are in the message, only three
;"letters" show up in the substitution: 2, 11, and 20.
;
;ENTER: (affine typingtest 27 20)
;Uh-oh!  Everything is 20.  Yikes!
;
;Remember the random numbers?  How sometimes we got as many as the 
;modulus, and sometimes we got a lot less?
;Same thing at work here.  We need to pay attention to what's happening.
;
;The multiplier is the trick here.  We'll get multiple letters being 
;mapped to the same number if the multiplier and the modulus share a 
;common factor (other than 1).  
;[Not quite the same as in the random number stuff.]
;
;Using 2 was good, but 6 turned 'fox' into all the same letters f-6 0-18 x-24.  Hmmmmm?  (Became 20 20 20)
;Using 9 was extra bad, because 9 has two 3s and so does 27 (It's three 3s, actually).  (6 has only one 3.)
;And 27 caused everything to look the same.
;
;So we'll only be able to use (a,b) combinations where our multiplier 
;(a) and our modulus (27--the size of our alphabet) are relatively prime.
;That is, they have no common factor other than 1.  Since 27 is 3^3, we 
;can use any "a" that does not have 3 as a factor.
;today, but 128 for ASCII!) are relatively prime--they share no common 
;factors other than 1.

;Basically, the multiplier "stretches" the alphabet, and if there's a 
;common factor between the stretch and the modulus (size of alphabet), 
;then as we wrap around the end of the alphabet several times, some 
;letters get mapped to the same number (the function is not 1-1, and 
;some numbers get missed (the function is not onto).
;
;Now that means that using a prime number as the modulus would give us 
;all the possible keys, and we wouldn't have to worry about making a 
;"bad" choice.  (But don't take (1,0).  That's the identity map, i.e.
;encrypting it into itself.  Rather insecure.)  So we could add a 
;couple of pieces of punctuation (to 29) or maybe 4 more characters 
;(to 31), but then I wouldn't be able to show what happens with a bad
;choice, and I probably couldn't convince you just how important prime
;numbers are to applications like this.


;
;Because we can't use "a" from {0,3,6,9,12,15,18,21,24} our keyspace is 
;smaller than we thought.  We only have 18*27=486 possible good keys of 
;the form (a,b) where a is not a multiple of 3 and both a & b lie 
;between 0 and 26 inclusive. Furthermore, (1,0) is NO stretch and NO 
;shift, so that's just the identity transformation, i.e. encryption by 
;not encrypting.  So you really have 485 keys to check instead of 728 
;for our system.  You could try to create a "inv-affine-all" function to
;parallel our "decryptall" from the Caesar shift, but at 485 possible
;messages we're already approaching needle-in-a-haystack territory, at
;least if you're reading them by eye.  (Child's play for a computer.)
;
;Since the affine transformation isn't always bijective (1-1 AND onto), 
;the inverse map is not a function and decryption is either ambiguous or 
;impossible.  With our fragile code today, it's impossible.  
;
;If you try to decrypt a message with any (a,b) pair in which "a" is a 
;multiple of 3, your computer will hang in an infinite loop.  I warned 
;you that the code is fragile.  (Go ahead, give it a try.)
;
;Now try to decrypt TAmessage2 and show it (tell in a whisper) to your TA:
;
;If you see what we're doing, I mean if you SEE it perfectly, you'll know what (a b) pair to try.
;Look at it as though you have PERFECT VISION.  You don't need glasses.  (Yup, that's a hint....)
;(define TAmessage2 '((15 18 11 22) (17 13 6) (11 22) (22 15 11 17 17) (12 13 22 7)))
;

;Show your TA decryptions of TAmessage1 & TAmessage2


;GOLDEN TICKET: Messages from Fickelgruber & Prodnose & Slugworth     
;
;Fickelgruber is a simple man.  Greedy, but simple.  He slipped this to
;Mike Teevee and said, "Fickelgruber's the name; counting letters is my
;game."  And then he gave a knowing wink.
(define FickelgruberMessage '((21) (8 13 26 5) (4 0 25 17) (24 21 15 23 13 14 24 17) (8 13 24 24 1 13 1 17 3)))

;Prodnose is thought to be affine upstanding European citizen.  
;In fact, he's as sneaky as they come.  When he saw Veruca Salt, he 
;said, "Today's the day!  TODAY is the DAY! That's the key thing to 
;remember."  She found this scribbled on her Golden Ticket later:
(define ProdnoseMessage '((9 12 20 20 10 3 15 12 9 14 12 8 19)
 (16 21 12 8 5 4) (17 18 24 15 16) (23 26) (8 12 6 26)))

;Slugworth is the most devious of the evil chocolatiers.  He sent this 
;encrypted message to the CS 13 5 students in lab today:
(define SlugworthMessage '((4 23 14 25 15) (12 16) (18 25)
 (16 21 16 23 26 18 9 22 14 25 15) (15 11 4 9 22 11 24 24 16 23)))

;Little is known about how he chooses his encryption keys.  It is 
;thought he leaves clues in plain sight.

;I wonder what they might be after....



;*****************************************************
;HERE'S THE CODE FOR THE CRYPTO PARTS:

;Encryption routines for the caesar shift and
;affine transformation mono-substitution ciphers

;Performs caesar shift on message moving each letter key spaces down alphabet
(define (encrypt message key)
  (if (null? message)
      '()
      (cons (shift key (numword (car message))) (encrypt (cdr message) key))))

;Performs shift word by word
(define (shift n word)
  (if (null? word)
      '()
      (cons (modulo (+ (car word) n) 27) (shift n (cdr word)))))

;Performs shift on a single word
(define (numlist words)
  (if (null? words)
      '()
      (cons (numword (car words)) (numlist (cdr words)))))

;Makes letter by letter substitution for numbers
(define (numword alphas)
  (if (null? alphas)
      '()
      (cond ((eq? (car alphas) 'a) (cons 1 (numword (cdr alphas))))
            ((eq? (car alphas) 'b) (cons 2 (numword (cdr alphas))))
            ((eq? (car alphas) 'c) (cons 3 (numword (cdr alphas))))
            ((eq? (car alphas) 'd) (cons 4 (numword (cdr alphas))))
            ((eq? (car alphas) 'e) (cons 5 (numword (cdr alphas))))
            ((eq? (car alphas) 'f) (cons 6 (numword (cdr alphas))))
            ((eq? (car alphas) 'g) (cons 7 (numword (cdr alphas))))
            ((eq? (car alphas) 'h) (cons 8 (numword (cdr alphas))))
            ((eq? (car alphas) 'i) (cons 9 (numword (cdr alphas))))
            ((eq? (car alphas) 'j) (cons 10 (numword (cdr alphas))))
            ((eq? (car alphas) 'k) (cons 11 (numword (cdr alphas))))
            ((eq? (car alphas) 'l) (cons 12 (numword (cdr alphas))))
            ((eq? (car alphas) 'm) (cons 13 (numword (cdr alphas))))
            ((eq? (car alphas) 'n) (cons 14 (numword (cdr alphas))))
            ((eq? (car alphas) 'o) (cons 15 (numword (cdr alphas))))
            ((eq? (car alphas) 'p) (cons 16 (numword (cdr alphas))))
            ((eq? (car alphas) 'q) (cons 17 (numword (cdr alphas))))
            ((eq? (car alphas) 'r) (cons 18 (numword (cdr alphas))))
            ((eq? (car alphas) 's) (cons 19 (numword (cdr alphas))))
            ((eq? (car alphas) 't) (cons 20 (numword (cdr alphas))))
            ((eq? (car alphas) 'u) (cons 21 (numword (cdr alphas))))
            ((eq? (car alphas) 'v) (cons 22 (numword (cdr alphas))))
            ((eq? (car alphas) 'w) (cons 23 (numword (cdr alphas))))
            ((eq? (car alphas) 'x) (cons 24 (numword (cdr alphas))))
            ((eq? (car alphas) 'y) (cons 25 (numword (cdr alphas))))
            ((eq? (car alphas) 'z) (cons 26 (numword (cdr alphas))))
            ((eq? (car alphas) '-) (cons 0 (numword (cdr alphas))))
            (else (numword (cdr alphas))))))

;Decryption routines for caesar shift

;"Unshifts" message key spaces to the left
(define (decrypt message key)
  (if (null? message)
      '()
      (cons (letterword key (car message)) (decrypt (cdr message) key))))

;Performs shift a word at a time
(define (letterword n numbers)
  (if (null? numbers)
      '()
      (cons (alpha (modulo (+ (- 27 n) (car numbers)) 27)) (letterword n (cdr numbers)))))

;Makes substitution number by number for letters
(define (alpha k)
  (cond ((= 0 k) '-)
        ((= 1 k) 'A)
        ((= 2 k) 'B)
        ((= 3 k) 'C)
        ((= 4 k) 'D)
        ((= 5 k) 'E)
        ((= 6 k) 'F)
        ((= 7 k) 'G)
        ((= 8 k) 'H)
        ((= 9 k) 'I)
        ((= 10 k) 'J)
        ((= 11 k) 'K)
        ((= 12 k) 'L)
        ((= 13 k) 'M)
        ((= 14 k) 'N)
        ((= 15 k) 'O)
        ((= 16 k) 'P)
        ((= 17 k) 'Q)
        ((= 18 k) 'R)
        ((= 19 k) 'S)
        ((= 20 k) 'T)
        ((= 21 k) 'U)
        ((= 22 k) 'V)
        ((= 23 k) 'W)
        ((= 24 k) 'X)
        ((= 25 k) 'Y)
        ((= 26 k) 'Z)))

(define (decryptall message)
  (decryptAll message 0))

(define (decryptAll message key)
  newline
  (if (= 27 key)
      (newline)
      (begin
        (newline)
        (display (decrypt message key))
        (decryptAll message (+ key 1)))))
  

;Encryption routines for the affine transformation

;Encrypts message with 2-part key a and b
(define (affine message a b)
  (if (null? message)
      '()
      (cons (aff-trans a b (numword (car message))) (affine (cdr message) a b))))

;Performs transformation word by word
(define (aff-trans a b word)
  (if (null? word)
      '()
      (cons (modulo (+ (* a (car word)) b) 27) (aff-trans a b (cdr word)))))

;Performs decryption of affine transformation cipher
(define (inv-affine message a b)
  (if (null? message)
      '()
      (cons (inv-aff-trans (a-inv a) b (car message)) (inv-affine (cdr message) a b))))

;Performs affine decryption word by word
(define (inv-aff-trans a-inv b numbers)
  (if (null? numbers)
      '()
      (cons (alpha (modulo (* (modulo (- 
                                       (car numbers) b) 27) a-inv) 27))  (inv-aff-trans a-inv b (cdr numbers)))))

;Computes multiplicative group inverse of a
(define (a-inv a) ;NOTE:  if a and 27 are not relatively prime, this will enter infinite loop
  (if (< a 2)
      a
      (find-inv a 2)))

;Actual calculation of 
(define (find-inv a k)
  (if (= 1 (modulo (* a k) 27)) ;only way out of infinite loop is if (a,27)=1
      k
      (find-inv a (+ 1 k))))
;***********************************************************************



;March 2015
;Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
