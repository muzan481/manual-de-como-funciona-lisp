(defmacro plantilla-segura (parametro &body cuerpo)
  "Descripción: El patrón definitivo para macros seguras sin efectos secundarios."
  (let ((var-unica (gensym "VAR-"))) ; 1. Creamos un símbolo único en tiempo de compilación
    `(let ((,var-unica ,parametro))   ; 2. Evaluamos el parámetro UNA sola vez y lo guardamos
       (if ,var-unica
           (progn ,@cuerpo)))))

;; === EJEMPLO DE USO ===
;; (plantilla-segura (calcular-valor-costoso)
;;   (print "El valor es verdadero"))