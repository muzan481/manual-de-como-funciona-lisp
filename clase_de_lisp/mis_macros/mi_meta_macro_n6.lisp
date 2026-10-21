(defmacro generar-macro (nombre reglas reglas-recibidas macro-de-salida)
 `(disenar-sintaxis
   (nombre-macro = ,nombre)
    (definir-reglas = ,reglas)
     (reglas-recibidas = ,reglas-recibidas)
      (macro-generada = ,macro-de-salida)))
      