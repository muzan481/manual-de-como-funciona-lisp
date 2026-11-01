# Mapa del contenido

Qué hay en cada carpeta de [`clase_de_lisp/`](../clase_de_lisp/) y un **orden de lectura sugerido**. Las descripciones salen de los propios nombres y del contenido de los archivos. El manual no se modifica: este mapa solo ayuda a orientarse.

> GitHub ordena las carpetas alfabéticamente, así que **no** aparecen en orden de módulo. Usa esta tabla como índice.

## Parte 1: Fundamentos (módulos numerados)

| # | Carpeta | Tema |
|---|---|---|
| 1 | `Módulo_1/` | Cómo leer Lisp: sintaxis visual, sangría, terminología de listas |
| 2 | `modulo_2/` | Extraer elementos con `car`/`cdr`, comilla `'`, backquote, triple comilla (la "matrioska") |
| 3 | `modulo_3/` | Añadir y extraer elementos de listas (`cons`) |
| 4 | `modulo_4/` | `defun` con `eval`, `defparameter`, `defun` con `let` |
| 5 | `modulo_5/` | Funciones que construyen código ("macro mutante") |
| 6 | `modulo_6/` | `list` y `append`; `let` con `append` |
| 7 | `modulo_7/` | `let` y `let*` (la metáfora de las cajas) |
| 8 | `modulo_8/` | `cadr` |
| 9 | `modulo-9/` | `caddr` |
| 10 | `modulo_10/` | `cadddr` |
| 11 | `modulo_11/` | `set` / `setq` (introducción) |
| 12 | `modulo_12/` | `assoc` (listas de asociación) |
| 13 | `modulo_13/` | `listp` |
| 14 | `modulo_14/` | `eq` |
| 15 | `modulo_15/` | `and` |
| 16 | `modulo_16/` | Crear un expansor |
| 17 | `modulo_17/` | Celdas `cons` (*cons cells*) |
| 18 | `modulo_18/` | `setq` |
| 19 | `modulo_19/` | `defparameter` y la convención de los `*asteriscos*` |

## Parte 2: Cómo funciona Lisp por dentro

| Carpeta | Tema |
|---|---|
| `como_funciona_eval/` | El algoritmo de `eval` |
| `como_funciona_una_macro/` | Qué hace el evaluador con una macro; cómo funciona un expansor |
| `como_funciona_dispatcher/` | Construir un despachador (`dispatch` + `assoc`) y un sistema de macros propio |
| `mi_expansor_final/` | Versión final del expansor del autor (`expansor_final.lisp` + su `.fasl` compilado) |

## Parte 3: Construcción de macros

| Carpeta | Tema |
|---|---|
| `como_hacer_funciones_auxiliares/` | Funciones auxiliares para macros; comilla simple, doble y triple dentro de ellas |
| `como_hacer_macros_con_manual_list_construccion/` | Macros con `list`/`cons`/`append`, `progn`, comillas `'` `''` `'''`, meta-macros manuales |
| `molde_universal_manual_list_construccion/` | Plantillas numeradas (n2–n15 y la "duodécima") para guardar y reutilizar |
| `como_usar_&rest_y_&key/` | Parámetros `&rest` y `&key` |
| `como_usar_destructuring_bing/` | `destructuring-bind` y moldes de macros que lo usan |
| `mi_forma_de_hacer_macros/` | El estilo de plantilla (backquote, `,` y `,@`) comparado con la construcción manual |
| `molde_universal_construye_cualquier_macro/` | Plantilla general para construir cualquier macro |
| `como_hacer_meta_macros_explicitas/` | Meta-macros explícitas y el truco `,',` |
| `meta_macros_correctas/` | Ejemplos correctos, ejercicios y referencia de errores comunes |

## Parte 4: Proyectos propios del autor

| Carpeta | Tema |
|---|---|
| `mis_macros/` | Macros propias, de la segunda a la quinta, macro recursiva y meta-macros n1–n8 |
| `paquetes_de_mis_macros/` | La quinta macro empaquetada con `defpackage` |
| `manual_para_crear_lenguaje/` | Molde base para crear un lenguaje propio sobre Lisp |

## Orden de lectura sugerido

1. **Parte 1** completa, del módulo 1 al 19.
2. **Parte 2**: `como_funciona_eval` → `como_funciona_una_macro` → `como_funciona_dispatcher` → `mi_expansor_final`.
3. **Parte 3**: `como_hacer_funciones_auxiliares` → `como_hacer_macros_con_manual_list_construccion` → `molde_universal_manual_list_construccion` → `como_usar_&rest_y_&key` → `como_usar_destructuring_bing` → `mi_forma_de_hacer_macros` → `molde_universal_construye_cualquier_macro` → `como_hacer_meta_macros_explicitas` → `meta_macros_correctas`.
4. **Parte 4**: `mis_macros` → `paquetes_de_mis_macros` → `manual_para_crear_lenguaje`.

Este orden es una sugerencia para orientarse. Si el autor indica otro, manda el del autor.
