(module data-structures (lib "eopl.ss" "eopl")

  (require "lang.scm")                  ; for expression?
  (require "store.scm")                 ; for reference?

  (provide (all-defined-out))               ; too many things to list

;;;;;;;;;;;;;;;; expressed values ;;;;;;;;;;;;;;;;

;;; an expressed value is either a number, a boolean, a procval, or a
;;; reference.

  (define-datatype btree btree?
    (emptytree)
    (node
     (v expval?)
     (lt btree?)
     (rt btree?)))

  (define-datatype expval expval?
    (num-val
      (value number?))
    (bool-val
      (boolean boolean?))
    (proc-val 
      (proc proc?))
    (ref-val
      (ref reference?))
    (pair-val
      (fst expval?)
      (snd expval?))
    (unit-val)
    (list-val
     (list (list-of expval?)))
    (tree-val
      (tree btree?))
    )

;;; extractors:

  (define expval->num
    (lambda (v)
      (cases expval v
	(num-val (num) num)
	(else (expval-extractor-error 'num v)))))

  (define expval->bool
    (lambda (v)
      (cases expval v
	(bool-val (bool) bool)
	(else (expval-extractor-error 'bool v)))))

  (define expval->proc
    (lambda (v)
      (cases expval v
	(proc-val (proc) proc)
	(else (expval-extractor-error 'proc v)))))

  (define expval->ref
    (lambda (v)
      (cases expval v
	(ref-val (ref) ref)
	(else (expval-extractor-error 'reference v)))))

  ;;Taken from HW3
  (define expval->list
    (lambda (v)
      (cases expval v
        (list-val (list) list)
        (else (expval-extractor-error 'list v)))))

  ;;Taken from HW3
  (define cons-expval
    (lambda (v xs)
      (let ((ls ((expval->list xs))))
        (cases expval v
          (bool-val (bool) (cons bool ls))
          (num-val (num) (cons num ls))
          (list-val (list) (cons list ls))
        (else (expval-extractor-error 'cons-expval v))))))

  (define expval-extractor-error
    (lambda (variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value)))

;;;;;;;;;;;;;;;; procedures ;;;;;;;;;;;;;;;;

  (define-datatype proc proc?
    (procedure
      (bvar symbol?)
      (body expression?)
      (env environment?)))
  
  (define-datatype environment environment?
    (empty-env)
    (extend-env 
      (bvar symbol?)
      (bval expval?)
      (saved-env environment?))
    (extend-env-rec*
      (proc-names (list-of symbol?))
      (b-vars (list-of symbol?))
      (proc-bodies (list-of expression?))
      (saved-env environment?)))

  ;; env->list : Env -> List
  ;; used for pretty-printing and debugging
  (define env->list
    (lambda (env)
      (cases environment env
	(empty-env () '())
	(extend-env (sym val saved-env)
	  (cons
	    (list sym (expval->printable val))
	    (env->list saved-env)))
	(extend-env-rec* (p-names b-vars p-bodies saved-env)
	  (cons
	    (list 'letrec p-names '...)
	    (env->list saved-env))))))

  ;; expval->printable : ExpVal -> List
  ;; returns a value like its argument, except procedures get cleaned
  ;; up with env->list 
  (define expval->printable
    (lambda (val)
      (cases expval val
	(proc-val (p)
	  (cases proc p
	    (procedure (var body saved-env)
	      (list 'procedure var '... (env->list saved-env)))))
	(else val))))

  ;; expval->fst : ExpVal -> Fst
  ;;HW5 Func

  (define expval->fst
    (lambda (v)
      (cases expval v
        (pair-val (e1 e2) e1)
        (else (expval-extractor-error 'pairFst v)))))

  ;; expval->snd : ExpVal -> Snd
  ;;HW5 Func

  (define expval->snd
    (lambda (v)
      (cases expval v
        (pair-val (e1 e2) e2)
        (else (expval-extractor-error 'pairSnd v)))))

  ;; expval->tree : ExpVal -> Tree
  ;;HW5 Func
  
  (define expval->tree
    (lambda (v)
      (cases expval v
        (tree-val (tree) tree)
        (else (expval-extractor-error 'tree v)))))

)
