# 🧠 Guía de Supervivencia para `let` y `let*`

> Objetivo: dejar de cometer errores al escribir `let` y `let*`.

---

# Antes de escribir

Nunca empieces escribiendo las variables.

Primero escribe el esqueleto.

```lisp
(let* (

      )

  )
```

Después rellena las variables.

Por último escribe el cuerpo.

---

# Regla de Oro

Piensa que un `let*` siempre tiene DOS BLOQUES.

```
LET*

├───────────────┐
│ Variables     │
└───────────────┘

┌───────────────┐
│ Cuerpo        │
└───────────────┘
```

Nunca mezcles ambos.

---

# Modelo Mental

Imagina una fábrica.

Fase 1:

Construir todas las máquinas.

```
(a ...)
(b ...)
(c ...)
(d ...)
```

Fase 2:

Usar las máquinas.

```
(expresión)

(expresión)

(expresión)
```

Nunca se construye una máquina después de empezar a producir.

---

# Plantilla Básica

```lisp
(let*
    (

     (variable-1 valor)

     (variable-2 valor)

     (variable-3 valor)

    )

    expresión

)
```

---

# Regla Visual

Cuando termines la última variable...

CIERRA EL BLOQUE.

```lisp
(let*
    (

     (a 10)

     (b 20)

    )   <- aquí termina la declaración

    (+ a b)

)
```

Si todavía no has escrito este paréntesis:

```
)
```

Entonces TODAVÍA estás declarando variables.

---

# El Truco del Dedo

Cuando llegues a la última variable haz una pausa y pregúntate:

> "¿Estoy declarando otra variable o ya quiero devolver algo?"

Si la respuesta es:

> "Quiero devolver algo."

Entonces debes cerrar la lista de variables.

---

# Error más común

Incorrecto

```lisp
(let*
(
 (a 1)
 (b 2)
 resultado
)
```

¿Por qué?

Porque Lisp cree que `resultado` es otra variable.

---

Correcto

```lisp
(let*
(
 (a 1)
 (b 2)
)

resultado
)
```

---

# Regla del Flujo

Dentro del bloque de variables solamente existen definiciones.

```
(variable valor)
```

Nada más.

No existen retornos.

No existen llamadas.

No existen resultados.

Sólo definiciones.

---

# Orden Mental

Siempre piensa:

```
1. Crear variable

↓

2. Crear variable

↓

3. Crear variable

↓

4. Ejecutar cuerpo
```

Nunca

```
Variable

↓

Variable

↓

Retorno

↓

Variable
```

---

# Cómo leer un let*

Nunca leas el código de arriba hacia abajo.

Lee primero únicamente las variables.

```
a

↓

b

↓

c

↓

d
```

Cuando entiendas todas las variables...

recién entonces lee el cuerpo.

---

# Ejercicio 1

Escribe únicamente esto.

```lisp
(let* (

)

)
```

100 veces.

Hasta que salga automático.

---

# Ejercicio 2

Ahora agrega variables.

```lisp
(let*
(
 (a 1)
)

)
```

Después

```lisp
(let*
(
 (a 1)
 (b 2)
)

)
```

Después

```lisp
(let*
(
 (a 1)
 (b 2)
 (c 3)
)

)
```

Sin escribir el cuerpo.

El objetivo es acostumbrar al cerebro al bloque de variables.

---

# Ejercicio 3

Ahora agrega el cuerpo.

```lisp
(let*
(
 (a 1)
)

a
)
```

Después

```lisp
(let*
(
 (a 1)
 (b (+ a 2))
)

b
)
```

Después

```lisp
(let*
(
 (a 1)
 (b (+ a 2))
 (c (+ b 3))
)

c
)
```

---

# Ejercicio 4

Escribe un `let*` completo.

Después tápalo.

Ahora intenta dibujar únicamente su estructura.

```
LET

Variables

Variables

Variables

↓

Cuerpo
```

Si puedes reconstruir la estructura sin mirar, ya no dependerás de memorizar los paréntesis.

---

# Mantra

Cada vez que escribas un `let*`, repite mentalmente:

```
Primero creo.

Después uso.
```

Nunca

```
Creo.

Uso.

Creo otra vez.
```

---

# Regla de los Colores (opcional)

Si tu editor lo permite:

Variables → azul.

Cuerpo → verde.

La diferencia visual ayuda muchísimo durante las primeras semanas.

---

# Patrón Universal

Todos los `let` y `let*` siguen exactamente la misma forma.

```
LET

↓

Variables

↓

Cerrar variables

↓

Cuerpo

↓

Resultado
```

No importa si tienes una variable o cincuenta.

La estructura nunca cambia.

---

# Checklist antes de ejecutar

☐ ¿Ya cerré la lista de variables?

☐ ¿Todo lo que hay arriba son pares `(variable valor)`?

☐ ¿El cuerpo empieza después del cierre de la lista?

☐ ¿El último valor del cuerpo es el que quiero devolver?

Si las cuatro respuestas son "Sí", probablemente el `let*` está bien construido.

---

# Filosofía

No memorices los paréntesis.

Memoriza la forma.

Si reconoces la forma, los paréntesis terminan apareciendo solos.
