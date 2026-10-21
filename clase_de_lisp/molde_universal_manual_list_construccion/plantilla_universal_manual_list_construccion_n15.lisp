¡Aquí tienes! Esta es la plantilla definitiva. Está diseñada como un "esqueleto" para que la copies, la pegues en tu editor y la uses como referencia cada vez que quieras crear una macro de forma manual.

El secreto para que sea fácilmente extensible es construirla de arriba hacia abajo, separando el "cuerpo" de la macro de la estructura principal.

Lisp
(defmacro mi-macro-plantilla (parametro-1 parametro-2 &body el-cuerpo)
  "Plantilla de referencia para crear macros usando solo LIST y QUOTE."
  (let ((lista-de-variables (list (list parametro-1 parametro-2)))
        (codigo-del-cuerpo  (cons 'progn el-cuerpo)))
    
    (list 'let 
          lista-de-variables
          codigo-del-cuerpo)))
Explicación línea por línea (En cristiano)
(defmacro mi-macro-plantilla (parametro-1 parametro-2 &body el-cuerpo)

¿Qué hace?: Aquí defines el nombre de tu macro y qué va a recibir. Los dos primeros son parámetros normales. El &body el-cuerpo es una esponja: absorbe todas las líneas de código que el usuario escriba dentro de la macro y las guarda juntas en una lista.

"Plantilla de referencia..."

¿Qué hace?: Es la documentación. Siempre es buena idea dejar una nota de qué hace tu macro.

(let ((lista-de-variables (list (list parametro-1 parametro-2)))

¿Qué hace?: Aquí empieza el truco para que sea extensible. En lugar de meter todo en una sola línea gigante, usamos un let interno para "fabricar" las piezas de nuestro código por separado. En esta línea, estamos fabricando la lista de variables que necesita un let de Lisp. Si parametro-1 es x y parametro-2 es 10, esto fabrica la lista ((x 10)).

      (codigo-del-cuerpo  (cons 'progn el-cuerpo)))

¿Qué hace?: Aquí preparamos las líneas de código que el usuario metió en la macro. Como queremos que se ejecuten una detrás de otra, les pegamos la palabra progn al principio usando cons. Si el usuario escribió dos líneas de código, esto las transforma en (progn linea1 linea2).

    (list 'let

¿Qué hace?: ¡Aquí empieza el ensamblaje final! Ponemos la palabra literal let al frente de nuestra estructura. Al ponerle la comilla 'let, Lisp sabe que queremos la palabra escrita, no el valor de una variable.

          lista-de-variables

¿Qué hace?: Le pegamos al ensamblaje la pieza de las variables que fabricamos arriba. (Nota que no lleva comilla, porque queremos que Lisp inyecte el contenido de la variable lista-de-variables).

          codigo-del-cuerpo)))

¿Qué hace?: Le pegamos la última pieza (el bloque progn con todo el código del usuario). Cerramos todos los paréntesis y ¡listo! Lisp unirá todo en una sola lista limpia.

¿Por qué este patrón es fácilmente extensible?
Si mañana quieres que tu macro haga algo más complejo, no tienes que romperte la cabeza peleando con los paréntesis de la última línea. Solo tienes que ir al let de arriba y fabricar una nueva pieza.

Por ejemplo, si quisieras agregar un print automático que avise que la macro empezó a ejecutarse, solo tendrías que fabricar esa pieza en el let y meterla en la lista final:

Lisp
;; Así de fácil se extiende:
(defmacro mi-macro-extendida (parametro-1 parametro-2 &body el-cuerpo)
  (let ((lista-de-variables (list (list parametro-1 parametro-2)))
        ;; Fabricamos una pieza nueva:
        (alerta             (list 'print "'Iniciando macro...")) 
        (codigo-del-cuerpo  (cons 'progn el-cuerpo)))
    
    ;; El ensamblaje final sigue siendo plano y limpio:
    (list 'let 
          lista-de-variables
          alerta             ;<-- Inyectamos la pieza nueva aquí
          codigo-del-cuerpo)))
Guarda este patrón en tu editor. Te aseguro que te evitará muchísimos dolores de cabeza contando paréntesis al construir macros a mano.