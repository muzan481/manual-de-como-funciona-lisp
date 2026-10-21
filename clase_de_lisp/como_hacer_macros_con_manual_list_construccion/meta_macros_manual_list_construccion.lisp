El problema está en la **estructura del cuerpo de la macro generada**. Hay dos errores principales:

## Error 1: `PROGN` sin comilla

En esta línea:
```commonlisp
(list 'list 'progn ...)
```

`progn` no está entre comillas, así que Lisp intenta evaluarlo como **variable**, no como símbolo. Debería ser:
```commonlisp
(list 'list ''progn ...)
```

(Nota: comilla doble = dos comillas simples)

## Error 2: Estructura incorrecta del cuerpo

El cuerpo de `macro-generada` que se genera es inválido:
```commonlisp
(list progn '(definir-reglas) (list simbolo var) (list simbolo var))
```

Esto intenta: "llamar a `progn` como variable" (falla) + una lista + dos listas. No es una forma válida de Lisp.

## Solución correcta

Aquí está el código corregido:

```commonlisp
(defmacro generar-macro ()
  (list
   'defmacro
   'macro-generada
   '(simbolo var)
   (list
    'list
    ''simbolo
    'simbolo
    ''var
    'var)))
```

Este genera:
```commonlisp
(defmacro macro-generada (simbolo var)
  (list 'simbolo simbolo 'var var))
```

Que expande `(macro-generada foo bar)` a: `('simbolo foo 'var bar)` ✓

## Patrón correcto para construcción manual

**Regla de oro**: Cuando quieras un símbolo literal en la salida, usa `'` (comilla simple). Cuando quieras el valor de una variable, sin comilla:

```commonlisp
(list 'resultado-macro
      'param1 param1-value    ;; símbolo literal 'param1, valor de param1
      'param2 param2-value)   ;; símbolo literal 'param2, valor de param2
```

## Mejor: Usa quasiquoting (backtick)

Para evitar confusiones, te recomiendo cambiar a **quasiquoting**:

```commonlisp
(defmacro generar-macro ()
  `(defmacro macro-generada (simbolo var)
     (list 'simbolo simbolo 'var var)))
```

Esto es **mucho más legible** que múltiples comillas anidadas.

¿Quieres que te muestre más ejemplos de meta-macros correctas?