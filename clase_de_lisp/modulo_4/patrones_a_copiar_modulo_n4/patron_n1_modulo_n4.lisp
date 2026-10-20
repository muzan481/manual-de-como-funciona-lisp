(defun fabricar-suma (numero1 numero2) ;;llamamos a defun y le pasamos su nombre y parametros
 (list '+ numero1 numero2)) ;;llamamos a los elementos de la funcion con el simbolo + usamos la comilla suelta para convertir la expresion en un simbolo luego lllamamos a list para que lo ponga en una lista

(fabricar-suma 10 20) ;;llamamos a nuestra funcion y le pasamos datos reales para indicar en que se transforman los simbolos (ya tenemos "la fabrica")

(eval (fabricar-suma 10 20)) ;;llamamos a eval y le pasamos nuestra "fabrica" para que la ejecute y nos de el resultado de la evaluacion --> 30

;;TAREA COMPLETADA:

;; Añadimos una comilla (') antes de cada respuesta para que Lisp sepa que son texto puro
(defun fabricar-selector (condicion)
  (list 'if condicion ''SI-SE-CUMPLE ''NO-SE-CUMPLE)) 
  ;; ¡Ojo a la doble comilla! Significa: "Quiero que el código resultante conserve una comilla".

;; Ahora sí, lo metemos al microondas:
(eval (fabricar-selector '(= 5 5)))