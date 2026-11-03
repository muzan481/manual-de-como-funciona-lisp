**`LAMBDA`** define una receta que recibe entradas (los parámetros) y te devuelve el resultado de procesarlas (el cuerpo).

Para confirmar que la tienes totalmente dominada, analiza este codigo y responde a las preguntas que se plantean:

```lisp
((lambda (a b) (+ a b)) 3 4)
```

1. ¿Qué valor recibe **`a`**?
2. ¿Qué valor recibe **`b`**?
3. ¿Cuál es el **resultado final** que devuelve?


En la definición estándar y básica de **`LAMBDA`**, **la cantidad de parámetros y de valores debe coincidir exactamente (1 a 1)**. Si la función define 3 parámetros, debes pasarle exactamente 3 valores.

### ¿Por qué funciona así?

Cuando Lisp evalúa la aplicación de una función `LAMBDA`, realiza un proceso de **ligadura de variables** (*binding*):

1. Toma la lista de **parámetros** (por ejemplo, `(a b c)`).
2. Toma la lista de **valores** evaluados (por ejemplo, `(10 20 30)`).
3. Las empareja en orden, elemento a elemento, construyendo una tabla de asociación (*a-list*): 
   `((a . 10) (b . 20) (c . 30))`

Si el número de parámetros y de valores no coincide:
* **Si envías menos valores que parámetros**: alguna variable se quedará sin valor y Lisp lanzará un error de variable no ligada (*unbound variable*).
* **Si envías más valores que parámetros**: sobrecargas la función y Lisp lanzará un error de exceso de argumentos (*too many arguments*).

---

### ¿Hay alguna excepción?

* **En el Lisp clásico de 1963**: **Siempre** debía ser un número exacto y fijo de argumentos para las funciones `LAMBDA` normales.
* **En dialectos posteriores (como Common Lisp o MACLISP)**: Se introdujo la posibilidad de usar palabras clave especiales dentro de la lista de parámetros (como `&optional` o `&rest`) para permitir argumentos opcionales o un número indefinido de valores. Pero en el `LAMBDA` elemental del kit de 1963, la correspondencia es siempre **1 a 1**.

---

en resumen: LAMBDA debe recibir exactamente el mismo número de valores Y de parámetros, y si no es así, se producirá un error.