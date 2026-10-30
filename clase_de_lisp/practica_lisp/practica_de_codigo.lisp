(let* ((args '(lista-1 lista-2 lista-3))
        (primer-extraccion (car args))
         (segunda-extraccion (cdr args))
           (imprimir (cons primer-extraccion segunda-extraccion)))
             imprimir)
        

(let* ((mensaje 'x)
       (imprimir (list 'print mensaje)))
  imprimir)
          

(list 
    'progn            
         (list 'print 'x)
          (list 'print  'x))


(defun mi-macro (mensaje)   
 (list 
    'progn            
        (list 'list 
         (list 'quote mensaje)
          (list 'quote  mensaje))))                   
          
          (eval (mi-macro '(x)))   



(defun datos-de-macro (datos)
      (let* ((args (list datos))
       (variable (cons 'variable-1 datos))
        (salida (list args variable)))
           salida))      

(datos-de-macro '(+ 2 2))

(let* ((elementos (list 2 2))
        (suma (list 4))
         (resultado (append elementos suma))
          (total (reduce #'+ resultado)))
           total)

(defun operacion (elementos)
 (let* ((elemento-1 '(4))
        (elemento-2 '(5))
        (construccion (append elemento-1 elemento-2))
        (anadido (cons '+ construccion)))
        (cons anadido elementos)))

      (defun list-de-nums (numeros)
  (let* ((elemento-1 numeros)
         (elemento-2 numeros)
         (union-elementos (append elemento-1 elemento-2))
         (resultado union-elementos))
    resultado))

(list-de-nums '(3 1 2))



(defun calculo (num)
 (let* ((num-1 num)
        (num-2 num)
        (num-3 num)
        (union-de-nums (append num-1 num-2 num-3))
        (suma (reduce #'+ union-de-nums)))
          suma))

          (calculo '(5))


(defun mi-funcion (datos)
 (let* ((objt-1 datos)
        (objt-2 datos)
        (construccion (append objt-1 objt-2))
        (suma (reduce #'+ construccion))
        (imprimir (list suma)))

                 imprimir))


    (mi-funcion '(5 5))


    (let* ((forma (list 'operador))
                  (args (list 'arg-1 'arg-2))
                  (salida (append forma args)))
                              salida)

    (let* ((forma '(mi-dividir numerador denominador))
            (extraer (car forma))
            (operador (list extraer))
            (numerador (list 'args-1))
            (denominador (list 'args-2))
            (salida (append operador numerador denominador)))
                    salida)
            
  
  (let* ((forma '(mi-dividir numerador denominador))
         (extraccion (cdr forma))
         (agregar (cons '/ extraccion))
         (salida (list agregar)))
           salida)


(let* ((forma '(mi-dividir numerador denominador)) 
               (extraccion (cdr forma)) 
               (agregar (list '/)) 
               (reconstruccion (append agregar extraccion))) 
                                reconstruccion)




    (let* ((forma '(mi-multiplicar a b))
           (extraccion (cdr forma))
           (agregar (cons '* extraccion)))
             agregar)
                 
(list
  'progn
     (list 'print "hola" )
      (list 'print "hola"))


    
(let* ((form '(mi-print-doble "hola"))
       (extraccion (cdr form))
       (cons-form-1 (cons 'print extraccion))
       (salida (cons 'progn (cons 'print (cons '"hola" cons-form-1)))))
         salida)



(let* ((form '(mi-print-doble "hola"))
       (extraccion (cdr form))
       (cons-form-1 (cons 'progn (cons 'print (cons '"hola" (cons 'print extraccion))))))
         cons-form-1)


    
(let* ((form '(mi-print-doble "hola"))
       (extraccion (cdr form))
       (cons-form-1 (cons 'print extraccion))
       (salida (cons 'progn (cons 'print (cons '"hola" cons-form-1)))))
         salida)



(let* ((form '(mi-print-doble "hola"))
       (extraccion (cdr form))
       (cons-form-1 (cons 'print extraccion))
       (cons-form-2 (cons '"hola" cons-form-1))
       (cons-form-3 (cons 'print cons-form-2))
       (salida (cons 'progn cons-form-3)))
         salida)



(let* ((form '(mi-print-doble "hola"))
       (extraccion (cdr form))
       (primer-print (list 'print extraccion))
       (segundo-print (list '(print "hola")))
       (union-print (append primer-print segundo-print))
       (anadido (list 'progn union-print)))
         anadido)







  (list
  'progn
     (list 'print "hola" )
      (list 'print "hola"))




 (let ((tabla
       '((mi-suma expansion-suma)
         (mi-resta expansion-resta)
         (mi-producto expansion-producto)
         (mi-imprimir expansion-imprimir))))
  (car tabla))


  (let ((tabla
       '((mi-suma expansion-suma)
         (mi-resta expansion-resta)
         (mi-producto expansion-producto)
         (mi-imprimir expansion-imprimir))))
  (cdr tabla))






(let ((tabla
       '((mi-suma expansion-suma)
         (mi-resta expansion-resta)
         (mi-producto expansion-producto)
         (mi-imprimir expansion-imprimir))))
  (cadr (car tabla)))



(defun expansion-suma (forma)
        
 (let* ((construccion-1 (list forma))
        (extraccion (cdr construccion-1))
        (construir-elemento-1 (cons 'b extraccion))
        (construir-elemento-2 (cons 'a construir-elemento-1))
        (anadido (cons '+ construir-elemento-2)))
anadido))

(expansion-suma 'mi-suma)





(defun expansion-suma-2 (forma)
 (let* ((construccion-1 (cdr forma))
        (anadido (cons '+ construccion-1)))
 anadido))


 (expansion-suma '(mi-suma a b))



(defun fun-suma (forma)
 (let* ((op '+)
        (arg-1 (cadr forma))
        (arg-2 (caddr forma)))
        (list op arg-1 arg-2)))


 

(defun convertir-suma (forma)
 (cons '+ (cdr forma))) 

(convertir-suma '(suma 10 20))
   



;;forma-1
(defun construir-resta (forma)
 
 (list '-  (cadr forma) (caddr forma))


 (construir-resta '(resta 10 4)))

 ;;forma-2

 (defun macro-resta (forma)
  (let* ((extraccion-1 (cdr forma))
         (anadido (cons '- extraccion-1))
         (salida (list anadido)))
  salida))

  (macro-resta '(resta a b))

  ;;forma-3

  (defun forma-resta (forma)
   (let* ((extraccion-1 (cadr forma))
          (extraccion-2 (caddr forma))
          (lista-1 (list extraccion-1))
          (lista-2 (list extraccion-2))
          (unir (append lista-1 lista-2))
          (anadido (cons '- unir))
          (salida (list anadido)))
     salida))
   
   (forma-resta '(resta a b)) 

;;forma-4
(defun crear-resta (forma)
 (cons '- forma))

 (crear-resta '(a b))
  

  (defun rest-ar (forma)
   (let* ((extraccion-1 (cadr forma))
          (extraccion-2 (caddr forma))
          (unir (append (list extraccion-1) (list extraccion-2)))
          (anadido (cons '- unir))
          (anidado (list anadido)))
     anidado))

  (rest-ar '(resta a b))

  (defun sumas (forma)
   (list 'print
    (cons '+ forma)))
    

   (sumas '(5 4))

   (defun macro-improvisada (forma)
    (cons 'setq  (cons 'x forma)))
                     
       

(macro-improvisada '(20))

(defun macro-improvisada-2 (forma)
 (list 'print (caddr forma)))
                     
       

(macro-improvisada-2 '(setq x 10))

(cadr '(defun suma (a b) (+ a b)))

(caddr '(defun suma (a b) (+ a b)))

(cdr (cdr (cdr '(defun suma (a b) (+ a b)))))

(defparameter mi-codigo (list '+ 10 20))

(eval mi-codigo)

(let* ((expresion '(* 5 6))
       (operador (car expresion))
       (resto (cdr expresion))
       (unir (cons operador resto))
       (salida (list unir)))
     salida)

     (let* ((expresion '( * 5 6))
           (operador (car expresion))
           (resto (cdr expresion)))
           (list operador (car resto) (cadr resto)))

(defun transformar-cuadrado (forma)
 (let* ((expresion (cadr forma)))
        (list '*  '5 expresion)))


        

(eval (transformar-cuadrado '(cuadrado 5)))              


(defun transformar-cuadrado-de-8 (forma)
 (let* ((expresion (cadr forma)))
        (list 'expresion expresion))) ;;para que funcione con cualquier numero debemos pasarle 2 veces la variable `expresion` a list


        

(eval (transformar-cuadrado '(cuadrado 8)))              

(defun cuadrado-9 (forma)
 (let* ((expresion (cadr forma)))
        (cons '* (cons expresion (cons expresion nil))))) 

(eval (cuadrado-9 '(cuadrado 9))) 

(defmacro mi-cuadrado (x) (cons '\* (cons x (cons x nil))))

(mi-cuadrado (+ 2 3))

(defun multiplicacion (forma)

(let* ((temp (cadr forma)))
       (list (list 'temp e))
       (list '* temp))
      
      (eval (multiplicacion '(multiplicacion 9)))

       (list 
         'progn 
           (list 'let)
             'progn
               (list '(temp e))
                (list '(* temp temp))))


(list
  'progn
     (list 'print "hola" )
      (list 'print "hola"))


(defun transformar-cuadrado-seguro (forma) 
 (let ((e (cadr forma)))
  (list 'let 
        (list (list 'temp e)) 
        (list '\* 'temp 'temp))))

(transformar-cuadrado-seguro '(cuadrado (progn (print "Hola") 5)))

(eval (transformar-cuadrado-seguro '(cuadrado (progn (print "Hola") 5))))

;; version 1 incorrecta por lista de salida anidada o con parentesis dobles: (+ (2 3))
(let* ((expr '(+ 2 3)))
       (list (car expr) (cdr expr)))

;; version 2 correcta: lista de salida "limpia"  sin parentesis dobles: (+ 2 3) 
(let* ((expr '(+ 2 3)))
       (cons (car expr) (cdr expr)))

(cdr *mi-lista*)

(let* ((expr '(+ 2 3)))
       (list (cadr expr)))


(car *mi-lista*)
(cdr *mi-lista*)
(defparameter *mi-lista* '(a b c d))


(cadr *mi-lista*)
(cons 'inicio *mi-lista*)