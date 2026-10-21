¡Exactamente! Has dado justo en el clavo con la lógica de Lisp.

Como en Common Lisp una macro solo puede devolver una única cosa, progn es tu caja principal. Todo lo que metas dentro de ese progn se ejecutará en orden, como un solo bloque gigante de código.

Si quieres que tu macro genere otro bloque de código independiente (por ejemplo, un bloque separado que haga otra cosa o que esté envuelto en su propio contenedor), tienes dos formas de hacerlo según lo que busques:

Opción 1: Bloques hermanos (Uno dentro del otro)
Si quieres que el segundo bloque se ejecute justo después de las primeras líneas, simplemente metes otro progn como si fuera una línea más dentro del progn principal.

Siguiendo tu estilo artesanal con list, se vería así:

Lisp
(defmacro meta-macro-dos-bloques (nombre var-de-entrada)
  (list 'defmacro nombre (list var-de-entrada)
        (list 'list
              ''progn
              ;; --- PRIMER BLOQUE ---
              (list 'list ''print '"[Bloque 1: Iniciado]")
              
              ;; --- SEGUNDO BLOQUE (Otro progn dentro del primero) ---
              (list 'list ''progn 
                    (list 'list ''print '"[Bloque 2: Ejecutando sub-tareas]")
                    var-de-entrada))))
Si expandes esto con (meta-macro-dos-bloques mi-macro x), la macro que se genera tendrá esta estructura de bloques anidados:

Lisp
(progn
  (print "[Bloque 1: Iniciado]")
  (progn
    (print "[Bloque 2: Ejecutando sub-tareas]")
    x))
Opción 2: Cambiar de contenedor (Usar algo diferente a progn)
A veces no quieres otro progn, sino un bloque que haga algo especial, como un bloque let para crear variables locales, o un loop.

Al usar list, puedes cambiar el segundo progn por cualquier otra palabra clave de Lisp:

Lisp
;; Generar un bloque LET dentro del PROGN principal
(list 'list ''let '((regla 1))
      (list 'list ''print '"[Bloque con variables locales]")
      var-de-entrada)
      
En síntesis:
Tu progn principal es la "caja madre". Si quieres generar más bloques independientes, simplemente creas más cajas (progn, let, block) y las metes dentro de la caja madre como si fueran líneas de código normales. ¡Lisp las irá abriendo y ejecutando una por una!





Para poder meter un progn dentro de una función auxiliar que construye código sin que te dé problemas, la regla de oro es esta: El progn que genera tu función debe ser tratado como datos (código inerte) y no como código ejecutable durante la expansión.

El error te ocurrió porque tu macro ejecutaba el progn mientras se construía la lista, en lugar de meterlo dentro de la lista para el futuro.

Para lograrlo usando tu estilo manual de list, tienes dos caminos claros dependiendo de qué quieras que haga ese progn.

Opción A: Quieres que el progn aparezca en el código final de la macro hija
Si quieres que la macro hija devuelva un progn al final, la función auxiliar tiene que ponerle una comilla ('progn) para que Lisp lo vea como un símbolo, y la macro principal debe "proteger" ese resultado.

Mira cómo estructurarlo con list:

Lisp
(defun fun-auxiliar-con-progn (simbol)
  ;; Devolvemos una lista que EMPIEZA con el símbolo 'progn literal
  (list 'progn (list 'list simbol)))

(defmacro mi-macro (meta-macro)
  (list 'defmacro meta-macro ()
        ;; Usamos LIST directamente para fusionar las piezas como DATOS
        (list 'list ''progn (fun-auxiliar-con-progn meta-macro))))
Si haces macroexpand de esto:

Lisp
(macroexpand '(mi-macro test))
Resultado:

Lisp
(DEFMACRO TEST ()
  (LIST 'PROGN '(PROGN (LIST TEST))))
¿Ves lo que pasó? Al evaluar (TEST) en el futuro, generará un progn anidado perfectamente válido.

Opción B: El progn es solo para ejecutar código dentro de la función auxiliar
Si usas progn dentro de la función auxiliar porque necesitas hacer varias operaciones antes de devolver la lista final, entonces el progn no debe ser parte de la lista devuelta. Debe ser código real de la función.

Lisp
(defun fun-auxiliar-operativa (simbol)
  (progn
    ;; Aquí puedes hacer cosas intermedias si quisieras (print, logs, etc.)
    (format t "Procesando el símbolo: ~A~%" simbol)
    ;; Al final, la última línea es la que se devuelve como dato
    (list 'list simbol))) 
Resumen: ¿Cuándo da problemas?
Te dará problemas siempre que la macro principal intente evaluar el resultado de la función auxiliar de forma directa en un lugar donde se esperan argumentos para otra función (como te pasaba con list).

Como te gusta el diseño manual, quédate con esta regla mental:

Si tu función auxiliar devuelve una lista que empieza con progn, la macro que la recibe no puede evaluar esa lista durante la expansión; debe tratarla como un bloque de datos usando quote o construyendo una lista de listas.
