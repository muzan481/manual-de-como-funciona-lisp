;;METAFORA:
;; me gusta ver el funcionamiento de lisp como "un arbol genialogico de datos" al estilo matrioska

(+ (* 2 5) ;;ahora la hija del medio recibe la herencia de su hermana y se la pasa a la hija menor (el resultado final de la ejecucion) hija menor: --> 24
    (- 20 10) ;; ambos tienen una hija (el resultado) la mayor de la familia
     (/ 100 25)) ;;los genes del padre (el resultado) son tomados por la madre 
 
 ;;MODIFICACION DEL CODIGO:

 (+ (* 2 5) ;;ahora la hija del medio recibe la herencia de su hermana y se la pasa a la hija menor (el resultado final de la ejecucion) hija menor: --> 2520
     (- 20 10) ;; ambos tienen una hija (el resultado) la mayor de la familia
      (* 100 25)) ;;los genes del padre (el resultado) son tomados por la madre 
;      ^
;      |
;      |
   ;;MODIFICACION

;ejemplo extra:

;;TAREA REALIZADA:

(+(* 3 3)
 (* 10 10))
; ^
; |
; MODIFICACION