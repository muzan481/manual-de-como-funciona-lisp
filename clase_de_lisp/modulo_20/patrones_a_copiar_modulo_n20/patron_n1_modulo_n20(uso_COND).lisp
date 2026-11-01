Aquí tienes un ejemplo con la estructura de **`COND`** usando otra comprobación:

```lisp
(cond ((atom x) "es-un-atomo")
      (t        "es-una-lista"))
```

En este ejemplo:
1. La primera condición evalúa `(atom x)`. Si se cumple, devuelve `"es-un-atomo"`.
2. Si no se cumple, pasa a la siguiente línea: `t` actúa como la rama *en caso contrario* y devuelve `"es-una-lista"`.

