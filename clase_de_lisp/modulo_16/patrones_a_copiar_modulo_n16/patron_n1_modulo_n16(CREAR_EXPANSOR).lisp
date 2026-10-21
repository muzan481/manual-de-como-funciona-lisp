(defun expansor (forma)
 (cond ;;utilizo `cond` para "ejecutar el flujo de condicionales"
 
  ((and (listp forma) (eq (car forma) 'duplicar));; `list` evalua `forma` como es una lista pasa a `eq`
    ;;si el primer elemento que toma `car` es lo mismo que `duplicar`
   (list 'progn (cadr forma) (cadr forma)))
    ;; remplaza `duplicar` por `progn` y usa `cadr` dos veces para tomar todo lo que se encuentre despues de `progn`
    (t forma))) ;; usamos t para culminar el proceso

    (expansor '(duplicar ('print "hola"))) ;;llamamos a nuestra macro