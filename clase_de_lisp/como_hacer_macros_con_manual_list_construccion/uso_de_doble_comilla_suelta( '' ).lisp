¡Sí, absolutamente! Una meta-macro (una macro que genera otra macro) no es más que una fábrica de código que construye otra fábrica de código. Dado que al final del día todo en Lisp son listas dentro de listas, puedes programarla perfectamente usando el método manual de list, cons y append.

Eso sí, prepara tu cerebro, porque programar una meta-macro a mano requiere hacer "malabarismos" con los paréntesis y los niveles de evaluación. Tienes que pensar qué listas se construyen cuando ejecutas la meta-macro y qué listas se construirán cuando el usuario use la macro generada.

Para que lo tengas como referencia en tu editor, aquí tienes el patrón básico de una meta-macro manual, explicada al detalle.

El Escenario: Una fábrica de atajos (crear-atajo)
Queremos hacer una meta-macro que nos permita crear macros de una sola línea rápidamente.
Por ejemplo, si escribimos (crear-atajo borrar-pantalla (clear-values)), queremos que la meta-macro fabrique automáticamente una nueva macro llamada borrar-pantalla.

El Patrón de Código (Meta-Macro Manual)
Copia y guarda esta plantilla en tu editor:

Lisp
(defmacro crear-atajo (nombre-macro codigo)
  (list 'defmacro nombre-macro '()
        (list 'list (list 'quote codigo))))
Explicación línea por línea (Lenguaje coloquial)
Vamos a destripar el código asumiendo que la llamas así: (crear-atajo despedida (print "adiós")).

(defmacro crear-atajo (nombre-macro codigo)
Aquí empieza la meta-macro. Recibe el nombre de la macro que va a inventar (nombre-macro → despedida) y el código que esa macro debe ejecutar (codigo → (print "adiós")).

(list 'defmacro nombre-macro '()
Aquí empezamos a construir la lista que define a la nueva macro.

Metemos el símbolo literal 'defmacro.

Metemos el nombre que eligió el usuario (despedida).

Metemos una lista vacía '() que representará los argumentos de la nueva macro (como es un atajo simple, no lleva argumentos).

Hasta este punto, la lista que estamos armando se ve así: (defmacro despedida () ...)

(list 'list (list 'quote codigo))))
Esta es la parte donde "explota" la cabeza, porque es el cuerpo de la macro que estamos fabricando. La macro que estamos creando necesita devolver el código, no ejecutarlo de inmediato. Así que construimos a mano una instrucción que le dirá a la nueva macro: "Oye, cuando te ejecuten, devuelve este código metido en un list".

(list 'quote codigo) envuelve el código del usuario para que quede congelado como datos: '(print "adiós").

(list 'list ...) mete eso dentro de una llamada a la función list.

Al final, esta línea genera exactamente esto: (list '(print "adiós")).

El resultado en tu editor
Si usas la herramienta que vimos antes (macroexpand-1) para ver qué fabricó tu meta-macro a mano:

Lisp
(macroexpand-1 '(crear-atajo despedida (print "adiós")))
Verás que la meta-macro devolvió una lista perfecta que Lisp entiende como la definición de una nueva macro:

Lisp
(defmacro despedida ()
  (list '(print "adiós")))
¡Y listo! Acabas de crear una macro utilizando una macro que programaste usando únicamente construcción manual de listas. Si ahora ejecutas (despedida), se expandirá a (print "adiós") y se ejecutará en tu consola.