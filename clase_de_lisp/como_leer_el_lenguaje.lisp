La sangría (o indentation en inglés) es el espacio en blanco que dejamos a la izquierda de una línea de código.

En la mayoría de los lenguajes, la sangría sirve solo para que el código se vea ordenado. Pero en Lisp, la sangría es tu mapa de navegación. Reemplaza por completo la necesidad de contar paréntesis ). Te dice de un solo vistazo qué tan "profundo" estás dentro del árbol de código.

Para identificarla visualmente, debes entrenar tu ojo para ver columnas verticales imaginarias en lugar de filas horizontales.

El Patrón Visual de la Sangría
Cuando abres una expresión en una línea y la continúas en la siguiente, la sangría te alinea los elementos que tienen la misma jerarquía. Mira este contraste:

❌ Cómo NO debes leer Lisp (Leyendo de izquierda a derecha buscando el cierre):
Lisp
(defun mi-funcion (x) (let ((y (+ x 5))) (print y))) ; ¡Un dolor de cabeza!
Cómo SÍ debes leer Lisp (Leyendo en cascada por columnas):
Lisp
(defun mi-funcion (x)
  (let ((y (+ x 5)))
    (print y)))
📋 Patrón para copiar a mano 1: La Regla de la Alineación
Copia este bloque prestando atención a cómo el espacio en blanco empuja el código hacia la derecha a medida que entramos a una estructura más profunda.

Lisp
(defun procesar-datos (a b)
  (print a)                    ; Columna 1: Primer paso al mismo nivel
  (print b)                    ; Columna 1: Segundo paso al mismo nivel
  (let ((resultado (+ a b)))   ; Columna 1: Entramos a una sub-estructura...
    (print resultado)))        ; Columna 2: Esto está DENTRO del 'let'. 
                               ; Nota las 4 posiciones de espacio a la izquierda.
📋 Patrón para copiar a mano 2: El "Bloque de Cierre" Virtual
En Lisp, los paréntesis de cierre ) no se ponen en una línea limpia abajo como las llaves {} en otros lenguajes. Se acumulan al final de la última instrucción. Tu ojo debe rastrear la vertical para saber qué se está cerrando.

Lisp
(cond 
  ((= a 1) (print 'uno))      ; Fíjate en la alineación de las condiciones
  ((= a 2) (print 'dos))      ; Todas empiezan exactamente en la misma columna
  (t       (print 'otro)))    ; Este último ')' cierra el 'print', el 't' y todo el 'cond'
                              ; No los cuentes, la línea vertical te dice que el 'cond' terminó aquí.
El Truco de los Pioneros:
Cuando el código está bien sangrado, si pones el dedo sobre el primer paréntesis de (let, bajas verticalmente en línea recta: donde dejes de ver código que empiece en esa columna, ahí es donde conceptualmente "termina" esa estructura. Los paréntesis acumulados al final ))) solo están ahí para avisarle al compilador, no a tu cerebro.

¿Se entiende mejor cómo la sangría te dibuja el mapa del código sin mirar los paréntesis? Si es así, ¡estamos listos para el Módulo 1!