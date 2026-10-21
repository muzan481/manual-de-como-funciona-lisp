(defun segunda-macro (formas) ;paso 1: defino mi funcion y le paso mis formas como parametros
                         ;paso 2: creo mi bloque de condicionales
   (if (null formas) nil ;paso 3:dentro de mi bloque llamo a if y null le paso mis formas y llamo a nil para que este bloque devuelva nil si la lista esta vacia
    (let ((cabezal (car formas)) ;paso 4: llamo a let y le paso el nombre del cabezal y en sus parametros llamo a car para que tome el cabezal de la lista
         (cola (cdr formas))) ;paso 5: luego le paso el nombre de la cola y en sus parametros llamo a cdr para que tome el resto de la lista
         (cons `(tomar-primer-elemento ,cabezal) ;paso 6: llamo a cons y luego a backquote y le paso "el nombre de mi plantilla" seguido de una coma detras del cabezal de "mis formas" para que solo se muestren "los datos de mi forma cabezal" y todo lo que va despues de eso  
                (expandir-formas cola))))) ;paso 7: llamo recursivamente a mi funcion y le paso el nombre de "la cola de mi lista" para construir "el resto de mi plantilla" 

(defmacro mi-segunda-macro (&rest formas)
  `(progn 
     ,@(expandir-formas cola)))