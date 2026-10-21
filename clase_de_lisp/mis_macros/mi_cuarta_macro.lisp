(defmacro cuarta-macro ( bloque elemento-1 elemento-2 elemento-3 &body cuerpo)
 `(,bloque
    (print ,elemento-1)
    (print ,elemento-2)
    (print ,elemento-3)
        ,@cuerpo))