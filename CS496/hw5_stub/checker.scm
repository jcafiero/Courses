(module checker (lib "eopl.ss" "eopl")

  (require "drscheme-init.scm")
  (require "lang.scm")

  (provide type-of type-of-program)

  ;; check-equal-type! : Type * Type * Exp -> Unspecified
  ;; Page: 242
  (define check-equal-type!
    (lambda (ty1 ty2 exp)
      (when (not (equal? ty1 ty2))
        (report-unequal-types ty1 ty2 exp))))

  ;; report-unequal-types : Type * Type * Exp -> Unspecified
  ;; Page: 243
  (define report-unequal-types
    (lambda (ty1 ty2 exp)
      (eopl:error 'check-equal-type!  
          "Types didn't match: ~s != ~a in~%~a"
          (type-to-external-form ty1)
          (type-to-external-form ty2)
          exp)))

  ;;;;;;;;;;;;;;;; The Type Checker ;;;;;;;;;;;;;;;;
  
  ;; type-of-program : Program -> Type
  ;; Page: 244
  (define type-of-program
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1) (type-of exp1 (init-tenv))))))

  ;; type-of : Exp * Tenv -> Type
  ;; Page 244--246
  (define type-of
    (lambda (exp tenv)
      (cases expression exp

        ;; \commentbox{\hastype{\tenv}{\mv{num}}{\mathtt{int}}}
        (const-exp (num) (int-type))

        ;; \commentbox{\hastype{\tenv}{\var{}}{\tenv{}(\var{})}}
        (var-exp (var) (apply-tenv tenv var))

        ;; \commentbox{\diffrule}
        (diff-exp (exp1 exp2)
          (let ((ty1 (type-of exp1 tenv))
                (ty2 (type-of exp2 tenv)))
            (check-equal-type! ty1 (int-type) exp1)
            (check-equal-type! ty2 (int-type) exp2)
            (int-type)))

        ;; \commentbox{\zerorule}
        (zero?-exp (exp1)
          (let ((ty1 (type-of exp1 tenv)))
            (check-equal-type! ty1 (int-type) exp1)
            (bool-type)))

        ;; \commentbox{\condrule}
        (if-exp (exp1 exp2 exp3)
          (let ((ty1 (type-of exp1 tenv))
                (ty2 (type-of exp2 tenv))
                (ty3 (type-of exp3 tenv)))
            (check-equal-type! ty1 (bool-type) exp1)
            (check-equal-type! ty2 ty3 exp)
            ty2))

        ;; \commentbox{\letrule}
        (let-exp (var exp1 body)
          (let ((exp1-type (type-of exp1 tenv)))
            (type-of body
              (extend-tenv var exp1-type tenv))))

        ;; \commentbox{\procrulechurch}
        (proc-exp (var var-type body)
          (let ((result-type
                  (type-of body
                    (extend-tenv var var-type tenv))))
            (proc-type var-type result-type)))

        ;; \commentbox{\apprule}
        (call-exp (rator rand) 
          (let ((rator-type (type-of rator tenv))
                (rand-type  (type-of rand tenv)))
            (cases type rator-type
              (proc-type (arg-type result-type)
                (begin
                  (check-equal-type! arg-type rand-type rand)
                  result-type))
              (else
                (report-rator-not-a-proc-type rator-type rator)))))

        ;; \commentbox{\letrecrule}
        (letrec-exp (p-result-type p-name b-var b-var-type p-body
                      letrec-body)
          (let ((tenv-for-letrec-body
                  (extend-tenv p-name
                    (proc-type b-var-type p-result-type)
                    tenv)))
            (let ((p-body-type 
                    (type-of p-body
                      (extend-tenv b-var b-var-type
                        tenv-for-letrec-body)))) 
              (check-equal-type!
                p-body-type p-result-type p-body)
              (type-of letrec-body tenv-for-letrec-body))))

       (showstore-exp ()
              (eopl:error "not implemented!"))

        (begin-exp (e exps) (eopl:error "not implemented!"))
        
       (newref-exp (e)
                   (let ((val (type-of e tenv)))
                     (ref-type val)))
        
      (deref-exp (e)
                 (let ((val (type-of e tenv)))
                   (cases type val
                     (ref-type (i) i)
                     (else (eopl:error "deref only accepts refs")))))
        
      (setref-exp (le re)
                 (let ((val (type-of le tenv)))
                   (cases type val
                     (ref-type (i) (if (equal? i (type-of re tenv))
                                       (unit-type)
                                       (eopl:error "types are wrong! :( " )))
                     (else (eopl:error "deref only accepts refs")))))
                    

      (for-exp (id lb up body) (eopl:error "not implemented!"))

        ;;4.X Pair Typing Rules
        
        (pair-exp (le re)
                  (pair-type (type-of le tenv) (type-of re tenv)))

        (fst-exp (e)
                 (let ((ty (type-of e tenv)))
                   (cases type ty
                     (pair-type (fstt sndt) fstt)
                     (else (eopl:error "type-of: argument to fst not a product type!")))))

        (snd-exp (e)
                 (let ((ty (type-of e tenv)))
                   (cases type ty
                     (pair-type (fstt sndt) sndt)
                     (else (eopl:error "type-of: argument to snd not a product type!")))))

        (unit-exp ()
                  (unit-type))
        
        (unpair-exp (id1 id2 exp1 body)
                    (let ((exp2 (type-of exp1 tenv)))
                      (cases type exp2
                        (pair-type (le re) (type-of body
                                  (extend-tenv id1 le (extend-tenv id2 re tenv))))
                        (else (eopl:error "type-of: argument to unpair not a pair type!")))))

        ;;5.2: List Typing Rules
        
        (emptylist-exp (ty)
                     (list-type (type-of ty tenv)))

        (cons-exp (e1 e2)
                  (let ((val (type-of e2 tenv)))
                   (cases type val
                     (list-type (e_2) (if (equal? e_2 (type-of e1 tenv))
                                       (list-type e_2)
                                (eopl:error "e2 is not a list and cannot be cons'ed" )))
                     
                     (else (eopl:error "cons needs a list and a variable to check properly")))))

        (null?-exp (e)
                   (let ((val (type-of e tenv)))
                     (cases type val
                       (list-type (cat)
                                  (bool-type))
                       (else (eopl:error "error not of list-type")))))
                                            

        (car-exp (e)
                 (let ((a (type-of e tenv)))
                   (cases type a
                     (list-type (dog)
                                dog)
                     (else (eopl:error "car-exp needs input of list-type")))))


        (cdr-exp (e)
                 (let ((ist (type-of e tenv)))
                   (cases type ist
                     (list-type (bird)
                                (list-type bird))
                     (else (eopl:error "cdr-exp needs input of list-type")))))

        ;; 6.2: Tree Typing Rules
        
        (emptytree-exp (ty)
                       (tree-type ty)) ;;(type-of ty tenv)

        (node-exp (v lt rt)
                  (let ((var (type-of v tenv))
                        (left (type-of lt tenv))
                        (right (type-of rt tenv)))
                        (cases type left
                          (tree-type (t) (cases type right
                                           (tree-type (t2) (if (equal? t t2)
                                                              (if (equal? t2 var)
                                                                  (tree-type t2)
                                                                  (eopl:error "Can't mix types of trees"))
                                                              (eopl:error "can't mix types of trees")))
                                           (else (eopl:error "Right side needs to be a tree type"))))
                          (else (eopl:error "Left side needs to be a tree type")))))
                   
                                           

        (nullT?-exp (e)
                    (let ((val (type-of e tenv)))
                     (cases type val
                       (tree-type (dog)
                                  (bool-type))
                       (else (eopl:error "Error: input not of tree-type")))))

        (getData-exp (e)
                     (let ((a (type-of e tenv)))
                       (cases type a
                         (tree-type (dog)
                                    dog)
                         (else (eopl:error "Error: input needs to be of tree type")))))

        (getLST-exp (e)
                    (let ((le (type-of e tenv)))
                      (cases type le
                        (tree-type (dog)
                                   (tree-type dog))
                        (else (eopl:error "Error: the left tree is not of tree-type")))))

        (getRST-exp (e)
                    (let ((re (type-of e tenv)))
                      (cases type re
                        (tree-type (dog)
                                   (tree-type dog))
                        (else (eopl:error "Error: the right tree is not of tree-type"))))))))
      

        
    
  (define report-rator-not-a-proc-type
    (lambda (rator-type rator)
      (eopl:error 'type-of-expression
        "Rator not a proc type:~%~s~%had rator type ~s"   
           rator 
           (type-to-external-form rator-type))))

  ;;;;;;;;;;;;;;;; type environments ;;;;;;;;;;;;;;;;
    
  (define-datatype type-environment type-environment?
    (empty-tenv-record)
    (extended-tenv-record
      (sym symbol?)
      (type type?)
      (tenv type-environment?)))
    
  (define empty-tenv empty-tenv-record)
  (define extend-tenv extended-tenv-record)
    
  (define apply-tenv 
    (lambda (tenv sym)
      (cases type-environment tenv
        (empty-tenv-record ()
          (eopl:error 'apply-tenv "Unbound variable ~s" sym))
        (extended-tenv-record (sym1 val1 old-env)
          (if (eqv? sym sym1) 
            val1
            (apply-tenv old-env sym))))))
  
  (define init-tenv
    (lambda ()
      (extend-tenv 'x (int-type) 
        (extend-tenv 'v (int-type)
          (extend-tenv 'i (int-type)
            (empty-tenv))))))

  )
