;;; Archivo con la macro que se quiere usar desde otro archivo.

(defmacro mi-suma (a b)
  (list 'progn
        (list 'print (list '+ a b))
        (list '+ a b)))
