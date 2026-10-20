¡Muy bien! Estás razonando correctamente, pero hay un pequeño detalle en el orden del algoritmo que quiero corregir. Es una diferencia sutil, pero es la que distingue un algoritmo correcto de uno que podría fallar.

Tú dijiste:

> "El evaluador haría `car` para tomar la clave y `cadr` para tomar el valor que coincide con la clave."

La idea es correcta, pero **`cadr` no se ejecuta inmediatamente**.

El algoritmo real sería:

```text
Tomar una asociación.

↓

(car asociación)

↓

¿La clave coincide con el símbolo buscado?

        │
   ┌────┴────┐
   │         │
  Sí         No
   │         │
   ▼         ▼
(cadr     Pasar a la
asociación) siguiente
            asociación
```

Es decir:

1. **Primero** lees la clave con `car`.
2. **Después** comparas esa clave con el nombre que estás buscando.
3. **Solo si coinciden**, lees el valor con `cadr`.
4. Si no coinciden, ignoras ese par y pasas al siguiente.

---

## Hagámoslo paso a paso

Buscamos:

```lisp
mi-imprimir
```

Lista:

```lisp
'((mi-suma expansion-suma)
  (mi-resta expansion-resta)
  (mi-producto expansion-producto)
  (mi-imprimir expansion-imprimir))
```

### Primer par

```lisp
(mi-suma expansion-suma)
```

```lisp
(car ...)
```

↓

```lisp
mi-suma
```

¿Es igual a `mi-imprimir`?

```text
No.
```

**No hacemos `cadr`.**

Pasamos al siguiente.

---

### Segundo par

```lisp
(mi-resta expansion-resta)
```

`car` →

```lisp
mi-resta
```

¿Coincide?

```text
No.
```

Seguimos.

---

### Tercer par

```lisp
(mi-producto expansion-producto)
```

`car` →

```lisp
mi-producto
```

¿Coincide?

```text
No.
```

Seguimos.

---

### Cuarto par

```lisp
(mi-imprimir expansion-imprimir)
```

`car` →

```lisp
mi-imprimir
```

¿Coincide?

```text
Sí.
```

Ahora sí:

```lisp
(cadr '(mi-imprimir expansion-imprimir))
```

↓

```lisp
expansion-imprimir
```

Ese es el expansor que el intérprete utilizará.

---

# algoritmo de funcionamiento de eval

El intérprete:

* empieza por el primer elemento,
* compara,
* si no coincide, continúa,
* repite el proceso hasta encontrar el elemento buscado.

Eso no es exclusivo de Lisp; es un patrón que encontrarás al implementar compiladores, motores de juegos, bases de datos sencillas e incluso sistemas operativos.

---

## Ya estamos listos para el siguiente paso

Hasta ahora hemos respondido dos preguntas:

1. **¿Cómo guardar las macros?** → En una lista de asociaciones.
2. **¿Cómo encontrar una macro?** → Recorriendo esa lista y comparando las claves.

La única pieza que nos falta para tener un intérprete funcional es responder:

> **¿Qué ocurre cuando la macro no existe?**

Es decir:

* ¿Cómo detecta el intérprete que el nombre buscado no está en la lista?
* ¿Qué debería hacer en ese caso?

Ese será el siguiente módulo, y con él tendremos completo el algoritmo conceptual de búsqueda de macros antes de empezar a escribir su implementación.
