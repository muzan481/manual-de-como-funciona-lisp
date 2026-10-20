¡Muy buena observación! Y, de nuevo, tienes razón en detener el curso aquí.

Acabo de cometer el mismo error que antes: usé una herramienta que **todavía no habíamos estudiado**.

No debería introducir `setq` o `set` sin antes explicar qué son.

Vamos a hacerlo en orden.

---

# Módulo 10 (Antes de continuar): `SETQ`

> **Nota importante:** Lo que sigue es conocimiento general de Common Lisp y sirve para continuar el curso. Si el archivo que estamos siguiendo no desarrolla `setq` en este punto, lo estoy introduciendo porque se vuelve necesario para escribir ejemplos más realistas.

---

# ¿Qué problema resuelve?

Hasta ahora hacíamos cosas como:

```lisp
(+ 2 3)
```

o

```lisp
(cons '+ '(a b))
```

Cada expresión producía un resultado...

...pero ese resultado desaparecía inmediatamente.

Por ejemplo:

```lisp
(list 1 2 3)
```

produce:

```lisp
(1 2 3)
```

Pero, ¿cómo la usamos diez líneas más abajo?

No podemos, porque nunca la guardamos.

Necesitamos una forma de decirle a Lisp:

> **"Guarda este resultado con un nombre para poder usarlo después."**

---

# La idea de una variable

Imagina una caja con una etiqueta.

```text
┌─────────────┐
│   tabla     │
├─────────────┤
│             │
│  (lista)    │
│             │
└─────────────┘
```

La etiqueta es:

```text
tabla
```

Y dentro de la caja está la lista.

---

# `setq`

En Common Lisp se escribe así:

```lisp
(setq tabla
      '(1 2 3))
```

Se lee como:

> **"Guarda la lista `(1 2 3)` en la variable `tabla`."**

Después puedes escribir:

```lisp
tabla
```

y el REPL devuelve:

```lisp
(1 2 3)
```

---

# Otro ejemplo

```lisp
(setq nombre
      'juan)
```

Ahora:

```lisp
nombre
```

devuelve:

```lisp
juan
```

---

# ¿Por qué se llama `setq`?

Aquí viene una parte histórica interesante.

El nombre viene de:

```text
SET Quote
```

¿Por qué?

Porque originalmente se usaba para asignar un **símbolo** sin necesidad de escribir la comilla manualmente.

Por ejemplo, esto:

```lisp
(setq x 10)
```

es equivalente, conceptualmente, a:

```lisp
(set 'x 10)
```

Observa la diferencia.

Con `set`, el nombre de la variable se pasa como un símbolo:

```lisp
(set 'x 10)
```

Con `setq`, no hace falta escribir la comilla:

```lisp
(setq x 10)
```

Por eso `setq` resulta mucho más cómodo y es el que verás normalmente.

---

# ¿Y `set`?

Ahora sí respondemos tu pregunta.

Existe otra función:

```lisp
(set 'x 10)
```

Aquí **sí** debes escribir la comilla.

Porque `set` espera que el primer argumento sea **el símbolo** cuyo valor quieres cambiar.

Visualmente:

```text
set

↓

Recibe

'x

↓

Modifica la variable llamada

x
```

En cambio:

```lisp
(setq x 10)
```

ya entiende que `x` es el nombre de la variable.

---

# Relación con `let`

Quizás ahora notes algo curioso.

Con `let` hacíamos:

```lisp
(let ((a 5)
      (b 8))
  (+ a b))
```

`let` también guarda valores en nombres.

La diferencia es:

* **`let`** crea variables **temporales**, que solo existen dentro del bloque.
* **`setq`** modifica o crea una variable cuyo valor permanece después de la expresión (si el entorno lo permite).

---

# Diagrama

```
let

┌───────────────┐
│ a → 5         │
│ b → 8         │
└───────────────┘

↓

Sale del let

↓

Desaparecen



setq

tabla → '(1 2 3)

↓

Termina la expresión

↓

tabla sigue existiendo
```

---

setq es como guardar una caja en un depósito permanente.

Guardar

x → 5

↓

Salir

↓

Volver mañana

↓

La caja sigue ahí