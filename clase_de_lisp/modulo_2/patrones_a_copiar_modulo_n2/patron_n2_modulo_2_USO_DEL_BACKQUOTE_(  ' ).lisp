;;USO DE COMA ( ' ) EN LISP

(list 'un-conjelador-simple ;; usar una comilla lisp evalua el elemento como texto (simbolo) y lo devuelve tal cual pero si recibe parametros de una funcion cuando LISP se "coma" esa comilla el texto "se transforma en variable" es decir recibe un dato
 (list ''un-conjelador-doble)) ;;si quieres que el elemento de la lista siga siendo texto despues de que lisp "se coma" esa coma usa dos comillas


;;TAREA REALIZADA

    (list 'cocinar-plato-principal
     (list ''pollo-asado ''pure))


 ;;USOS DE LA COMILLA:

 (list '' "clase:" 'animal
  (list '' "def-caracteristicas:" 
   (list '' "nombre:" 'leon
    (list '' "habilidad:" 'ruge
     (list '' "invocar-clase:" 'animal ''= 'leon '' ":" 'ruge '' "-->" '' "¡roar!")))))
  
  ;;como se puede ver se puede construir cualquier estructura solo se debe saber como usar list y cuantas comillas quieres que LISP "se coma"

  ;;ACLARACION: la comilla ( ' ) se usa para "medir" el tiempo de ejecucion o la transformacion de los simbolos solo que no se como hacerlo a partir de la tercer comilla ( ' ' ' ) es decir no se que hace lisp con las comillas o en que momento de la compilacion "los va quitando"