(car '(a b c)) ;;aqui car toma el primer elemento de la lista --> (a)

(cdr '(a b c)) ;;aqui cdr toma la cola de la lista --> (b c)

(car (cdr '(a b c))) ;;aqui cdr toma --> (b c) car toma (a) y hereda el contenido de cdr como b ahora es el cabezal descarta su antiguo dato (a) asi como su herencia (c) y se queda con b --> B

;;EN RESUMEN: si hacemos la lectura de atras hacia adelante (de abajo hacia arriba) cdr toma B C car lo hereda y remplaza su dato actual con el cabezal heredado de cdr

;;TAREA RESUELTA:

(cdr (cdr '(pocion espada escudo))) ;;aqui cdr toma la cola de la lista --> (espada escudo) por lo tanto descartamos el cabezal (pocion) quedandose con esta lista resultante --> (espada escudo) si llamamos a cdr de nuevo este recorre su nueva lista reemplazando el cabezal por la cola de la lista --> (escudo)

;;dicho de manera mas simple se toma una lista y el resultado se transforma en una nueva lista que contiene lo que deseamos




;;para llegar al elemento d de la lista '(a b c d e) haria esto:
  (car (cdr (cdr (cdr '(a b c d e)))))

  ;;el primer cdr descarta el primer elemento de la lista,
  ;; nos queda --> (b c d e)
  
  ;; el segundo cdr descarta el primer elemento de la lista (b c d e)
  ;; nos queda --> (c d e)

  ;; el tercer cdr descarta el primer elemento de la lista (c d e)
  ;; nos queda --> (d e)

  ;; y finalmente el car toma el primer elemento de la lista y descarta el resto de elementos de la lista (d e) 
  ;; nos queda --> d


  ;;EJERCICIO RESUELTO:

 (car (cdr (cdr (cdr '(rojo verde azul amarillo negro)))))