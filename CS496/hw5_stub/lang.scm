(module lang (lib "eopl.ss" "eopl")                

  ;; language for EXPLICIT-REFS
  
  (require "drscheme-init.scm")
  
  (provide (all-defined-out))

  ;;;;;;;;;;;;;;;; grammatical specification ;;;;;;;;;;;;;;;;
  
  (define the-lexical-spec
    '((whitespace (whitespace) skip)
      (comment ("%" (arbno (not #\newline))) skip)
      (identifier
       (letter (arbno (or letter digit "_" "-" "?")))
       symbol)
      (number (digit (arbno digit)) number)
      (number ("-" digit (arbno digit)) number)
      ))
  
  (define the-grammar
    '((program (expression) a-program)


      (expression
       ("showstore")
       showstore-exp)

      (expression (number) const-exp)
      (expression
       ("-" "(" expression "," expression ")")
       diff-exp)
      
      (expression
       ("zero?" "(" expression ")")
       zero?-exp)

      (expression
       ("if" expression "then" expression "else" expression)
       if-exp)

      (expression (identifier) var-exp)

      (expression
       ("let" identifier "=" expression "in" expression)
       let-exp)   

      (expression
       ("proc" "(" identifier ":" type ")" expression)
       proc-exp)

      (expression
       ("(" expression expression ")")
       call-exp)

      (expression
       ("letrec"
        type identifier "(" identifier ":" type ")" "=" expression
        "in" expression)
       letrec-exp)

      
      ;; new for explicit-refs

      (expression
       ("begin" expression (arbno ";" expression) "end")
       begin-exp)

      (expression
       ("newref" "(" expression ")")
       newref-exp)

      (expression
       ("deref" "(" expression ")")
       deref-exp)

      (expression
       ("setref" "(" expression "," expression ")")
       setref-exp)

      (expression
       ("for" identifier "=" expression "to" expression "(" expression ")")
       for-exp)

      ;;PAIRS
      (expression
       ("pair" "(" expression "," expression ")")
       pair-exp)

      (expression
       ("unpair" "(" identifier "," identifier ")" "=" expression "in" expression)
       unpair-exp)

      (expression
       ("fst" "(" expression ")")
       fst-exp)

      (expression
       ("snd" "(" expression ")")
       snd-exp)
      
      (type
       ("int")
       int-type)
      
      (type
       ("bool")
       bool-type)

      (type
       ("(" type "->" type ")")
       proc-type)

      (type
       ("<" type "*" type ">")
       pair-type)

      (expression
       ("unitE")
       unit-exp)

      (type
       ("unit")
       unit-type)

      (type
       ("ref" "(" type ")")
       ref-type)
      
      ;;LISTS EXPRESSION SECTION
      
      (expression
       ("emptylist" type)
       emptylist-exp)

      (expression
       ("cons" "(" expression "," expression ")")
       cons-exp)

      (expression
       ("null?" "(" expression ")")
       null?-exp)

      (expression
       ("car" "(" expression ")")
       car-exp)

      (expression
       ("cdr" "(" expression ")")
       cdr-exp)

      ;;LISTS TYPE 5.1

      (type
       ("list" "(" type ")")
       list-type)

      ;;TREES EXPRESSIONS SECTION

      (expression
       ("emptytree" type)
       emptytree-exp)

      (expression
       ("node" "(" expression "," expression "," expression ")")
       node-exp)

      (expression
       ("nullT?" "(" expression ")")
       nullT?-exp)

      (expression
       ("getData" "(" expression ")")
       getData-exp)

      (expression
       ("getLST" "(" expression ")")
       getLST-exp)

      (expression
       ("getRST" "(" expression ")")
       getRST-exp)

      ;;TREE TYPE SECTION

      (type
       ("tree" "(" type ")" )
       tree-type)
      
      ))

  ;;;;;;;;;;;;;;;; sllgen boilerplate ;;;;;;;;;;;;;;;;
  
  (sllgen:make-define-datatypes the-lexical-spec the-grammar)
  
  (define show-the-datatypes
    (lambda () (sllgen:list-define-datatypes the-lexical-spec the-grammar)))
  
  (define scan&parse
    (sllgen:make-string-parser the-lexical-spec the-grammar))
  
  (define just-scan
    (sllgen:make-string-scanner the-lexical-spec the-grammar))

  ;;;;;;;;;;;;;;;; type-to-external-form ;;;;;;;;;;;;;;;;

  ;; type-to-external-form : Type -> List
  ;; Page: 243
  (define type-to-external-form
    (lambda (ty)
      (cases type ty
        (int-type () 'int)
        (bool-type () 'bool)
        (proc-type (arg-type result-type)
                   (list
                    (type-to-external-form arg-type)
                    '->
                    (type-to-external-form result-type)))
        (pair-type (left-type right-type)
                   (list
                    (type-to-external-form left-type)
                    '*
                    (type-to-external-form right-type)))
        ;;#4 unit-type & ref-type
        (unit-type () 'unit)
        (ref-type (arg-type)
                  (list 'ref
                   (type-to-external-form arg-type)))
        ;;#5 list-type
        (list-type (arg-type)
                   (list 'list
                         (type-to-external-form arg-type)))

        (tree-type (arg-type)
                   (list 'tree
                         (type-to-external-form arg-type)))
        )))
  
  )
