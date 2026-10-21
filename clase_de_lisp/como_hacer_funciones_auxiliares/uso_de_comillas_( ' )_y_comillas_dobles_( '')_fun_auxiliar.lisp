Aplica exactamente igual para la función auxiliar. De hecho, la regla no depende de si estás usando una macro, una meta-macro o una función normal; depende de quién evalúa el código y cuándo.

La diferencia clave es qué devuelve cada estructura:

Una función devuelve un valor o una estructura de datos (como una lista) para que el programa la use.

Una macro devuelve una lista de código para que Lisp la ejecute inmediatamente después.

Como tu función auxiliar (fun-auxiliar) tiene la tarea de construir la lista de código que la macro va a usar, la regla de las comillas se aplica en la función.

Volvamos al código para verlo en acción
Imagina que probamos tu función auxiliar directamente en la REPL (la consola de Lisp), sin meter ninguna macro de por medio.

Si definimos la función usando una sola comilla en un argumento y doble comilla en el otro:

Lisp
(defun fun-auxiliar-test (x y)
  (list 'progn 
        (list 'print 'x)    ; Una sola comilla
        (list 'print ''y))) ; Doble comilla
Si llamamos a la función pasando dos símbolos cualesquiera:

Lisp
(fun-auxiliar-test 'hola 'mundo)
El resultado que te devuelve la función es este:

Lisp
(PROGN 
  (PRINT X) 
  (PRINT 'Y))
¿Qué pasó ahí dentro?
Para X: Al poner una comilla ('x), la función imprimió el símbolo limpio X. Si ese resultado se evalúa más tarde (por una macro), X actuará como una variable.

Para Y: Al poner doble comilla (''y), la función imprimió (QUOTE Y), que Lisp te muestra como 'Y. Si ese resultado se evalúa más tarde, 'Y actuará como un símbolo literal.

En conclusión
La regla de las comillas es una propiedad fundamental de la evaluación en Lisp.

Cualquier función que se encargue de construir listas (como tu función auxiliar) necesita usar esta lógica de comillas para "dibujar" correctamente el código final. La macro simplemente toma ese dibujo que hizo la función y se lo entrega a Lisp para que lo ejecute.