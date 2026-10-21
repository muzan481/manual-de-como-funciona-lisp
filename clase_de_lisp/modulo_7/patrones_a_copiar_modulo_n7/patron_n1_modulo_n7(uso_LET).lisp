La metáfora de las cajas

Imaginá que tenés cajas de cartón.

Cada caja tiene una etiqueta (el nombre de la variable).



         ┌───────────┐
        ;│ nombre    │ <------------------------------|
         ├───────────┤                               ;|
        ;│ "Juan"    │ <-----------------------------;|--------
         └───────────┘                               ;|       |
                                                     ;|       |
                                                     ;|       |
                                                     ;|       |
Mientras trabajás, podés consultar el contenido       ;|       |
de esas cajas usando su nombre.                       ;|       |
                                                     ;|       |
Cuando terminás, las cajas desaparecen.              ;|       |
                                                     ;|       |
Por eso se llaman variables locales.                 ;|       |
                                                     ;|       |
No existen fuera del let.                            ;|       |
                                                     ;|       |
;        ---------------------------------------------|       |
;        |        --------------------------------------------|
;        |       |
;        |       |
;        ∨       ∨
(let ((caja 'contenido))
       caja)                  ;el cuerpo consulta la variable y
                              ;el LET devuelve el resultado del cuerpo
;         ^                                              |
;         |                                              |
;         |----------------------------------------------|





; FUNCIONAMIENTO:
;
; 1) Creamos una variable local (la caja).
; 2) Asociamos un valor a esa variable.
; 3) El cuerpo del LET puede consultar esa variable por su nombre.
; 4) El valor que devuelve LET es el resultado de evaluar el cuerpo.
;
;                             |                   |
;                             |                   |
;         ---------------------                   |
;         |            ---------------------------|
;         ∨            |
;                      ∨
;  (let ((caja 'contenido))
;         caja)
;         ^
;         |
;         |--- Al evaluar "caja", Lisp busca su valor
;              y devuelve 'contenido.







==================================================
MODELO MENTAL DE let*
==================================================

(let* ((a 5)
       (b (+ a 2))
       (c (+ b 3)))
  c)

No pienso en let* como una instrucción complicada.

Lo imagino como una torre que se construye de arriba hacia abajo.

               ┌───────────────┐
               │ c = (+ b 3)   │
               ├───────────────┤
               │ b = (+ a 2)   │
               ├───────────────┤
               │ a = 5         │
               └───────────────┘

Cada piso representa una variable local.

Cada piso puede consultar los pisos que ya fueron construidos debajo de él.

El intérprete recorre la torre de arriba hacia abajo:

Paso 1
-------
a = 5

Paso 2
-------
b = (+ a 2)

Como a ya existe:

b = 7

Paso 3
-------
c = (+ b 3)

Como b ya existe:

c = 10

==================================================
¿POR QUÉ TODAS LAS VARIABLES ESTÁN DENTRO DEL
MISMO PARÉNTESIS?
==================================================

(
 (a 5)
 (b (+ a 2))
 (c (+ b 3))
)

Ese gran paréntesis NO significa "hacer las sumas".

Significa:

"Esta es la lista de todas las variables locales que quiero crear."

Cada elemento tiene siempre la misma forma:

(nombre valor)

Ejemplos:

(a 5)

(b (+ a 2))

(c (+ b 3))

El intérprete recorre esa lista de arriba hacia abajo.

Como es let*, cada variable puede usar las que ya fueron creadas antes.

==================================================
¿QUÉ DEVUELVE let*?
==================================================

(let* ((a 5)
       (b (+ a 2))
       (c (+ b 3)))
  c)

La torre NO es el resultado.

La torre es un entorno temporal donde existen las variables.

El resultado es el valor de la ÚLTIMA expresión del cuerpo.

En este ejemplo:

c

Como c vale 10,

el resultado final es:

10

==================================================
REGLA MENTAL
==================================================

let*
↓

1. Crear una lista de variables.
2. Construirlas una por una.
3. Cada nueva variable puede usar las anteriores.
4. Ejecutar el cuerpo usando esas variables.
5. Devolver el resultado de la última expresión.
6. El entorno desaparece al terminar.

==================================================