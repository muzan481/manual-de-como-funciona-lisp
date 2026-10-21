(cadddr '(a c b d)) ;; cadddr descarta el primer elemento de la lista
                    ;; nos queda --> (c b d)
                    ;; luego descarta el primer elemento de esta lista resultante
                    ;; nos queda --> (b d)
                    ;; por último descarta el primer elemento de esta nueva lista resultante
                    ;; nos queda --> (d)
                    ;; finalmente toma el primer elemento de esa lista
                    ;; y nos queda el resultado --> D


;; EJEMPLO PARA VISUALIZAR EL FUNCIONAMIENTO DE CADDDR:

;; Veámoslo como una torre de ropa en donde si quiero la cuarta prenda de la torre
;; tengo que quitar las tres prendas que están por encima.

(car (cdr (cdr (cdr '(sombrero cinturon camisa pantalon)))))
;; el primer cdr descarta el primer elemento 'sombrero'
;; nos queda la lista --> (cinturon camisa pantalon)
;;
;; el segundo cdr descarta el primer elemento 'cinturon'
;; nos queda la lista --> (camisa pantalon)
;;
;; el tercer cdr descarta el primer elemento 'camisa'
;; nos queda la lista --> (pantalon)
;;
;; ahora sí llegué hasta la prenda que quiero. Como está dentro de una lista,
;; uso car para tomar el primer elemento de esa lista.
;;
;; nos queda el resultado --> PANTALON


;; En síntesis, cadddr toma el cuarto elemento de una lista
;; descartando el primer elemento en cada recorrido mediante cdr.
;;
;; O, en palabras más exactas, toma el car del cdr del cdr del cdr.
;;
;; Dicho de otra forma:
;;
;; (cadddr lista)
;;
;; es exactamente lo mismo que escribir:
;;
;; (car (cdr (cdr (cdr lista))))