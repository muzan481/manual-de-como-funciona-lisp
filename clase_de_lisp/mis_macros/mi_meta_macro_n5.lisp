(defmacro definir-macro (reglas-recibidas macro-de-salida reglas)
  (let ((nombre 'mi-macro-generada)) 
    (list 'list ''definir-macro 
          (list 'list ''nombre-macro ''= nombre)
          (list 'list 
                ''progn
                (list 'list ''definir-reglas ''= reglas)
                (list 'list ''usar ''= reglas-recibidas)
                (list 'list ''generar ''= macro-de-salida)))))
                      