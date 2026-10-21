(defmacro plantilla-con-cuerpo (condicion &body cuerpo)
  "Descripción: Evalúa la condición y ejecuta el cuerpo de código."
  `(if ,condicion
       (progn
         ,@cuerpo))) ; El ,@ quita los paréntesis externos de la lista 'cuerpo'

;; === EJEMPLO DE USO ===
;; (plantilla-con-cuerpo (= x 10)
;;   (print "Hola")
;;   (print "Mundo"))