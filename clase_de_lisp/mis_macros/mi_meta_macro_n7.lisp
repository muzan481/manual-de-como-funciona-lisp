(defmacro definir-macro (parametros &rest cuerpo)
  `(defmacro crear-sintaxis ,parametros
     ,@cuerpo))
