(defmacro plantilla-basica (parametro-uno parametro-dos)
  "Descripción: Inserta los parámetros directamente usando la coma."
  `(bloque-fijo
     (accion-uno ,parametro-uno)
     (accion-dos ,parametro-dos)))

;; === EJEMPLO DE USO ===
;; (plantilla-basica x y) 
;; Expande a: (bloque-fijo (accion-uno x) (accion-dos y))