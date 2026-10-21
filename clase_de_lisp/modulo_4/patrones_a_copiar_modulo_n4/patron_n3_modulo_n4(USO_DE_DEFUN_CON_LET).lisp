(defun macro-artesanal (num1 num2) ;;creo mi funcion le paso su nombre y los simbolos a sus parametros
 (let((codigo-fabricado ;;creo mi "lista local" y se la paso a let 
  (list '+ num1 num2))) ;;llamo a list y le paso los simbolos con una coma para "congelarlos" list creara una nueva lista y la guarda en la lista local del let
  
  ;; (TRANSFORMACION)
  ;;        |
  ;;        |
  ;;        ⅴ  
  ;; codigo-fabricado   
  ;;     AHORA ES: --> '+ num1 num2 

   (eval codigo-fabricado))) ;; llamo a eval y le paso mi funcion para que la ejecute

   ;;PROCEDIMIENTO DE EJECUCION
   ;; paso 1:copiar y pegar el codigo en el REPL para cargarlo en el REPL
   ;; paso 2: pongo el nombre de mi funcion en el REPL con datos reales dentro --> (macro-artesanal 4 5)
   ;; RESULTADO DE EJECUCION: --> 9                            