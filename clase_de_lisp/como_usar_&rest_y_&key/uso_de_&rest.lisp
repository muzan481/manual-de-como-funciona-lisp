Esa es una de las dudas más comunes al empezar con macros. La buena noticia es que **`&rest` no es exclusivo de las macros**; funciona igual que en `defun`. Lo único que cambia es que en una macro captura **código**, no valores evaluados.

## Primero: ¿qué significa `&rest`?

Significa:

> "A partir de aquí, mete **todos los argumentos restantes** en una lista."

Por ejemplo, en una función:

```lisp
(defun ejemplo (a b &rest resto)
  (list a b resto))
```

Si llamas:

```lisp
(ejemplo 1 2 3 4 5)
```

obtienes:

```lisp
(1 2 (3 4 5))
```

Observa lo que pasó:

```
a     = 1
b     = 2
resto = (3 4 5)
```

---

## En una macro ocurre exactamente igual

```lisp
(defmacro ejemplo (a b &rest resto)
  `(list ',a ',b ',resto))
```

Si escribes:

```lisp
(ejemplo x y z w t)
```

la macro recibe:

```
a     = x
b     = y
resto = (z w t)
```

No evalúa `x`, `y`, `z`... simplemente recibe esos símbolos.

---

# ¿Dónde se pone `&rest`?

Siempre va **antes del nombre de la variable que almacenará el resto**.

```lisp
(defmacro nombre (param1 param2 &rest resto)
  ...)
```

No puede ir en cualquier sitio.

Correcto:

```lisp
(defmacro ejemplo (a b &rest resto)
  ...)
```

Incorrecto:

```lisp
(defmacro ejemplo (&rest resto a b)
  ...)
```

porque después de `&rest` ya no puede haber parámetros normales.

---

# ¿Cuándo se usa?

Hazte esta pregunta:

> **¿Sé exactamente cuántos argumentos va a recibir la macro?**

Si la respuesta es **sí**, no necesitas `&rest`.

Ejemplo:

```lisp
(defmacro mover (personaje direccion)
  ...)
```

Siempre recibe dos argumentos.

---

Ahora pregúntate:

> **¿Puede recibir cualquier cantidad de argumentos?**

Si la respuesta es **sí**, usa `&rest`.

Por ejemplo:

```lisp
(defmacro imprimir (&rest cosas)
  ...)
```

Ahora puedes escribir:

```lisp
(imprimir a)
```

```lisp
(imprimir a b)
```

```lisp
(imprimir a b c d e)
```

Todo termina en la lista `cosas`.

---

# En tu DSL

Tu sintaxis era algo parecido a:

```lisp
(mi-meta-macro-n2
  clase: animal
  nombre: leon
  habilidad: ruge
  ...)
```

¿Cuántos argumentos hay?

No lo sabes.

Hoy puede haber:

```
clase:
animal
nombre:
leon
```

Mañana:

```
clase:
animal
nombre:
leon
vida:
100
energia:
80
habilidad:
ruge
arma:
garras
```

Cada personaje puede tener distintas características.

Eso significa que **no conoces el número de argumentos**.

Ahí `&rest` es la herramienta adecuada.

```lisp
(defmacro mi-meta-macro-n2 (&rest codigo)
  ...)
```

Y `codigo` contendrá una lista con todo lo que escribió el usuario.

---

# ¿Y `&body`?

Aquí viene un detalle curioso.

En Common Lisp:

```lisp
&body
```

**es prácticamente igual que `&rest`.**

De hecho, el estándar define que `&body` se comporta como `&rest`.

La diferencia es **semántica**, no técnica.

Se usa cuando lo que capturas representa un bloque de código.

Por ejemplo:

```lisp
(defmacro cuando (condicion &body cuerpo)
  `(if ,condicion
       (progn ,@cuerpo)))
```

Si escribes:

```lisp
(cuando (> x 5)
  (print "Hola")
  (print "Mundo"))
```

`cuerpo` contendrá:

```lisp
((print "Hola")
 (print "Mundo"))
```

Podrías haber escrito:

```lisp
(defmacro cuando (condicion &rest cuerpo)
  ...)
```

Y funcionaría igual.

Se usa `&body` simplemente porque deja claro al lector:

> "Lo que viene aquí es un bloque de código."

---

# Una regla sencilla

Yo uso esta regla mental:

```
¿Recibo una cantidad fija?

Sí
↓
(a b c)
```

```
¿Recibo una cantidad variable?

Sí
↓
(&rest cosas)
```

```
¿Recibo un bloque de código?

Sí
↓
(&body cuerpo)
```

---

## Aplicándolo a tu proyecto

Por lo que hemos hablado estos días, **yo no usaría `&body` en `mi-meta-macro-n2`**.

¿Por qué?

Porque tú **no estás capturando un bloque de código Lisp** como hace `when`, `let` o `dotimes`.

Estás capturando **la descripción de un personaje**, es decir, datos de tu DSL.

Así que lo natural sería:

```lisp
(defmacro mi-meta-macro-n2 (&rest especificacion)
  ...)
```

o

```lisp
(defmacro mi-meta-macro-n2 (&rest personaje)
  ...)
```

Esos nombres reflejan mejor que la macro está recibiendo una especificación para construir un personaje, no un cuerpo de instrucciones Lisp. Esa pequeña diferencia de nombres hace que el código sea mucho más fácil de entender cuando vuelvas a leerlo dentro de unos meses.
