;;Author: Jennifer Cafiero
;;Pledge: I pledge my honor that I have abided by the Stevens Honor System
;;Date: April 12, 2017
;;CS 496 - Homework Assignment 5 

(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the EXPLICIT-REFS language

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")
  (require "store.scm")
  
  (provide value-of-program value-of instrument-let instrument-newref)

  ;;;;;;;;;;;;;;;; switches for instrument-let ;;;;;;;;;;;;;;;;

  (define instrument-let (make-parameter #f))

  ;; say (instrument-let #t) to turn instrumentation on.
  ;;     (instrument-let #f) to turn it off again.

  ;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  ;; Page: 110
  (define value-of-program 
    (lambda (pgm)
      (initialize-store!)               ; new for explicit refs.
      (cases program pgm
        (a-program (exp1)
                   (value-of exp1 (init-env))))))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 113
  (define value-of
    (lambda (exp env)
      (cases expression exp

        (showstore-exp () (write "Store is") (newline)
                       (write (get-store-as-list)) (newline)
                       (write "Env is") (newline)
                       (write (env->list env)) (newline))

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
        (const-exp (num) (num-val num))

        ;\commentbox{ (value-of (var-exp \x{}) \r) = (apply-env \r \x{})}
        (var-exp (var) (apply-env env var))

        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
                  (let ((val1 (value-of exp1 env))
                        (val2 (value-of exp2 env)))
                    (let ((num1 (expval->num val1))
                          (num2 (expval->num val2)))
                      (num-val
                       (- num1 num2)))))
      
        ;\commentbox{\zerotestspec}
        (zero?-exp (exp1)
                   (let ((val1 (value-of exp1 env)))
                     (let ((num1 (expval->num val1)))
                       (if (zero? num1)
                           (bool-val #t)
                           (bool-val #f)))))
              
        ;\commentbox{\ma{\theifspec}}
        (if-exp (exp1 exp2 exp3)
                (let ((val1 (value-of exp1 env)))
                  (if (expval->bool val1)
                      (value-of exp2 env)
                      (value-of exp3 env))))

        ;\commentbox{\ma{\theletspecsplit}}
        (let-exp (var exp1 body)       
                 (let ((val1 (value-of exp1 env)))
                   (value-of body
                             (extend-env var val1 env))))
        
        (proc-exp (var type body)
                  (proc-val (procedure var body env)))

        (call-exp (rator rand)
                  (let ((proc (expval->proc (value-of rator env)))
                        (arg (value-of rand env)))
                    (apply-procedure proc arg)))

        (letrec-exp (reType name bVar bVarType body letrec-body)
                    (value-of letrec-body
                              (extend-env-rec* (list name) (list bVar) (list body) env)))

        (begin-exp (exp1 exps)
                   (letrec 
                       ((value-of-begins
                         (lambda (e1 es)
                           (let ((v1 (value-of e1 env)))
                             (if (null? es)
                                 v1
                                 (value-of-begins (car es) (cdr es)))))))
                     (value-of-begins exp1 exps)))

        (newref-exp (exp1)
                    (let ((v1 (value-of exp1 env)))
                      (ref-val (newref v1))))

        (deref-exp (exp1)
                   (let ((v1 (value-of exp1 env)))
                     (let ((ref1 (expval->ref v1)))
                       (deref ref1))))

        (setref-exp (exp1 exp2)
                    (let ((ref (expval->ref (value-of exp1 env))))
                      (let ((v2 (value-of exp2 env)))
                        (begin
                          (setref! ref v2)
                          (unit-val)))))
        ;;changed from num-val 23 to unit-val

        (for-exp (var lbe ube exp1)
                 (let* ((v1 (value-of lbe env))
                        (varRef (newref v1))
                        (env2 (extend-env var (ref-val varRef) env))
                        (v2 (value-of ube env2)))
                   ( if (<= (expval->num v1) (expval->num v2)) 
                        (do ((i (expval->num v1) (+ i 1)))
                          ((= i (+ 1 (expval->num v2))) )   
                          (begin (setref! varRef (num-val i))
                                 ; (write "value of var")
                                 ; (write (deref varRef))
                                 ; (write (value-of exp1 env2))
                                 (value-of exp1 env2)
                                 )
                          )
                        (num-val 23))))

;;;PAIRS
        ;;HW5 FUNC
        (pair-exp (le re)
                  (pair-val (value-of le env) (value-of re env)))
        
        (fst-exp (e)
                 (let ((val1 (value-of e env)))
                   (expval->fst val1)))
        
        (snd-exp (e)
                 (let ((val2 (value-of e env)))
                   (expval->snd val2)))
        
        ;;HW5 FUNC
        (unpair-exp (id1 id2 exp1 body)
                  (let ((val (value-of exp1 env)))
                    (value-of body
                      (extend-env id1 (expval->fst val) (extend-env id2 (expval->snd val) env)))))
                        

        (unit-exp ()
                  (unit-val))
        ;;#5.1 Lists
        (emptylist-exp (t)
                       (list-val '()))

        (cons-exp (e1 e2)
                  (let ((elem (value-of e1 env)))
                    (list-val (cons elem (expval->list (value-of e2 env))))))
                  

        (null?-exp (e)
                   (if (null? (expval->list (value-of e env)))
                       (bool-val #t)
                       (bool-val #f)))

        (car-exp (e)
                 (car (expval->list (value-of e env))))
                 
        (cdr-exp (e)
                 (list-val (cdr (expval->list (value-of e env)))))

        ;;6.1 Trees

        (emptytree-exp (t)
                       (tree-val (emptytree)))

        (node-exp (v lt rt)
                  (let ((h (value-of v env))
                        (left (value-of lt env))
                        (right (value-of rt env)))
                    (let ((left_t (expval->tree left))
                          (right_t (expval->tree right)))
                      (tree-val (node h left_t right_t)))))
                  
                        
        (nullT?-exp (e)
                    (let ((exp (value-of e env)))
                      (let ((expression (expval->tree exp)))
                      (cases btree expression
                        (node (v lt rt) (bool-val #f))
                        (emptytree (bool-val #t))
                         ))))
                        

        (getData-exp (e)
                     (let ((exp (value-of e env)))
                       (let ((t (expval->tree exp)))
                         (cases btree t
                           (node (v lt rt) v)
                           (else (eopl:error "not a tree or is an empty tree"))))))                    

        (getLST-exp (e)
                    (let ((val (value-of e env)))
                      (let ((t (expval->tree val)))
                        (cases btree t
                          (node (v lt rt) (tree-val lt))
                          (else (eopl:error "not a tree or is an empty tree"))))))

        (getRST-exp (e)
                    (let ((val (value-of e env)))
                      (let ((t (expval->tree val)))
                        (cases btree t
                          (node (v lt rt) (tree-val rt))
                          (else (eopl:error "not a tree or is an empty tree"))))))
                        
        )))

  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; 
  ;; uninstrumented version
  ;;   (define apply-procedure
  ;;    (lambda (proc1 arg)
  ;;      (cases proc proc1
  ;;        (procedure (bvar body saved-env)
  ;;          (value-of body (extend-env bvar arg saved-env))))))

  ;; instrumented version
  (define apply-procedure
    (lambda (proc1 arg)
      (cases proc proc1
        (procedure (var body saved-env)
                   (let ((r arg))
                     (let ((new-env (extend-env var r saved-env)))
                       (when (instrument-let)
                         (begin
                           (eopl:printf
                            "entering body of proc ~s with env =~%"
                            var)
                           (pretty-print (env->list new-env))
                           (eopl:printf "store =~%")
                           (pretty-print (store->readable (get-store-as-list)))
                           (eopl:printf "~%")))
                       (value-of body new-env)))))))


  ;; store->readable : Listof(List(Ref,Expval)) 
  ;;                    -> Listof(List(Ref,Something-Readable))
  (define store->readable
    (lambda (l)
      (map
       (lambda (p)
         (cons
          (car p)
          (expval->printable (cadr p))))
       l)))
 
  )
  


  
