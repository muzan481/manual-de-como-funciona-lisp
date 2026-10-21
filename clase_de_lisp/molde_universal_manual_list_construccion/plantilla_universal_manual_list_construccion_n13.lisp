Aquí tienes los 3 patrones fundamentales de macros construidas con el método manual (list, cons, append). Están diseñados para que funcionen como plantillas (boilerplates) que puedes copiar, pegar y adaptar en tu editor.

Patrón 1: El Envoltorio Simple (list + progn)
Para qué sirve: Sirve cuando quieres crear una macro que reciba unas pocas líneas fijas y las envuelva dentro de un bloque progn para que se ejecuten en orden.

Lisp
(defmacro patron-envoltorio (accion1 accion2)
  (list 'progn 
        accion1 
        accion2 
        (list 'print "'--- Fin del bloque ---")))
Explicación línea por línea (Lenguaje coloquial):
(defmacro patron-envoltorio (accion1 accion2): Aquí defines la macro y le dices que va a recibir exactamente dos cosas (que llamamos accion1 y accion2). Estas "cosas" serán líneas de código que el usuario escriba.

(list 'progn: Empezamos a fabricar la lista final a mano. La primera palabra de nuestra lista será el símbolo literal progn. Usamos la comilla ' para decirle a Lisp: "No ejecutes progn todavía, solo escribe la palabra".

accion1: Metemos en la lista la primera acción que nos pasó el usuario. Como no tiene comilla, Lisp va a pegar el código real que el usuario escribió ahí.

accion2: Hacemos exactamente lo mismo con la segunda acción, la pegamos justo debajo de la primera.

(list 'print "'--- Fin del bloque ---")): Creamos una pequeña sublista a mano que se convertirá en (print '--- Fin del bloque ---) para meter un mensaje automático al final, y cerramos todos los paréntesis.

Patrón 2: El Inyector de Cabecera (cons + progn)
Para qué sirve: Este patrón es perfecto cuando tu macro recibe una cantidad indefinida de líneas de código (&body) y tú solo quieres "inyectarle" un progn al principio de todo ese bloque para que sea válido.

Lisp
(defmacro patron-inyector (&body cuerpo)
  (cons 'progn cuerpo))
Explicación línea por línea (Lenguaje coloquial):
(defmacro patron-inyector (&body cuerpo): Definimos la macro. El truco aquí es &body cuerpo. Esto significa: "Guarda absolutamente todas las líneas de código que el usuario escriba dentro de la macro en una sola lista llamada cuerpo".

(cons 'progn cuerpo)): Aquí ocurre la magia manual más pura. Como cuerpo ya es una lista (por ejemplo, tiene ((print 1) (print 2))), usamos cons para tomar el símbolo literal 'progn y pegárselo al frente. Esto transforma la lista mágicamente en (progn (print 1) (print 2)). ¡Corto, rápido y eficiente!

Patrón 3: El Sándwich de Código (append + list)
Para qué sirve: Se usa cuando recibes un bloque de código del usuario (&body), pero quieres construirle manualmente código extra tanto arriba (cabecera) como abajo (pie de página). Aquí list no nos sirve porque encajaría las listas unas dentro de otras, así que usamos append para fusionarlo todo al mismo nivel.

Lisp
(defmacro patron-sandwich (&body cuerpo)
  (append (list 'progn '(print "-> Iniciando proceso"))
          cuerpo
          (list '(print "-> Proceso terminado"))))
Explicación línea por línea (Lenguaje coloquial):
(defmacro patron-sandwich (&body cuerpo): Definimos la macro y capturamos todas las líneas de código que ponga el usuario dentro de la lista cuerpo.

(append: Le decimos a Lisp: "Voy a pasarte varias listas separadas, por favor júntalas todas borrando los paréntesis externos de cada una para hacer una sola lista plana".

(list 'progn '(print "-> Iniciando proceso")): Esta es nuestra tapa superior del sándwich. Fabricamos una lista que contiene el símbolo 'progn y la línea del mensaje inicial.

cuerpo: Metemos el relleno del sándwich. Es la lista con todo el código original que escribió el usuario. append se encargará de fusionarlo perfectamente debajo del mensaje inicial.

(list '(print "-> Proceso terminado")))): Esta es la tapa inferior. Fabricamos una lista que contiene el mensaje de cierre. Al final, cerramos el append y la macro.

💡 Un tip de oro para tu editor: macroexpand-1
Cuando guardes esto en tu editor y quieras probar qué está construyendo tu macro manualmente, pon la palabra macroexpand-1 antes de usar tu macro.

Por ejemplo, si ejecutas esto en tu REPL o editor:

Lisp
(macroexpand-1 '(patron-sandwich (print "Hola") (print "Mundo")))
Lisp no ejecutará el código, sino que te mostrará en la pantalla el sándwich de listas exacto que construiste a mano. ¡Es la mejor forma de verificar que tus list, cons y append hicieron bien su trabajo!