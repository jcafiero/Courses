#lang eopl

;PART 1 map

(define (pig-latin word)
  (cond 
    [(null? word) '()]
    [(equal? (car word) 'q) (append (cddr word) '(q u a y))]
    [else (append (cdr word) (cons (car word) '(a y)))]))

(display (map pig-latin '( (h a p p y) (b i r t h d a y) )))

;PART 2 cond

(define (zerooddelse n)
  (cond [(zero? n) (display "you entered zero!")]
        [(odd? n)  (display "your number is odd")]
        [else (display "your number is even")]))

(define (bmi height weight)
  (cond 
    [(<= height 0) (display "Invalid height entered")]
    [(<= weight 0) (display "Invalid weight entered")]
    [(< (* 704.5 (/ weight (* height height))) 16) (display "You are severely underweight")]
    [(<= (* 704.5 (/ weight (* height height))) 18.5) (display "You are underweight")]
    [(<= (* 704.5 (/ weight (* height height))) 25) (display "You are of normal weight")]
    [(<= (* 704.5 (/ weight (* height height))) 30) (display "You are overweight")]
    [(<= (* 704.5 (/ weight (* height height))) 40) (display "You are obese")]
    [(<= (* 704.5 (/ weight (* height height))) 50) (display "You are morbidly obese")]
    (else (display "How are you alive"))
    ))

(display (bmi 2 0))
(display (bmi 65 125))
(display (bmi 48 150))

;PART 3

(define (build-seq start step end)
  (cond
    [(< step 0) '()]
    [(< end start) '()]
    [(< start 0) (list start)]
    [else (append (list start) (build-seq (+ start step) step end))]
     )
  )
    
(define (arithmetic-prog a_0 difference iNdex)
  (cond
    [(equal? iNdex 0) '()]
    [else (cons a_0 (arithmetic-prog (+ a_0 difference) difference (- iNdex 1)))]
    ))

(display (arithmetic-prog 2 3 5))
(arithmetic-prog 0 1 10)
(arithmetic-prog 0 -1 5)

(define (geometric-prog a_0 ratio iNdex)
  (cond 
    [(equal? iNdex 0) '()]
    [else (cons a_0 (geometric-prog (* a_0 ratio) ratio (- iNdex 1)))]
    ))

(display (geometric-prog 1 10 5))
(geometric-prog 1 2 11)
(geometric-prog 7 -3 5)

(define (sum list-of-nums)
  (cond
    [(equal? list-of-nums '()) 0]
    [else (+ (car list-of-nums) (sum (cdr list-of-nums)))]
    ))
(display (sum '(1 2 3)))

(define (arith-sum a_0 difference iNdex)
  (sum (arithmetic-prog a_0 difference iNdex)))

(display (arith-sum 2 3 5))

(define (geo-sum a_0 difference iNdex)
  (sum (geometric-prog a_0 difference iNdex)))

(display (geo-sum 1 10 5))
;PART 4 Cartesian Product

(define (make-duples item list-of-items)
  (cond 
    [(null? list-of-items) '()]
    [else (cons (cons item (list (car list-of-items))) (make-duples item (cdr list-of-items)))]
    )
  )

(display (make-duples 0 '(1 2 3 4)))

(define (cart-prod setA setB)
  (cond
    [(or (null? setA) (null? setB)) '()]
    [else (append (make-duples (car setA) setB) (cart-prod (cdr setA) setB))]))

(display (cart-prod '(1 2) '(a b c)))