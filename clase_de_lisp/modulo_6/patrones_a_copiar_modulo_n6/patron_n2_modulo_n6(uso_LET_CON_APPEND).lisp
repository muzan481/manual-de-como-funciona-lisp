(defun mi-antiguo-macro (codigo-usuario) ;;paso creo el nombre de mi funcion y pongo los elementos que recibira
 (let ((codigo-final ;;paso 2 creo un "contenedor local" y se lo paso a LET para que lo genere
  (append '(+) codigo-usuario))) ;;paso 3: llamo a los parametros de mi funcion genero un simbolo con una comilla detras y le paso esta expresion a append para "pegar" los elementos que desee a los simbolos que contiene los parametros que mi funcion recibe

   (eval codigo-final))) ;;paso 4: llamo a eval y le paso mi funcion para ejecutarla

   ;;TAREA REALIZADA:

   ;;ESTO (append '(multiplicar-por) '(5 10 20)) DEVOLVERA ESTO: --> (MULTIPLICAR-POR 5 10 20)