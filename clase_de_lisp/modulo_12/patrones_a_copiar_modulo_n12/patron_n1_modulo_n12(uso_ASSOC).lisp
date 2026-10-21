# `assoc` — Forma básica y funcionamiento

```lisp
;; FORMA BÁSICA DE ESCRIBIR ASSOC:
;;
;; (assoc 'gato '((gato felino)))
;;        ^      ^
;;        |      |
;;      clave   lista
```

## ¿Qué hacemos con `assoc`?

Creamos una **lista de asociaciones** formada por pares:

```lisp
'((perro canino)
  (gato felino)
  (caballo equino))
```

Cada par tiene:

```text
┌─────────┬─────────┐
│  CLAVE  │  VALOR  │
├─────────┼─────────┤
│ perro   │ canino  │
│ gato    │ felino  │
│ caballo │ equino  │
└─────────┴─────────┘
```

La **clave** es el primer elemento de cada par.

El **valor** es el segundo elemento.

---

## ¿Qué recibe `assoc`?

`assoc` recibe dos cosas:

```lisp
(assoc clave lista)
```

### 1. La clave que queremos buscar

Por ejemplo:

```lisp
'gato
```

### 2. La lista donde queremos buscarla

Por ejemplo:

```lisp
'((perro canino)
  (gato felino)
  (caballo equino))
```

Por lo tanto:

```lisp
(assoc 'gato
       '((perro canino)
         (gato felino)
         (caballo equino)))
```

---

## ¿Qué hace `assoc`?

Busca la clave que le proporcionamos dentro de la lista de asociaciones.

En este caso busca:

```text
gato
```

Recorre:

```text
perro → canino
```

No coincide.

Después:

```text
gato → felino
```

¡Coincide!

Entonces `assoc` devuelve **la asociación completa**:

```lisp
(gato felino)
```

No devuelve solamente:

```lisp
felino
```

La asociación completa es:

```text
┌─────────┬─────────┐
│  gato   │ felino  │
└─────────┴─────────┘
```

Después podemos utilizar otras funciones para extraer una parte:

```lisp
(car (assoc 'gato
            '((perro canino)
              (gato felino)
              (caballo equino))))
```

Resultado:

```lisp
gato
```

Y:

```lisp
(cadr (assoc 'gato
             '((perro canino)
               (gato felino)
               (caballo equino))))
```

Resultado:

```lisp
felino
```

---

## Analogía: casilleros o lockers

Podemos imaginar la lista de asociaciones como una serie de lockers.

Cada locker tiene:

```text
CLAVE → identifica el locker

VALOR → contenido del locker
```

Por ejemplo:

```text
perro   → canino
gato    → felino
caballo → equino
```

`assoc` funciona como una **ama de llaves**:

1. Recibe el nombre del locker que buscamos.
2. Recorre los lockers.
3. Encuentra el locker cuya clave coincide.
4. Nos entrega el **par completo**.

Después podemos usar:

```lisp
car
```

para obtener la clave.

O:

```lisp
cadr
```

para obtener el valor.

---

## Resumen

```text
              ASSOC
                │
                │ busca una clave
                ▼
        ┌─────────────────┐
        │ lista de pares  │
        └─────────────────┘
                │
                ▼
        (gato felino)
           │       │
         car     cadr
           │       │
           ▼       ▼
         gato    felino
```

### Regla fundamental

```lisp
(assoc clave lista)
```

significa:

> **"Busca esta clave dentro de esta lista de asociaciones y devuelve el par que contiene esa clave."**

Por eso `assoc` **encuentra la asociación**, mientras que `car` o `cadr` nos permiten posteriormente **extraer información de esa asociación**.
