(cadr'(a b c d)) ;; cadr descarta el primer elemento de la lista --> (a b c d)
                 ;; nos queda su cdr o resto --> (b c d) luego toma el primer elemento de esa lista descartando el resto
                 ;; y nos queda el resultado final --> B

            
;;EJERCICIO RESUELTO:

(cadr '(perro gato conejo))

;;aqui cadr descarta el primer elemento de la lista --> (perro gato conejo)
;; nos queda su cdr o resto --> (gato conejo)
;; luego toma el primer elemento de la lista descartando el resto 
;; y nos queda el resultado final --> GATO
;;dicho de otra manera, cadr es equivalente a (car (cdr '(perro gato conejo))) permitiendo tomar el segundo elemento de una lista con una sola funcion



;;EJEMPLO PARA VISUALIZAR EL FUNCIONAMIENTO DE CADR:


;;veamoslo como una torre de ropa en donde si yo quiero cualquier prenda que este en la parte media o baja de la torre tengo que quitar los elementos que estan por encima

(car (cdr '(sombrero cinturon camisa pantalon)))
                                     ;; el primer cdr descarta el primer elemento 'sombrero' nos queda la lista --> (sombrero cinturon camisa pantalon) yo quiero el cinturon asi que debo seguir quitando prendas
                                     ;; ahora si llegue hasta la prenda que quiero, como esta al frente de la lista solo debo usar car para tomarla
                                     ;; y finanmente nos queda el resultado, obtuvimos --> CINTURON

;; en sintesis cadr toma el segundo elemento de una lista y lo hace descartando el primer elemento en cada "recorrido"
;; o en palabras mas exactas, toma el car del cdr o dicho de otra forma toma el cabezal de "la segunda lista resultante" 
                     


