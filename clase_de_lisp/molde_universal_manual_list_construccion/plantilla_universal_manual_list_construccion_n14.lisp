Aquí tienes el patrón definitivo para una meta-macro construida 100% con el método manual de construcción de listas (list y cons).

Esta plantilla está diseñada para ser una "Fábrica de Macros Personalizadas". Te va a servir para automatizar tu propia filosofía de cómo deben ser las macros en tu entorno de desarrollo, permitiéndote generar macros que inyecten automáticamente tus propios bloques de código (como logs o firmas).

El Patrón de Código (Meta-Macro Manual de Referencia)
Copia y guarda esta plantilla exactamente en tu editor de código:

Lisp
(defmacro fabrica-de-macros (nombre-nueva-macro variable-entrada)
  (list 'defmacro nombre-nueva-macro (list variable-entrada)
        (list 'list 
              ''progn 
              '(list 'print '"[Macro Auto-Generada: Iniciando]")
              variable-entrada)))
Explicación Línea por Línea (En cristiano y sin rodeos)
Para entender qué hace cada línea, imagina que usas esta meta-macro para crear una macro llamada imprimir-duplicado. La llamarías así: (fabrica-de-macros imprimir-duplicado x).

Vamos a ver qué pasa línea por línea dentro de la fábrica:

1. (defmacro fabrica-de-macros (nombre-nueva-macro variable-entrada)
Aquí defines la macro principal (la fábrica). Le dices que va a recibir dos cosas: el nombre de la macro que quieres inventar (imprimir-duplicado) y el nombre de la variable que usará esa nueva macro (x).

2. (list 'defmacro nombre-nueva-macro (list variable-entrada)
Aquí empezamos a construir a mano la estructura exterior de la nueva macro.

Metemos la palabra literal 'defmacro.

Metemos el nombre que elegiste (imprimir-duplicado).

Metemos la variable dentro de una lista (list variable-entrada) para que se convierta en los argumentos formales de la nueva macro: (x).

Hasta aquí, el código que estamos fabricando va así: (defmacro imprimir-duplicado (x) ...)

3. (list 'list
Aquí abrimos el cuerpo de la nueva macro. Como la macro que estamos creando necesita devolver código estructurado cuando el usuario la use, escribimos la palabra list para indicarle a la nueva macro: "Cuando te ejecuten, tu trabajo será armar una lista con lo que viene a continuación".

4. ''progn
¡Ojo a las dos comillas! Esto es pura construcción manual avanzada. La primera comilla le dice a la fábrica: "No evalúes esto". La segunda comilla se queda pegada para la macro resultante. Significa que la macro final recibirá el símbolo 'progn como texto literal para poder agrupar varias líneas de código.

5. '(list 'print '"[Macro Auto-Generada: Iniciando]")
Esta es la línea que representa "tu estilo". Aquí estamos inyectando una línea de código fija que todas las macros generadas por esta fábrica van a tener. Al ponerle la comilla al frente, le decimos a la fábrica: "Pega este bloque de construcción de código tal cual". Cuando la macro final se ejecute, generará un (print "[Macro Auto-Generada: Iniciando]").

6. variable-entrada)))
Finalmente, ponemos la variable que el usuario le pasará a la macro resultante. Como no tiene comillas, la fábrica buscará el código real que el usuario meta ahí (por ejemplo, un número o una función) y lo colocará al final del bloque progn. Cerramos todos los paréntesis de la construcción manual.

¿Cómo se ve el resultado en tu editor?
Si compilas la plantilla anterior y en tu REPL ejecutas el expansor para ver qué fabricó:

Lisp
(macroexpand-1 '(fabrica-de-macros imprimir-duplicado x))
Verás que la meta-macro hizo su magia manual a la perfección y devolvió este código (que ya es una macro lista para usar):

Lisp
(defmacro imprimir-duplicado (x)
  (list 'progn 
        (list 'print "[Macro Auto-Generada: Iniciando]") 
        x))
¿Por qué este patrón representa "tu forma de ver las macros"?
Porque modificando la línea 5, puedes hacer que todas las macros que crees en el futuro compartan una firma, abran una conexión a una base de datos automáticamente, limpien la pantalla o envuelvan el código en un sistema de manejo de errores (handler-case). ¡Es tu molde personalizado para crear herramientas!