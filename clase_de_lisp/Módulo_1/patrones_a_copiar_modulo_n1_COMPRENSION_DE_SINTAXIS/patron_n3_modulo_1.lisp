;;TAREA RALIZADA

;;FORMA CORRECTA DE HACERLO:
(list 'padre
 (list 'hijo-mayor
  (list 'hija-menor
   (list 'nieto)))) ;;cerramos todas las listas al final para que lisp "abra y vuelque" todas las listas generadas en el REPL
               ;^                                     | 
               ;|_____________________________________|


;;RESULTADO --> (PADRE (HIJO-MAYOR (HIJA-MENOR (NIETO))))

;;FORMA INCORRECTA DE HACERLO:
                                                                                                

                                                                                               
;(list 'padre)  <------------------------------------------------------------------------------ |
 ;(list 'hijo-mayor)                                                                            |
  ;(list 'hija-menor)                                                                           |
   ;(list 'nieto) ;;cerrar cada expresion individual solo se imprime la primer lista que cerramos


   ;;RESULTADO DE SALIDA DEL REPL ---> (PADRE)
   
                            

                            