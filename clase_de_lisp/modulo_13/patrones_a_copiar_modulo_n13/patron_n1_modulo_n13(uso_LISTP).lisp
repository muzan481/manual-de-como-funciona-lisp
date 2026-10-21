;;listp revisa si un objeto es una lista, devuelve (T) TRUE T (VERDADERO) ejemplo:

(listp '(1 2 3)) ;; devuelve T (TRUE)

(listp 25) ;; devuelve NIL (FALSO), ya que 25 es un numero, no una lista

(listp "hola") ;; devuelve NIL (FALSO), YA QUE "hola", es un simbolo, no una lista

(listp a) ;; devuelve NIL (FALSO), ya que A no es una lista, es un atomo

;; en sintesis, list verifica y invalida (devuelte nil), a todo lo que no sea una lista, ejemplo: atomos (caracteres), numeros y textos, y devuelve T (TRUE) a todo lo que sea una lista litetal (lista con apostrofe (('))), ya sea vacia o con elementos.