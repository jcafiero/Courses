#lang eopl

; lab12 CS135              Everlastingness
; Tuesday, May 5, 2011

; Objectives of lab:  
; Implement RSA Cryptography  (with smaller-than-secure moduli)
;
; PART 0 Fast Modular Exponentiation
; PART 1 Practice RSA with repUnit primes 19&23
; PART 2 Building your own System
; PART 3 Encrypting and Decrypting Messages
; PART 4 Digital Signatures
; GOLDEN TICKET  ?????????????????????????

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; As always save your own copy as lab13sol.rkt so you can make your own additions as 
;instructed.  Have a look at the following.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Warm up:  PART 0  

;As we said in class, we need three things to do RSA crypto:
;1.  A FAST modular exponentiation algorithm
;2.  The Chinese Remainder Theorem, and
;3.  Fermat's Little Theorem.

;The latter two of these are both theoretical results that tell us 
;what will happen when we put things together correctly.  That work
;is done.  The only thing left is the beating heart of the matter:
;a FAST modular exonentiation algorithm implementation.

;Write (fast-mod-exp base exponent modulus) that 
;quickly computes:  base^exponent mod modulus.

;The algorithm is included as a pdf in the Canvas lab assignment
;I've also included (bitstring n) to give you the base2 
;representation of your exponent, since you'll need it for your
;implementation.
;CAUTION:  (bitsring n) comes out "backwards".  Makes it easier:
;(bitstring 34) --> (0 1 0 0 0 1)   NOT (1 0 0 0 1 0)

(define (fast-mod-exp base exponent modulus)
  "Your definition goes here")


;(fast-mod-exp 23 34 11) --> 1
;(fast-mod-exp 1001 10001 100001) --> 902 


;PART 1 Practice with repUnit primes 19&23
;
;Early in the semester we met the repunits.  These are integers made up 
;of all 1's.  You can look them up on oeis.org and check that 
;the 19th and 23rd repunits are prime.  
;That is, 1111111111111111111 is prime, and
;also 11111111111111111111111 is prime.  
;Let's use their product as our modulus for an RSA implementation.

(define p1 1111111111111111111)
(define q1 11111111111111111111111)
(define p1q1 (* p1 q1))
(define repUnitRSAmod (* (- p1 1) (- q1 1)))

;Now we need an encryption exponent, eRepUnit.  Our only requirements 
;are that eRepUnit be relatively prime to repUnitRSAmod.

;Let's try 81.

;(gcd 81 repUnitRSAmod) = 9.
;That's no good.  We need the gcd to be 1.
;Let's try 10103.

;(gcd 10103 repUnitRSAmod) = 1.
;That'll work, so let's use that.
(define eRepUnit 10103)

;Now we have enough to encrypt a message.
;To decrypt a message, we need decryption exponent dRepUnit.

;dRepUnit will be the inverse of eRepUnit modulo repUnitRSAmod 
;(p1-1)(q1-1).  

;We know such an inverse exists because we insisted that gcd(eRepUnit, 
;repUnitRSAmod) = 1.

;(define dRepUnit (inverse eRepUnit repUnitRSAmod))
; = 486348633763593016133773002274107556367


;We need that block of code up here to define dRepUnit as a named variable
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;This code is an implementation of the Extended Euclidean Algorithm
;It gets us the inverses we'll need today (and last week in the CRT lab.)

(define (inverse exponent modulus)
  (Inverse exponent modulus '(1 0) '(0 1) (reverse (euclid-quotients exponent modulus))))

(define (Inverse exponent modulus s-list t-list q-list)
  (if (= (length s-list)  (+ (length q-list) 1) ) ;not sure if q-list starts counting at 0 or 1.
      (modulo (+ (car t-list) modulus) modulus)
      (Inverse exponent modulus (extend s-list q-list) (extend t-list q-list) q-list)))

(define (extend s-or-t-list q-list)
  (cons (- (cadr s-or-t-list) (* (right-q s-or-t-list q-list) (car s-or-t-list))) s-or-t-list))

(define (right-q shortlist longlist)
  (if (= (- (length shortlist) 1) (length longlist))
      (car longlist)
      (right-q shortlist (cdr longlist))))

