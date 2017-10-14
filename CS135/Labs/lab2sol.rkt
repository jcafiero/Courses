#lang eopl

;(quote +)
;'+
;(define pi 3.14159265)
;pi
;'pi
;3
;'3

;PART 1 LISTS
(define firstlist (list 1 2 3))
(define secondlist (list 2 12 22 32 42))
(define shortlist (list 0))
(define thirdlist '(3 33 333 3333))
;(define procs (list + - * /))
(define procedures (list '+ '- '* '/))
;empty
;(define air 3)
;(list 'air)
;(quote ())
;'()
;(null? empty)
;(null? '())
;(null? procedures)
;(equal? firstlist secondlist)
;(length firstlist)
;(length shortlist)
;(length empty)
;(reverse firstlist)
;(reverse shortlist)
;(reverse empty)

;(append shortlist firstlist)
;(append firstlist firstlist)
;(append firstlist firstlist firstlist)
;(append firstlist)
;(append)

;PART 2 car and cdr

;(car firstlist)
;(car secondlist)
;(car procedures)
;(car shortlist)

;(cdr firstlist)
;(cdr secondlist)
;(cdr procedures)
;(cdr shortlist)

(define (last list-of-things) 
  (car(reverse list-of-things)))

(display (last firstlist))

;PART 3 cons
(cons 0 firstlist)
(cons '@ procedures)
(cons 0 '())
(cons firstlist secondlist)
(cons secondlist firstlist)
(cons '() '())

(cons firstlist secondlist)
(append firstlist secondlist)
(length (cons firstlist secondlist))
(length (append firstlist secondlist))
(cons 1 2)

(define (yoda 3-word-list)
  (cons (last 3-word-list) (reverse(cdr (reverse 3-word-list) ))))

(display (yoda '(Do It Now)))

(define happy '(h a p p y))
(define birthday '(b i r t h d a y))
(define ay '(a y))

(define (pig-latin wordlist)
  (append (cdr wordlist) (cons (car wordlist) ay))) 

(display (pig-latin happy))

;PART 4 lists-of-lists
(define student 
  '((IDnumber DegreeSought) (LastName FirstName) (day month year) (class/year ((major) (minor)) GPA) ((number street apt) (city state zip)) (class1 class2 ... classN)))

(car student)
(car (car student))
(caar student)
(cddr student)
(cdar student)
(cadr student)
(cadar student)
(cdddr student)
;(caaar student)
;(caaaaaaaaaaaaaaaar student)

(define (IDnum student-name)   ;this will be a number
  (caar student-name))

(define (lastname student-name) ;this will be just a name
  (caadr student-name))

(define (GPA student-name)     ;this will be a number
  (cddar (cdddr student-name)))

(define (birthdate student-name)  ;this will be a list
  (caddr student-name))
  
(define (address student-name) ;this will be a list of lists
  (car (cddddr student-name)))

(define (class student-name)    ;This will be a number (year)
  (caar (cdddr student-name)))

(define (schedule student-name) ;this will be a list.
  (cdddr (cddr student-name)))

(define (YODA words)
  (append (cddr words) (cons (car words) (list (cadr words)))))
  
(display (YODA '(Do It Now))) 


