#lang eopl

; Stephanie Green
; CS 135 Lab 3


; Part 0

(define (element? item list-of-items)
  (if (null? list-of-items)
      #f
      (if (equal? item (car list-of-items))
          #t
          (element? item (cdr list-of-items)))))

(define (make-set list-of-items)
  (cond
    [(null? list-of-items) '()]
    [(element? (car list-of-items) (cdr list-of-items))
     (make-set (cdr list-of-items))]
    [else (cons (car list-of-items) (make-set (cdr list-of-items)))]))

; Part 1

(define (union setA setB)
  (make-set (append setA setB)))

(define (intersection setA setB)
  (if (null? setA) '()
      (if (element? (car setA) setB)
          (cons (car setA) (make-set (intersection (cdr setA) setB)))
          (make-set (intersection (cdr setA) setB)))))

; Part 2

(define (subset? setA setB)
  (cond
    [(null? setA) #t]
    [(element? (car setA) setB)
     (subset? (cdr setA) setB)]
    [else #f]))

(define(set-equal? setA setB)
  (cond
    [(and (null? setA) (null? setB)) #t]
    [else (subset? setA setB)]))

(define (proper-subset? setA setB)
  (cond
    [(and (null? setA) (null? setB)) #f]
    [(equal? setA setB) #f]
    [else (subset? setA setB)]))

; Part 3

(define (set-difference setA setB)
  (make-set (Set-Difference setA setB)))

(define (Set-Difference setA setB)
  (cond
    [(null? setA) '()]
    [(element? (car setA) setB)
     (set-difference (cdr setA) setB)]
    [#t (cons (car setA) (set-difference (cdr setA) setB))]))

(define (sym-diff setA setB)
  (union (make-set (Set-Difference setA setB)) (make-set (Set-Difference setB setA))))

; Part 4

(define (cardinality set)
  (length (make-set set)))

(define (disjoint? setA setB)
  (cond
    [(equal? (intersection setA setB) '()) #t]
    [else #f]))

(define (superset? setA setB)
  (subset? setB setA))

(define (insert element set)
  (make-set (cons element set)))

(define (remove element set)
  (cond
    [(null? set) '()]
    [(equal? element (car set)) (cdr set)]
    [else (cons (car set) (remove element (cdr set)))]))

(define (complement setA)
  (set-difference universe setA))



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