(define (euclid-quotients a b)
  (if (= 0 (modulo a b))
      (list (quotient a b) )
      (cons (quotient a b) (euclid-quotients b (modulo a b)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;So this will give us an easy-to-use dRepUnit:
(define dRepUnit (inverse eRepUnit repUnitRSAmod))

;Now, how big a message can we encode?  We'll use our base 27 system, so
;We need the log change-of-base formula to compute log27 p1q1.  That's:

;(/ (log p1q1) (log 27))  (We saw this way back when, I think.)
;(/ (log p1q1) (log 27)) = 28.009...

;So we should be able to encrypt a 28-character message, 
;but not a 29-character message.

;Let's check:

(define repUnitMessage '(t h i s - m e s s a g e - i s - n o t - t o o - l o n g))
;That's exactly 28 characters long.  Let's convert it to a list of integers:

;(numword repUnitMessage) = (20 8 9 19 0 13 5 19 19 1 7 5 0 9 19 0 14 15 20 0 20 15 15 0 12 15 14 7)

;and then to a single base27 integer:  
;(base27 '(20 8 9 19 0 13 5 19 19 1 7 5 0 9 19 0 14 15 20 0 20 15 15 0 12 15 14 7)) = 9005818239986764517009372541682391059312

;And let's encrypt it with eRepUnit and modulus p1q1,
;using our fast-mod-exp beating heart procedure:

;(If you couldn't get your fast-mod-exp to work, you can use mine:)
;(modExp base exponent modulus)   or ... 
;(modExp message encKey pq)       as you think of it.

;(fast-mod-exp 9005818239986764517009372541682391059312 eRepUnit p1q1) =
;7392285864675365863697466843396080605216

;If that worked, then decrypting it gives:
;(fast-mod-exp 7392285864675365863697466843396080605216 dRepUnit p1q1) =
;9005818239986764517009372541682391059312       Looks good!

;And let's decode it: 
;(decode 9005818239986764517009372541682391059312)

;And let's try 
(define repUnitMessageBIG '(t h i s - m e s s a g e - i s - j u s t - t o o - l o n g))
;which is 29-characters long

;(decode (fast-mod-exp (fast-mod-exp (base27 (numword repUnitMessageBIG)) eRepUnit p1q1) dRepUnit p1q1))
;Produces gibberish.  As we expected.  You WERE expecting that, right?

;This relationship is not quite so cut and dried.
;There will be either some 28-character messages we can't encrypt or
;some 29-character ones we can.  Where's the boundary?  Something to 
;think about!


;PART 2 
;Now it's up to you to create your own system.  You found a nice pair 
;of primes over the weekend, right?  Well, if not, I've include:

;(find-next-prime odd-integer how-many-primes-you-want)

;So (find-next-prime 1000001 3) = (1000003 1000033 1000037), the first 
;three primes larger than a million.

;These are pretty small for our purposes, so I hope you found some 
;juicy ones of your own.  And, hey, "find-next-prime" will get you
;a couple 15-digit primes in a minute or so.  Pick a seed like:
;   10000MMDD000001 where MMDD are your birthday, and you'll get your
;own personal primes.  Spread those letters out, move 'em around.  
;Just make sure you start with an odd number -- something that MIGHT be
;prime itself.  (It's OK if it ends in 5....)

;You can also use what's up on Canvas.

;Once you have a nice pair of primes, compute your modulus pq, your 
;encryption exponent e, your (p-1)(q-1), and your decryption 
;exponent, d.  [Inverse of e modulo (p-1)(q-1).]

;And give them global names:

;(define myMod (* p q))  just to make things easy for yourself.

;Here's a set-up for you.  Just plug in your primes p and q and uncomment the code.
;(define p yourPrimeP)
;(define q yourPrimeQ)
;(define pq (* p q))       ;Have it for free!
;(define n pq)             ;Or call it n if you like
;(define RSAmod (* (- p 1) (- q 1)))

;Now, find e with (gcd e RSAmod) = 1

;And a d, (define d (inverse e RSAmod))

;And compute your payload size, the size of the biggest message you can 
;encrypt:
;(/ (log pq) (log 27))  

;Here we go!


;PART 3:  RSA-CRYPTO 
;Now we're going to do some actual crypto.  It'll be fun.  If it works.
;
;So now you have a public key that anyone can use to encrypt messages to 
;you--e and pq, and a private decryption key, d,  so that only YOU can 
;decrypt messages sent with your public key.
;
;I also have a public key--exponent and modulus.  Here they are:
(define MEpublicKeyModulus 27606985387162255149739023449107931668458716142620601169954803000803329)
(define MEpublicKeyExponent (- (expt 2 41) 1))
(define MEpublicKeyPayload (/ (log MEpublicKeyModulus) (log 27)))

;More conveniently:
(define ME-mod MEpublicKeyModulus)
(define ME-e   MEpublicKeyExponent)


;You must now send me an email (mengling@stevens.edu) with a message no 
;longer than my payload encrypted with my public key.  

;In the body of the message, include YOUR encryption exponent and 
;modulus and the size of your maximum payload.  There is no need to 
;encrypt this info--it's public.  You publish it precisely so that 
;others CAN see it in the open and use it to encrypt messages to you.
;
;I will send you an encrypted response using YOUR public key information.
;
;When you have decrypted it, send it back to me in the clear so that I 
;will know you were successful.
;
;We're going to make mistakes, but we'll have some fun.
;
;I am standing by awaiting your ENCRYPTED message telling me 
;you are ready.
;
;I will be responding to 50 or so people more or less simultaneously.  
;Be a smidgeon patient with me.
;
;
;I'm waiting...
;
;
;"My Brain Is Open...Again"


;PART 4 Digital Signatures
;
;Public Key Cryptography allows us another interesting application.
;
;Our encryption keys and decryption keys are inverses of each other 
;modulo (p-1)(q-1).
;
;This means that either can be used to encrypt, and then the other used 
;to decrypt whatever the first encrypted (modulo pq).  
;I still ALWAYS want to keep my decryption key, d, a secret, but if I 
;use it to encrypt a message, then anyone who knows my encryption key 
;can decrypt it.
;
;But my public key is published for anyone to use, so what good is 
;that?  Well, since I encrypt the message with the private part of my 
;key, ONLY I could have encrypted the message.  Anyone who decrypts 
;the message can be sure that I am the one who sent it.  It bears my 
;mark, my seal, my digital signature:

;And so I say this and seal it with my digital signature:
(define MEsignedMessage 11843052787342355840107561998278661057562261921828356217409147849087298)
;And since you use MY key to decrypt it, you know that I sent the ;message.

;Essentially, I pre-set the great wheels of my system so that one turn 
;of the crank, what normally ENCRYPTS a message, now decrypts the 
;message.  Since only I know p and q, the sizes of my wheels,
;only I can preset them like that for a given message.  (It's quite a 
;brilliant idea.)



;GOLDEN TICKET:      EVERLASTINGNESS      A Parting Message  

;It seems as if things change in computer science faster and 
;faster than ever and faster than in any other disciple.

;But some things remain the same.  Some things don't change.

;Some things are more everlasting than a gobstopper.

;The truth is dark; the truth is dire; Slugworth signed this message 
;'ere he did retire.
;
;Decrypt it and know the truth...if you dare.
;
(define MysteryMessage 2370839979106753196216195982082323502092982340075205192327674078375073491969885954650650045657348398248500001519196881697347615416097690377037291704725821294964817605458318529592821265713405030038872967962333362476539593110188502868076178799550093536744832474778134962516472875005869740124782330580919552426867642983086066334539999275032546)

(define SlugworthMod 3646154850295011369707131011438711095400799139943170490872585628683549034362552065955809589514611470241298944167703929337528884908857116141935206466329731087514964112054543019336536216107629523597606330154669196064144182472739556974502462402438903115845725630946428943768540714098264727068026730424033578827886916761701429264950573899186177)

(define SlugworthExp 5041891)

;It may be easier to read if you cut&paste it into WORD or a text editor 
;after running it....



;For those who care to investigate these things and play with them a bit:
;
;Slugworth and I both used Mersenne primes as the basis for our moduli.  
;There is some explanation of them in Rosen (page 261).  
;And, of course, in the Online Encyclopedia of Integer Sequences.
;
;I used 2^107-1 and 2^127-1 to get my 49-character payload.
;
;Slugworth used 2^521-1 and 2^607-1 to get a 235-character payload.
;Almost real RSA-sized primes, except they are extremely famous--the first primes anybody would guess.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (base27 list-of-ints)
  (if (null? list-of-ints)
      0
      (+ (* (car list-of-ints) (expt 27 (- (length list-of-ints) 1))) (base27 (cdr list-of-ints)))))

(define (integers n)
  (if (= 0 n)
      '()
      (cons n (integers (- n 1)))))

(define (sievefast n)
  (nextprimefast n (cdr (reverse (integers n)))))


(define (nextprimefast n sievelist)
  (if (or (null? sievelist) (null? (cdr sievelist)))
      sievelist
      (if (> (car sievelist) (sqrt n))
          sievelist
          (cons (car sievelist) 
                (nextprimefast n (crossout (car sievelist) (cdr sievelist)))))))

(define (crossout prime sievelist)
  (if (null? sievelist)
      '()
      (if (= 0 (modulo (car sievelist) prime))
          (crossout prime (cdr sievelist))
          (cons (car sievelist) (crossout prime (cdr sievelist))))))

(define (prime? n)
  (if (= 2 n)
      #t
      (if (even? n)
          #f
          (ISPRIME? 3 n))))

(define (ISPRIME? d n)
  (if (> d (sqrt n))
      #t
      (if (= 0 (modulo n d))
          #f
          (ISPRIME? (+ 2 d) n))))

(define (find-next-prime n howManyMore)
     (if (= howManyMore 0) '()
         (if (prime? n) (cons n (find-next-prime (+ n 2) (- howManyMore 1))) (find-next-prime (+ n 2) howManyMore))))







;(define inv (inverse exp mod))


(define (convert number base)
  (reverse (Convert number base)))

(define (Convert number base)
  (if (< number base)
      (list number)  
      (cons (modulo number base) (Convert (quotient number base) base))))



(define (bitstring number)
  (Bitstring number))

(define (Bitstring number)
  (if (< number 2)   
      (list number)  
      (cons (modulo number 2) (Bitstring (quotient number 2)))))


(define (modExp b n m)
  (B^NmodM (bitstring n) m 1 (modulo b m)))

(define (B^NmodM nbits m x power)
  (if (= 0 (length nbits))
      x
      (if (= 1 (car nbits))
          (B^NmodM (cdr nbits) m (modulo (* x power) m) (modulo (* power power) m))
          (B^NmodM (cdr nbits) m x (modulo (* power power) m)))))


(define (decode base-27-int)
  (reverse (Decode base-27-int)))

(define (Decode base-27-int)
  (if (= 0 base-27-int)
      '()
      (cons (alpha (modulo base-27-int 27)) (Decode (quotient base-27-int 27)))))

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

