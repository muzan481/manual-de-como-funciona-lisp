(defpackage :quinta-macro

 (:use :cl)

 (:export :mi-quinta-macro))

 (in-package :quinta-macro)

 ;; 2. Definimos la función que procesará cada elemento
(defun funcion (elemento)
  (format t "Procesando el elemento: ~A~%" elemento))

 (defun funcion-auxiliar (lista-elementos) ;;defino el nombre de mi fucion y sus parametros
  (mapcar(lambda (elemento) ;,llamo a mapcar y lambda (mapcar recorre las formas de lambda y toma los resultados de la transformacion y los pone en una nueva lista)
         `(funcion ,elemento))
                        lista-elementos)) ;;aqui llamo a backquote y creo la plantilla (funcion recibe la nueva lista de formas "elementos" el cuerpo de la macro)

    (defmacro mi-quinta-macro (bloque elementos &body cuerpo) ;;defino el nombre y los parametros de mi macro para crear la plantilla
      `(,bloque ;;dentro pongo las formas de mi macro
       ,@(funcion-auxiliar elementos) ;;llamo a mi funcion con la nueva lista ("elementos" creada por mapcar)
       ,@cuerpo)) ;;llamo al cuerpo de mi macro y uso coma (,) + arroba (@) para desarmarlo y volcarlo en la macro 