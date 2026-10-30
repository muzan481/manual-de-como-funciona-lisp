;;; Archivo que carga la macro desde el directorio vecino.

(load (merge-pathnames "macros.lisp" *load-truename*))

(format t "Probando la macro~%")
(mi-suma 2 3)
