Aquí tienes la plantilla definitiva, explicada de forma súper cercana y directa, diseñada para que la guardes en tu editor como tu "hoja de trucos" (cheat sheet).

He estructurado el código respetando al 100% tu estilo: argumentos sueltos en lugar de listas empacadas, usando el contenedor inicial, las evaluaciones intermedias y el &body cuerpo al final.

Lisp
;; =====================================================================
;; PATRÓN DE META-MACRO: "La Fábrica de Macros" (Estilo Inyección)
;; =====================================================================

(defmacro crear-mi-macro (nombre-macro accion-intermedia)
  `(defmacro ,nombre-macro (bloque e-1 e-2 e-3 &body cuerpo)
     `(,bloque
        (,',accion-intermedia ,e-1)
        (,',accion-intermedia ,e-2)
        (,',accion-intermedia ,e-3)
        ,@cuerpo)))
Explicación Línea por Línea (En Cristiano)
(defmacro crear-mi-macro (nombre-macro accion-intermedia)
Aquí empieza la meta-macro (la fábrica). Define una macro que va a recibir dos cosas: el nombre de la macro que quieres inventar (nombre-macro) y la función o acción que quieres que se repita con cada elemento (accion-intermedia).

`(defmacro ,nombre-macro (bloque e-1 e-2 e-3 &body cuerpo)
¡Cuidado aquí! El primer backquote (`) significa: "No ejecutes esto ahora, este es el código de la macro que voy a construir". Usamos ,nombre-macro para inyectar el nombre que elegiste. Los argumentos bloque, e-1, e-2, e-3 y &body cuerpo son exactamente tu estructura habitual.

`(,bloque
Este es el segundo backquote (`). Es un nivel más profundo. Significa: "Cuando la macro que estamos creando sea ejecutada en el futuro, va a escupir este bloque" y, como pusiste ,bloque, se abrirá con la función contenedora que tú decidas (como progn, let, etc.).

(,',accion-intermedia ,e-1)
Esta es la línea más loca visualmente, pero es lógica pura: ,',.

La primera coma (,) se sale del segundo backquote.

La comilla (') congela el valor para el futuro.

La segunda coma (,) se sale del primer backquote para agarrar el valor de accion-intermedia.
En resumen: si en la fábrica pusiste print, esta línea se traduce textualmente como (print ,e-1) cuando se crea la macro final.

(,',accion-intermedia ,e-2) y (,',accion-intermedia ,e-3)
Hacen exactamente lo mismo que la línea anterior, pero aplicando la acción elegida al segundo y tercer elemento de tus argumentos.

,@cuerpo)))
El clásico splice. Agarra toda la lista de expresiones extras que el usuario ponga al final de la macro y las "desparrama" dentro del contenedor principal, justo después de haber procesado los tres elementos. Los tres paréntesis de cierre terminan la macro del futuro, la plantilla de la fábrica y la meta-macro.

Ejemplo de uso rápido para probar en tu REPL
Si usas este patrón para crear una macro que en lugar de imprimir (print) sume uno (incf) a tres variables antes de ejecutar el cuerpo, harías esto:

Lisp
;; 1. Usas la plantilla para fabricar la macro "sumadora"
(crear-mi-macro macro-incrementar incf)

;; 2. Así se usa la macro que acabas de fabricar
(let ((x 1) (y 2) (z 3))
  (macro-incrementar progn x y z
    (format t "~%Variables incrementadas!")
    (format t "~%X: ~A, Y: ~A, Z: ~A" x y z)))
Guarda este patrón en tus notas de configuración. Es la representación más fiel y pura de cómo estructuraste tu lógica de metaprogramación.