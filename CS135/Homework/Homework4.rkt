#lang eopl

(define (recursive_sum n)
  (cond
    [(eq? n 0) 0]
    [(eq? n 1) 1]
    [else (+ (recursive_sum (- n 1)) n)]
    )
  )

(define (build-seq start step end)
  (cond
    [(< step 0) '()]
    [(< end start) '()]
    ;[(< start 0) (list start)]
    [else (append (list start) (build-seq (+ start step) step end))]
     )
  )
        