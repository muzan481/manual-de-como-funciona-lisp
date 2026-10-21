(defun macro-mutante (operador lista-de-numeros) ;;paso 1: le paso su nombre a mi funcion y en sus parametros pongo los simbolos que espera
 (let ((codigo-inyectado ;;paso 2: creo un "contenedor local de listas" y se lo paso a let para generarlo
       (cons operador lista-de-numeros))) ;;paso 3: le paso los parametros de mi funcion a cons para construir la lista de parametros de mi funcion

       ;;FLUJO DE TRABAJO: CONS le pasa la lista generada a LET este lo guarda en su "contenedor" ahora CODIGO-INYECTADO guarda OPERADOR LISTA-NUMEROS
       
       ;;(SIMPLIFICACION)
       ;;       |
       ;;       |
       ;;       ⅴ
       ;;(CODIGO-INYECTADO) <-- RECIBE
       ;;                        |
       ;;                        |
       ;;        ________________|
       ;;       |                
       ;;       |
       ;;       |
       ;;       ⅴ
       ;;(OPERADOR LISTA-NUMEROS)
       ;;        |
       ;;        |
       ;;        |
       ;;        ⅴ
       ;;   (TRANSFORMACION INTERNA)
       ;;        |
       ;;        |
       ;;        ⅴ
       ;;(CODIGO-INYECTADO (OPERADOR LISTA-NUMEROS))
       ;;RESULTADO:CODIGO-INYECTADO guada nuestra list
       ;;         |
       ;;         |
       ;;         ⅴ 
       ;;        EVAL recibe --> CODIGO-INYECTADO y lo evalua


        (eval codigo-inyectado))) ;;paso 4: llamo a eval y le paso mi funcion oara que la evalue 