(caddr '(perro gato conejo oso)) ;; caddr descarta el primer elemento de la lista --> (perro gato conejo oso)
                                    ;; nos queda su cdr o resto --> (gato conejo oso) (podemos verlo como una "segunda lista" para terminos practicos)
                                    ;; luego descarta el primer elemento de esa "segunda" lista ---> (gato conejo oso)
                                    ;; nos queda el cdr o resto de esa "segunda" lista --> (conejo oso)
                                    ;; luego toma el primer elemento de esa "tercer" lista de elementos 
                                      ;; y nos queda el resultado final --> "CONEJO"

;;EJEMPLO PARA VISUALIZAR EL FUNCIONAMIENTO DE CADDR:

;;veamoslo como una torre de ropa en donde si yo quiero cualquier prenda que este en la parte media o baja de la torre tengo que quitar los elementos que estan por encima 
(car (cdr (cdr '(sombrero cinturon camisa pantalon)))) ;; cdr descarta el primer elemento 'sombrero' nos queda la lista --> (sombrero cinturon camisa pantalon) yo quiero la camisa asi que debo seguir quitando prendas
                                                       ;; el segundo cdr descarta el primer elemento 'cinturon' nos queda la lista --> (camisa pantalon)
                                                       ;; ahora si llegue hasta la prenda que quiero, como esta al frente de la lista solo debo usar car para tomarla
                                                       ;; y finanmente nos queda el resultado, obtuvimos --> CAMISA

 ;; en sintesis caddr toma el tercer elemento de una lista y lo hace descartando el primer elemento en cada "recorrido"
 ;; o en palabras mas exactas, toma el car del cdr del cdr o dicho de otra forma toma el cabezal de "la tercer lista resultante"      