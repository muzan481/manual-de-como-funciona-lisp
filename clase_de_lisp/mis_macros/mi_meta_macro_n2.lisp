
(defmacro mi-meta-macro-n2 ()
  (list ''defmacro 'mi-meta-macro
    (list '' "clase:" 'animal
      (list '' "def-caracteristicas:"
        (list '' "nombre:" 'leon
          (list '' "habilidad:" 'ruge
            (list '' "invocar-clase:" 'animal ''= 'leon ''":" 'ruge ''"-->" ''"¡roar!")))))))