(defmacro mi-if-then-else (condicion seccion-then seccion-else)
  "Plantilla de referencia para macros con dos bloques de código independientes.
   Utiliza dos 'progn' internos combinados con ',@' para vaciar las listas."
  `(if ,condicion
       (progn ,@seccion-then)   ; Bloque que se ejecuta si es VERDADERO
       (progn ,@seccion-else))) ; Bloque que se ejecuta si es FALSO

;; =====================================================================
;; === EJEMPLO DE USO (Copiar para probar en el REPL) ===
;; =====================================================================
;;
;; (mi-if-then-else (= x 10)
;;   ((print "X es igual a 10")
;;    (setq x 20))               ; <--- Todo esto es 'seccion-then'
;;
;;   ((print "X no es 10")
;;    (print "Buscando otro...") ; <--- Todo esto es 'seccion-else'
;;    (setq x 0)))