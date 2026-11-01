# Ficha 05 — Kit cerrado de funciones y presupuesto histórico

> **Serie:** fuentes para un tutor de macros al estilo de 1963.
> **Esta ficha:** referencia normativa del kit. Se consulta antes de aceptar cualquier función en una solución.
> **Objetivo:** fijar qué funciones están permitidas, con qué fuente, en qué zona y en qué etapa; y demostrar que el mecanismo histórico cabe en un presupuesto pequeño.

---

## 0. Cómo usar esta ficha

Para el estudiante:

- Esta es la lista de lo que puedes usar. Si una función no aparece en la tabla de la sección 2, no entra en la solución.
- No es una lista de la compra: que una función esté permitida no significa que debas usarla. El contrato `(mi-suma a b)` → `(+ a b)` se resuelve con **tres** nombres.
- Distingue tres zonas: lo que va **dentro del expansor**, lo que sirve para **registrar** la macro y lo que pertenece al **arnés de pruebas**. Meter una función de una zona en otra es el error más común.
- Si una idea parece necesitar backquote, `LET`, `IF` o `EVAL`, no es una excepción: se reformula con el kit.

Para la IA tutora:

1. Esta ficha **prevalece** sobre los resúmenes de presupuesto de las fichas 01–04. Si hay conflicto, manda esta tabla.
2. Antes de aceptar una función, compruébala en la sección 2 y en la zona correcta.
3. No llames «moderna» a una función de época que solo está fuera del kit. `AND`, `OR` y `PROG` existían; el curso no las usa.
4. `EVAL` y `APPLY` son vocabulario de época, pero están **vetadas dentro del expansor**. Solo se usan para explicar o para el arnés.
5. Si una función no está en el kit, detente y ofrece una alternativa de la sección 7. No la introduzcas «solo esta vez».
6. No inventes páginas, funciones ni equivalencias de SBCL. Lo que no esté verificado se dice como «no lo dice la fuente» o «no lo he verificado».
7. No conviertas el kit en una excusa para usar `DEFMACRO`, backquote, coma o `&body`.

---

## 1. Qué es un kit cerrado y qué es un presupuesto histórico

### 1.1. Definiciones

**Kit cerrado:** una lista finita y normativa de nombres permitidos, cada uno con su fuente, su zona de uso y la etapa en que se abre. «Cerrado» significa que no se amplía sobre la marcha: si una solución necesita un nombre que no está, se detiene y se busca una alternativa.

**Presupuesto histórico:** tres cosas que se pueden contar.

1. **Piezas:** lo que el sistema histórico necesita para funcionar. Weissman enumera cuatro (p. 155).
2. **Decisiones:** lo que define el mecanismo. Hart enumera cuatro (p. 1).
3. **Coste:** funciones distintas y líneas normalizadas de las implementaciones documentadas. `CSETQ` usa 5 funciones; `*EXPAND`, 6; `mi-suma`, 3.

El presupuesto no es una metáfora de dinero: es una forma de detectar sobreconstrucción. Un expansor de `mi-suma` que usa diez funciones no es «más completo»; es más caro y más difícil de explicar.

**Techo, no lista de la compra:** el kit dice hasta dónde se puede llegar, no qué hay que recorrer. Una solución pequeña con tres funciones es preferible a una que recorra veinte porque estaban permitidas.

### 1.2. Qué significa «solo QUOTE»

El lema del curso —«solo `QUOTE`»— no significa «solo la función `QUOTE`». Significa que el único mecanismo de citación es `QUOTE`; las formas se construyen con `QUOTE` y constructores de listas, y los valores se insertan con esos constructores o con `SUBLIS`.

| Necesidad | Mecanismo de época | Prohibido |
|---|---|---|
| Constante literal | `QUOTE` | backquote |
| Construir una forma | `CONS`, `LIST`, `APPEND` | backquote, coma |
| Insertar un valor en una forma | `CONS`/`LIST` con el valor, o `SUBLIS` sobre una alist | coma, coma-arroba |
| Ligar un local | `((LAMBDA (x) ...) valor)` | `LET`, `LET*` |
| Decidir | `COND` | `IF`, `WHEN`, `UNLESS` |
| Nombrar un valor intermedio | `LAMBDA` o `CSETQ` fuera del expansor | `LET` dentro del expansor |

`QUOTE` por sí solo produce formas **constantes**: `(QUOTE (+ a b))` es la lista `(+ a b)`, pero no interpola nada. Para insertar piezas variables se usa `CONS`/`LIST`/`APPEND`; para sustituir símbolos según una tabla, `SUBLIS`.

### 1.3. Las tres categorías

La confusión más grave es llamar «moderna» a una función que existía en 1962 pero que el curso no usa. La distinción correcta es **época/kit**, no antigua/moderna.

| Categoría | Definición | Ejemplos | ¿Se permite? |
|---|---|---|---|
| De época y en el kit | Documentada entre 1962 y 1967 y necesaria para el contrato o para una etapa | `CAR`, `CONS`, `COND`, `DEFLIST`, `GENSYM` | Sí, según la zona y la etapa. |
| De época pero fuera del kit | Existía, pero el curso no la usa | `AND`, `OR`, `PROG`, `MAP`, `RPLACA` | No. No es moderna, pero no entra. |
| Moderna | Posterior a la época o específica de Common Lisp | `DEFMACRO`, backquote, `LET`, `IF`, `FUNCALL` | No en la expansión; solo arnés si está previsto. |

**Consecuencia para el tutor:** si el estudiante pregunta por `AND`, la respuesta correcta es «existía (Manual, p. 58), pero el kit usa `COND`», no «es moderna». Si pregunta por `LET`, la respuesta es «es moderna; usa la aplicación de una `LAMBDA`».

### 1.4. Lo que este kit NO es

- **No es todo LISP 1.5.** El Manual documenta muchas más funciones (aritmética, `PROG`, `MAP`, `RPLACA`, etc.). El kit es un subconjunto didáctico.
- **No es una lista de la compra.** El contrato usa 3 nombres; los ejemplos históricos usan 5 o 6. Usar 20 porque están permitidos es sobreconstrucción.
- **No es una prohibición del arnés.** `DEFUN`, `LET`, `FORMAT` y `SETF` pueden usarse para registrar, montar la tabla de despacho y ejecutar tests. Nunca para construir la forma expandida.
- **No afirma que Hart usara los 32 nombres.** Hart usa un subconjunto; el resto son piezas del sistema o de etapas posteriores del curso.
- **No es una excusa para llamar modernas a `AND`/`OR`/`PROG`.** Eran de época; están fuera por decisión didáctica.
- **No es una licencia para `EVAL`/`APPLY` dentro del expansor.** Se explican y se usan en el arnés; la expansión construye listas.

---

## 2. El kit canónico

El kit canónico tiene **32 nombres**. La lista del prompt contenía 26 entradas (27 nombres, porque `SETQ` y `CSETQ` son dos); esta ficha añade cinco que el mecanismo de Hart o las fichas ya usan: `DEFLIST`, `GET`, `EQUAL`, `PUT` y `REMPROP`.

¿Por qué esos cinco?

- Sin `DEFLIST` y `GET` no se puede registrar ni recuperar la macro como describe Hart (fichas 01 y 03).
- Sin `EQUAL` no se puede reconstruir `ASSOC` tal como la fórmula del Manual la usa (ficha 03).
- `PUT` es la operación de escritura que documenta el *Primer* (1967); `REMPROP` es su operación simétrica de borrado (Manual, p. 59).

De los 32 nombres, **20 como máximo** pueden aparecer dentro de un expansor. Cinco son de registro y siete son de sistema o arnés. Esa separación evita el error de meter `EVAL` en la lógica de expansión.

### 2.1. Datos y constructores (9)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Etapa |
|---|---|---|---|---|
| `QUOTE` | Devuelve su argumento sin evaluarlo. | FSUBR | Manual pp. 10, 22, 71 | 1 |
| `CAR` | Primer elemento de una lista. | SUBR | Manual pp. 2, 56 | 1 |
| `CDR` | Resto de una lista. | SUBR | Manual pp. 3, 56 | 1 |
| `CONS` | Construye un par; con una lista como segundo argumento, añade al frente. | SUBR | Manual pp. 2, 56 | 1 |
| `LIST` | Construye una lista con sus argumentos. En LISP 1.5 es FSUBR: no los evalúa. | FSUBR | Manual p. 57 | 1 |
| `APPEND` | Concatena listas copiando todas menos la última. | SUBR | Manual pp. 11, 61 | 1 |
| `ATOM` | Verdadero si el argumento es un átomo. | SUBR | Manual pp. 3, 57 | 1 |
| `EQ` | Igualdad de identidad, pensada para átomos. | SUBR | Manual pp. 3, 23, 57 | 1 |
| `NULL` | Verdadero si el argumento es `NIL`. | SUBR | Manual pp. 11, 57 | 1 |

**Formas que conviene tener a mano (salidas verificadas en SBCL):**

```text
(cons 'a '(b))      => (A B)
(cons 'a 'b)        => (A . B)
(list 'a 'b)        => (A B)
(append '(a) '(b))  => (A B)
```

**Nota sobre `LIST`:** en LISP 1.5, `LIST` es FSUBR y **no evalúa** sus argumentos. En SBCL, `LIST` es una función y **sí los evalúa**. Al reconstruir, cita las piezas: `(list '+ 'a 'b)`. Si escribes `(list + a b)` en SBCL, estás evaluando variables, no construyendo la forma.

**Nota sobre `EQ`:** en el curso se usa con símbolos y listas. Para números, Common Lisp necesita `EQL`, que no está en el kit. No compares números con `EQ`.

**Nota sobre `ATOM` y `NULL`:** usa `NULL` para la lista vacía y `ATOM` para átomos. No dependas de cómo trata cada dialecto a `NIL` en `ATOM`.

### 2.2. Control y ligadura (2)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Etapa |
|---|---|---|---|---|
| `COND` | Evalúa cláusulas hasta la primera verdadera. | FSUBR | Manual p. 18 | 3 |
| `LAMBDA` | Describe una función: liga parámetros y evalúa el cuerpo. | Forma de función | Manual pp. 13–14 | 2 |

`LAMBDA` no se llama como `CAR`; es la forma que describe una función. En el curso, el expansor es una `LAMBDA` de un argumento: recibe la forma completa.

### 2.3. Accesores (3)

| Función | Qué hace | Tipo | Fuente | Etapa |
|---|---|---|---|---|
| `CADR` | `(CAR (CDR x))`: segundo elemento. | Composición | Manual pp. 13–14, 59 | 3 |
| `CADDR` | `(CAR (CDR (CDR x)))`: tercer elemento. | Composición | Manual pp. 13–14, 59 | 3 |
| `CDDR` | `(CDR (CDR x))`: resto del resto. | Composición | Weissman p. 154; Manual (composición) | 3 |

No son primitivas nuevas: son abreviaturas de composiciones de `CAR` y `CDR`. El recuento de 32 es de **nombres**, no de primitivas. `(CAR (CDR x))` y `CADR` son la misma operación; la segunda es más legible.

### 2.4. Predicado auxiliar (1)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Etapa |
|---|---|---|---|---|
| `EQUAL` | Igualdad estructural. | SUBR | Manual pp. 11, 26, 57 | 6 |

`EQ` compara identidad y basta para símbolos; `EQUAL` compara estructuras y es el que usa la reconstrucción de `ASSOC` (ficha 03). En el expansor de `mi-suma` no necesitas `EQUAL`: solo comparas símbolos con `EQ`.

### 2.5. Registro y definición (5)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Etapa |
|---|---|---|---|---|
| `DEFINE` | Instala un `EXPR` en la property list. | EXPR | Manual p. 58 | 4 |
| `DEFLIST` | Instala cualquier indicador en la property list. | EXPR | Manual pp. 41, 58–59 | 4 |
| `GET` | Lee el valor de un indicador. | SUBR | Manual pp. 41, 59 | 4 |
| `REMPROP` | Elimina un indicador y su propiedad. | SUBR | Manual pp. 41, 59 | 4 |
| `PUT` | Instala un indicador seguido de una propiedad. | (Primer) | Weissman p. 150 | 4 |

**Estas cinco no se usan dentro del expansor.** Registran la macro antes de usarla o la inspeccionan después. El expansor solo transforma una forma en otra.

**Jerarquía histórica:**

- El registro canónico de 1963 es `DEFLIST` (Manual, p. 41; Hart, p. 2).
- `PUT` es la notación del *Primer* (1967).
- `PUTPROP` y `DEFPROP` son de MACLISP (1974) y solo sirven para el contraste de la ficha 04. No entran en el kit.

### 2.6. Entorno y sustitución (4)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Etapa |
|---|---|---|---|---|
| `PAIRLIS` | Construye una a-list con dos listas. | SUBR | Manual p. 12 | 6 |
| `ASSOC` | Busca una clave en una a-list. | SUBR | Manual p. 12 | 6 (y 7 para el despacho) |
| `SUBLIS` | Sustituye símbolos según una a-list. | SUBR | Manual pp. 12, 61 | 6 |
| `SUBST` | Sustituye un símbolo por otro en todo el árbol. | SUBR | Manual pp. 11, 61 | 6 |

**Advertencias:**

- No son higiénicas: sustituyen cualquier átomo cuyo nombre coincida, incluso en posición de función. `GENSYM` mitiga las colisiones, pero no crea una teoría de higiene.
- La fórmula impresa de `ASSOC` no trae caso base para la a-list vacía (Manual, p. 12). La reconstrucción añade `(NULL A) → NIL` y lo declara (ficha 03).
- `PAIRLIS` antepone pares a la a-list. En SBCL, el orden de impresión con varias claves es inverso al de la fórmula del Manual; la búsqueda con `ASSOC` no cambia.

### 2.7. Nombres frescos (1)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Etapa |
|---|---|---|---|---|
| `GENSYM` | Crea un símbolo nuevo y único. | SUBR | Manual p. 66; Primer p. 124; Hart p. 3 | 6 |

En la época se usa sin argumentos: `(GENSYM)`. En SBCL sigue existiendo y devuelve un símbolo no internado; se imprime como `#:G93` y su paquete es `NIL`. El número cambia en cada ejecución.

`GENSYM` garantiza unicidad, no permanencia: el nombre no se puede escribir en un archivo y volver a leer con el mismo significado (Manual, p. 66).

### 2.8. Sistema y arnés (7)

| Función | Qué hace | Tipo en LISP 1.5 | Fuente | Uso |
|---|---|---|---|---|
| `LABEL` | Define una función recursiva en un entorno. | FSUBR | Manual pp. 8, 18, 70 | Arnés o explicación. |
| `SETQ` | Asigna un valor a una variable. | FSUBR | Manual pp. 30, 71 | Arnés. |
| `CSETQ` | Asigna una constante citando el primer argumento. | FEXPR | Manual p. 59 | Arnés. |
| `EVAL` | Evalúa una forma. | SUBR | Manual pp. 14, 58, 71 | Explicación o arnés. |
| `APPLY` | Aplica una función a una lista de argumentos. | SUBR | Manual pp. 13–14, 70 | Explicación o arnés. |
| `PRINT` | Imprime un objeto y lo devuelve. | SUBR | Manual pp. 65, 84 | Traza o arnés. |
| `TERPRI` | Escribe una nueva línea. | SUBR | Manual pp. 65, 84 | Traza o arnés. |

**Regla de zona:** estas siete pueden aparecer en el sistema o en las pruebas, pero **nunca dentro del expansor**.

- `EVAL` y `APPLY` convierten una transformación pura en una evaluación. Si aparecen dentro del expansor, la expansión deja de ser «entra una forma, sale una forma».
- `PRINT` y `TERPRI` añaden efectos secundarios. Una expansión pura no imprime.
- `LABEL`, `SETQ` y `CSETQ` son para definir o asignar en el sistema; el expansor no asigna nada.
- `EVAL` y `APPLY` existen en la época y el prompt las permite como vocabulario. Esta ficha las confina al arnés: permitidas para explicar y ejecutar, vetadas para expandir.

### 2.9. Recuento del kit

| Zona | Nombres | Cuáles |
|---|---|---|
| Dentro del expansor | 20 | datos (9) + control (2) + accesores (3) + `EQUAL` (1) + entorno (4) + `GENSYM` (1) |
| Registro | 5 | `DEFINE`, `DEFLIST`, `GET`, `REMPROP`, `PUT` |
| Sistema y arnés | 7 | `LABEL`, `SETQ`, `CSETQ`, `EVAL`, `APPLY`, `PRINT`, `TERPRI` |
| **Total** | **32** | |

**20 es un techo, no una lista de la compra.** El contrato usa 3 nombres (`CONS`, `CDR`, `QUOTE`); `CSETQ` usa 5; `*EXPAND` usa 6. Si un expansor de `mi-suma` usa más de 3, hay que justificar cada nombre extra.

---

## 3. El presupuesto histórico

### 3.1. Las cuatro piezas de Weissman

**CITA (Weissman, p. 155):**

> “It should now be clear how elegant this macro system is. To solve the knotty problem of special forms of an indefinite number of arguments, all we need are four things:
>
> 1. *EXPAND—a single LISP function easily defined in LISP.
> 2. A function like the macro to be defined, but of just two arguments. Such a two-argument function is easily defined in LISP.
> 3. A macro definition of the special form.
> 4. MACRO recognition by the compiler.”

**TRADUCCIÓN:**

> «Ahora debería estar claro lo elegante que es este sistema de macros. Para resolver el intrincado problema de las formas especiales de un número indefinido de argumentos, solo necesitamos cuatro cosas:
>
> 1. `*EXPAND`: una sola función LISP fácil de definir en LISP.
> 2. Una función como la macro que se quiere definir, pero de solo dos argumentos. Esa función de dos argumentos es fácil de definir en LISP.
> 3. Una definición macro de la forma especial.
> 4. Reconocimiento de `MACRO` por parte del compilador.»

**Qué establece:** el sistema no se mide por el número de funciones que conoce, sino por **cuatro piezas**. El curso reconstruye las cuatro:

| Pieza | En Weissman | En el curso |
|---|---|---|
| Expansor de un nivel | `*EXPAND` | `*EXPAND` reconstruida con `COND`, `NULL`, `CDDR`, `CADR`, `CONS`, `CAR` (ficha 02). |
| Función binaria | `*PLUS`, `CSET` | La función que la macro deja en la forma (`+` en el contrato). |
| Definición de la macro | `MACRO` | Una `LAMBDA` de un argumento, registrada con `DEFLIST` o en la tabla de despacho. |
| Reconocimiento | El compilador | El despachador del arnés (ficha 02) o el registro en la p-list (ficha 01). |

**Dos reglas que acompañan al presupuesto:**

1. La macro debe definirse **antes** de usarse.
2. La macro **no puede ser recursiva**.

Una tercera, compatible: una macro puede usar otra macro ya definida, y el orden de definición importa.

### 3.2. Las cuatro decisiones de Hart

**CITA (Hart, p. 1):**

> “1. The property list of a macro instruction will have the indicator MACRO followed by a function of one argument, a form beginning with the macro's name, and whose value will replace the original form in all function definitions.”

**TRADUCCIÓN:**

> «1. La property list de una instrucción macro tendrá el indicador `MACRO` seguido de una función de un argumento, una forma que empieza con el nombre de la macro, y cuyo valor reemplazará la forma original en todas las definiciones de función.»

**Qué establece:** cuatro decisiones, no una arquitectura:

| Decisión | Consecuencia |
|---|---|
| El indicador vive en la **property list**. | No hace falta un registro global ni una tabla hash. |
| La función es de **un argumento**. | No hay `&rest`, `&body` ni destructuring. |
| El argumento es la **forma completa**. | El expansor recibe `(mi-suma a b)`, no `a` ni `b` evaluados. |
| El valor **reemplaza la forma en las definiciones**. | La expansión ocurre al definir, no al llamar. |

**CITA (Manual, p. 41):**

> “The function deflist[x;i] can be used to put any indicator on a property list. The first argument is a list of pairs as for define, the second argument is the indicator to be used. define[x] = deflist[x;EXPR].”

**TRADUCCIÓN:**

> «La función `deflist[x;i]` puede usarse para poner cualquier indicador en una property list. El primer argumento es una lista de pares como para `define`; el segundo argumento es el indicador que se va a usar. `define[x] = deflist[x;EXPR]`.»

**Qué establece:** el almacenamiento no es nuevo. El Manual ya tiene `DEFLIST`; Hart elige el indicador `MACRO`. La aportación de Hart es la convención y el recorrido, no la estructura.

### 3.3. Presupuesto de líneas y funciones

Las líneas son las de la transcripción normalizada de esta serie; no cuentan comentarios ni portadas. «Funciones distintas» cuenta cada nombre una sola vez, aunque aparezca repetido.

| Pieza | Funciones distintas | Líneas | Fuente |
|---|---|---|---|
| `macro[1] = deflist[1;MACRO]` | 1 (`DEFLIST`) | 1 | Hart p. 2 |
| `define[1] = deflist[mdef[1];EXPR]` | 2 (`DEFLIST`, `mdef`) | 1 | Hart p. 2 |
| Macro `CSETQ` | 5 (`LAMBDA`, `LIST`, `QUOTE`, `CADR`, `CADDR`) | 6 | Hart p. 1; Weissman p. 156 |
| `*EXPAND` | 6 (`COND`, `NULL`, `CDDR`, `CADR`, `CONS`, `CAR`) | 7 | Weissman p. 154 |
| `mi-suma` | 3 (`CONS`, `CDR`, `QUOTE`) | 1 | Contrato del curso |

**Lectura:** el mecanismo histórico es pequeño. Lo que lo rodea —la property list, el compilador, el evaluador— es lo grande. Por eso el curso puede reconstruirlo con pocas piezas y, al mismo tiempo, estudiar mucho contexto.

**Contraste de coste:**

- `CSETQ`: 5 funciones para una macro de aridad fija.
- `*EXPAND`: 6 funciones para una expansión de un nivel, pensada para aridad indefinida.
- `mi-suma`: 3 funciones porque la aridad es fija y el contrato es mínimo.

Si `mi-suma` usara `*EXPAND`, estaría pagando 6 funciones por un problema que no tiene: la aridad ya es fija. Ese es un error de presupuesto, no de corrección.

### 3.4. Presupuesto acumulado por etapa

La secuencia es la del prompt del curso. El kit se abre gradualmente: cada etapa añade solo lo que necesita.

| Etapa | Se abre | Nombres acumulados | Qué habilita |
|---|---|---|---|
| 1 | Datos y constructores (9) | 9 | Leer y construir formas. |
| 2 | `LAMBDA` (1) | 10 | El expansor de `mi-suma`. |
| 3 | `COND`, `CADR`, `CADDR`, `CDDR` (4) | 14 | Condicionales y destrucción manual. |
| 4 | `DEFINE`, `DEFLIST`, `GET`, `REMPROP`, `PUT` (5) | 19 | Registrar la macro en la p-list. |
| 5 | `*EXPAND` (pieza, 0 primitivas) | 19 | Expandir un nivel. |
| 6 | `EQUAL`, `PAIRLIS`, `ASSOC`, `SUBLIS`, `SUBST`, `GENSYM` (6) | 25 | Sustitución e higiene. |
| 7 | Tabla de despacho y tests (0 primitivas) | 25 | Escalabilidad. |
| Arnés | `LABEL`, `SETQ`, `CSETQ`, `EVAL`, `APPLY`, `PRINT`, `TERPRI` (7) | 32 | Ejecutar, probar y explicar. |

**Comprobación de la aritmética:** 9 + 1 = 10; 10 + 4 = 14; 14 + 5 = 19; 19 + 0 = 19; 19 + 6 = 25; 25 + 0 = 25; 25 + 7 = 32.

**Notas:**

- La Etapa 5 no añade primitivas: `*EXPAND` se reconstruye con `COND`, `NULL`, `CDDR`, `CADR`, `CONS` y `CAR`, todos abiertos entre las etapas 1 y 3.
- La Etapa 6 es la más cara: seis nombres nuevos. Solo se abre cuando la macro necesita sustituir o introducir variables.
- La Etapa 7 no añade primitivas: añade arquitectura (tabla, tests).
- El arnés está disponible desde el principio, pero **nunca dentro del expansor**.

### 3.5. Señales de alarma

| Señal | Diagnóstico | Corrección |
|---|---|---|
| `mi-suma` usa más de 3 primitivas | Sobrecostrucción. | Comparar con `(CONS (QUOTE +) (CDR forma))`. |
| El expansor usa `EVAL` o `APPLY` | Evaluación dentro de la expansión. | Devolver la forma; evaluar en el arnés. |
| El expansor usa `PRINT` o `TERPRI` | Efecto secundario. | Mover la traza al arnés. |
| Usa `LET`, `LET*`, `IF` o `FUNCALL` dentro del expansor | Andamiaje moderno en la lógica. | `LAMBDA`, `COND`; el despacho es arnés. |
| Usa backquote o coma | Mecanismo prohibido. | `CONS`, `LIST`, `APPEND`, `SUBLIS`. |
| Usa diez auxiliares para una macro | Presupuesto de piezas excedido. | Reducir o justificar cada pieza. |
| Usa todas las funciones del kit | Lista de la compra. | Usar solo lo que el contrato exige. |
| Introduce variables sin `GENSYM` | Riesgo de captura. | `GENSYM` + `LAMBDA`. |
| Confunde registro con expansión | Dos momentos distintos. | `DEFLIST`/`GET` antes o después; el expansor solo transforma. |
| El test solo comprueba el valor final | No prueba la expansión. | Comparar la forma expandida con `EQUAL`. |

---

## 4. El kit en SBCL

Esta sección traduce el kit a SBCL sin confundir la notación histórica con la moderna. La regla es: **SBCL es el laboratorio, no la época**. Lo que SBCL añade se usa solo en el arnés.

### 4.1. Nombres que existen en SBCL

| Nombre | ¿Existe? | Uso en SBCL | Advertencia |
|---|---|---|---|
| `CAR`, `CDR`, `CONS` | Sí | Idénticos en lo esencial. | `CONS` con átomo como segundo argumento produce un par punteado. |
| `LIST` | Sí | Construye listas. | En SBCL **evalúa** sus argumentos; en LISP 1.5 era FSUBR. Cita las piezas. |
| `APPEND` | Sí | Concatena listas. | Copia todas menos la última. |
| `ATOM`, `EQ`, `NULL` | Sí | Predicados. | `EQ` no es fiable para números; usa símbolos. |
| `COND`, `QUOTE`, `LAMBDA` | Sí | Control y ligadura. | `LAMBDA` en CL es léxico y puede capturar el entorno; LISP 1.5 ligaba con `PAIRLIS` sobre una a-list dinámica. No traslades la noción de cierre a 1963. |
| `CADR`, `CADDR`, `CDDR` | Sí | Accesores. | Son composiciones de `CAR`/`CDR`. |
| `EQUAL` | Sí | Igualdad estructural. | No confundir con `EQ`. |
| `PAIRLIS`, `ASSOC`, `SUBLIS`, `SUBST` | Sí | Entorno y sustitución. | `PAIRLIS` invierte el orden de impresión; `SUBLIS`/`SUBST` aceptan palabras clave modernas. |
| `GENSYM` | Sí | Símbolo fresco. | Devuelve un símbolo no internado; se imprime `#:G...`. |
| `GET`, `REMPROP` | Sí | Property lists. | `GET` es lectura; `REMPROP` es efecto. |
| `SETQ`, `EVAL`, `APPLY`, `PRINT`, `TERPRI` | Sí | Sistema y arnés. | Semántica moderna; nunca dentro del expansor. |

### 4.2. Nombres que NO existen en SBCL y cómo se modelan

Salidas verificadas:

```text
(fboundp 'deflist)  => NIL
(fboundp 'define)   => NIL
(fboundp 'csetq)    => NIL
(fboundp 'putprop)  => NIL
(fboundp 'prop)     => NIL
(fboundp 'label)    => NIL
```

| Nombre histórico | ¿Existe en SBCL? | Modelo en el curso | Zona |
|---|---|---|---|
| `DEFINE` | No | `DEFUN` solo como andamiaje; o `mi-deflist` reconstruida (ficha 03). | Registro |
| `DEFLIST` | No | `(setf (get ...))` como andamiaje; o `mi-deflist`. | Registro |
| `PUT` | No | `(setf (get ...))`. | Registro |
| `CSETQ` | No | `SETQ`/`SETF` fuera del expansor. | Arnés |
| `LABEL` | No | `DEFUN` como andamiaje. | Arnés |
| `PROP` | No | No se necesita: `GET` o `ASSOC`. | — |
| `PUTPROP`, `DEFPROP` | No | Solo contraste con Moon (ficha 04). | Posterior |

**No traduzcas `DEFINE` por `DEFMACRO`.** `DEFINE` define funciones ordinarias; `DEFMACRO` define macros modernas. El equivalente histórico de la definición de una macro es `DEFLIST` con el indicador `MACRO`, no `DEFMACRO`.

### 4.3. Qué evalúa cada función

La tabla es del LISP 1.5, no de SBCL. Sirve para entender por qué unas funciones reciben formas y otras reciben valores.

| Tipo | Qué hace con los argumentos | Nombres | Consecuencia |
|---|---|---|---|
| FSUBR | No los evalúa. | `QUOTE`, `COND`, `LIST`, `LABEL`, `SETQ` | `LIST` construye con las formas tal como llegan. |
| SUBR | Los evalúa. | `CAR`, `CDR`, `CONS`, `APPEND`, `ATOM`, `EQ`, `NULL`, `EQUAL`, `PAIRLIS`, `ASSOC`, `SUBLIS`, `SUBST`, `GENSYM`, `EVAL`, `APPLY`, `PRINT`, `TERPRI`, `GET`, `REMPROP` | Reciben valores ya evaluados. |
| EXPR | Los evalúa y define. | `DEFINE`, `DEFLIST` | El registro recibe las definiciones como valores. |
| FEXPR | Decide según la función. | `CSETQ` | Cita su primer argumento. |

**Trampa principal:** en SBCL, `LIST` es una función normal y evalúa sus argumentos. Si vienes de la tabla histórica y escribes `(list + a b)`, no estás construyendo `(+ A B)`: estás evaluando `+`, `a` y `b`. La forma correcta en el expansor es `(list '+ 'a 'b)` o, mejor, `(cons '+ (list 'a 'b))`.

### 4.4. Trampas de fidelidad verificadas

1. **`LIST` evalúa en SBCL.** `(list '+ 'a 'b)` → `(+ A B)`; sin las comillas, evalúa variables.
2. **`PAIRLIS` invierte el orden de impresión.** `(pairlis '(a b) '(1 2))` → `((B . 2) (A . 1))`. La fórmula del Manual (p. 12) produce `(A . U)` antes que `(B . V)`. `ASSOC` no cambia; solo el orden. Para evitar sorpresas, usa una clave o no dependas del orden.
3. **`GENSYM` imprime `#:G...`.** `(gensym)` → `#:G93` (el número varía); `(symbol-package (gensym))` → `NIL`. Es único, no permanente.
4. **`EVAL` y `APPLY` son modernos en su semántica.** `(eval '(+ 1 2))` → `3`; `(apply #'+ '(1 2))` → `3`. Funcionan, pero no son el evaluador de 1963. Úsalos en el arnés.
5. **`SETQ` es global en SBCL.** No lo uses dentro del expansor; para ligar locales, aplica una `LAMBDA`.
6. **`SUBST`/`SUBLIS` aceptan palabras clave modernas.** Usa la forma de época: `(subst nuevo viejo árbol)` y `(sublis alist árbol)`.
7. **`PRINT` imprime y devuelve el objeto.** `(print 'hola)` escribe `HOLA` y devuelve `HOLA`. `TERPRI` escribe una línea y devuelve `NIL`. Son efectos: solo traza.
8. **`REMPROP` no devuelve lo que dice el Manual en SBCL.** El Manual afirma que su valor es `NIL` (p. 59); en SBCL, tras borrar, devolvió `(P 1)` en la prueba. No dependas del valor de retorno; úsalo por su efecto.
9. **`EQ` no es igualdad numérica.** Para símbolos y listas basta; para números, Common Lisp necesita `EQL`, que no está en el kit.
10. **`ATOM`/`NULL` y `NIL`.** Usa `NULL` para la lista vacía; no dependas de cómo trata `ATOM` a `NIL` en cada dialecto.

---

## 5. Pruebas de conformidad

Un test del curso debe comprobar la **forma expandida**, no solo el valor final. Si solo compruebas `(eval ...) = 3`, no distingues una expansión correcta de una función ordinaria que suma.

### 5.1. Salidas verificadas del kit

| Expresión | Salida verificada |
|---|---|
| `(cons '+ '(a b))` | `(+ A B)` |
| `(list '+ 'a 'b)` | `(+ A B)` |
| `(append '(a b) '(c d))` | `(A B C D)` |
| `(cadr '(mi-suma a b))` | `A` |
| `(caddr '(mi-suma a b))` | `B` |
| `(cddr '(mi-suma a b))` | `(B)` |
| `(pairlis '(a b) '(1 2) '((c . 3)))` | `((B . 2) (A . 1) (C . 3))` |
| `(assoc 'b '((a . 1) (b . 2)))` | `(B . 2)` |
| `(sublis '((x . shakespeare) (y . (the tempest))) '(x wrote y))` | `(SHAKESPEARE WROTE (THE TEMPEST))` |
| `(subst 'y 'x '(x a x))` | `(Y A Y)` |
| `(gensym)` | `#:G93` (el número varía) |
| `(get 'mi-ficha05 'macro)` | `NIL`; tras `(setf (get ...) 'expansor)`, `EXPANSOR`; tras `REMPROP`, `NIL` |
| `(fboundp 'deflist)` | `NIL` |
| `(fboundp 'define)` | `NIL` |
| `(fboundp 'csetq)` | `NIL` |
| `(fboundp 'putprop)` | `NIL` |
| `(fboundp 'prop)` | `NIL` |
| `(fboundp 'label)` | `NIL` |
| `(eval '(+ 1 2))` | `3` |
| `(apply #'+ '(1 2))` | `3` |

**Nota:** las salidas de `GENSYM` y el orden de `PAIRLIS` pueden variar entre ejecuciones o implementaciones. Las demás son estables en SBCL 2.6.0.

### 5.2. Prueba de forma esperada

```lisp
(defun expansion-suma (forma)
  (cons '+ (cdr forma)))

(equal (expansion-suma '(mi-suma a b)) '(+ a b))
;; => T
```

Esta prueba comprueba lo que debe comprobarse: que la salida es la forma `(+ A B)`. No evalúa la forma, no llama a `+` y no depende de los valores de `a` y `b`.

### 5.3. Prueba de no evaluación

```lisp
(expansion-suma '(mi-suma (print 1) b))
;; => (+ (PRINT 1) B)
;; No imprime 1: el expansor no evalúa el argumento.
```

Si el expansor evaluara sus argumentos, `(print 1)` se ejecutaría y aparecería un `1` en la salida. La forma expandida lo conserva como dato. Esa es la diferencia entre construir una forma y evaluarla.

### 5.4. Prueba de pureza

```lisp
(equal (expansion-suma '(mi-suma a b))
       (expansion-suma '(mi-suma a b)))
;; => T
```

Si dos llamadas con la misma forma no devuelven lo mismo, hay estado oculto. Un expansor puro no asigna, no imprime y no evalúa.

### 5.5. Lo que un test de valor no prueba

- `(= (eval (expansion-suma '(mi-suma 1 2))) 3)` prueba que la forma expandida se evalúa a `3`, pero no prueba que la expansión sea `(+ 1 2)` y no otra forma equivalente.
- Un test que usa `FUNCALL` prueba el arnés, no el expansor.
- Una salida de `FORMAT` no es una prueba: es una traza.

---

## 6. Auditoría del arnés del curso

El archivo [expansor_final.lisp:1](file:///home/alvaro/manual-de-como-funciona-lisp/clase_de_lisp/mi_expansor_final/expansor_final.lisp#L1) ya separa las tres zonas. Esta auditoría lo clasifica sin modificar el archivo.

| Lugar | Qué es | Clasificación |
|---|---|---|
| [expansor_final.lisp:1](file:///home/alvaro/manual-de-como-funciona-lisp/clase_de_lisp/mi_expansor_final/expansor_final.lisp#L1) `dispatch` | Tabla nombre → expansor. | **Arnés de registro.** `DEFUN` y `LET*` son modernos; `ASSOC` y `CADR` son de época. Devuelve el nombre del expansor. |
| [expansor_final.lisp:11](file:///home/alvaro/manual-de-como-funciona-lisp/clase_de_lisp/mi_expansor_final/expansor_final.lisp#L11) `expansion-suma` | `(cons '+ (cdr forma))`. | **Kit puro.** `CONS`, `CDR`, `QUOTE`; una línea; exactamente el contrato. |
| [expansor_final.lisp:14](file:///home/alvaro/manual-de-como-funciona-lisp/clase_de_lisp/mi_expansor_final/expansor_final.lisp#L14) `expandir-forma` | Reconoce si el operador tiene expansor y lo aplica. | **Arnés de reconocimiento.** `LISTP`, `LET*`, `IF` y `FUNCALL` son modernos; `CAR` es de época. Modela el reconocimiento del compilador. |
| [expansor_final.lisp:24](file:///home/alvaro/manual-de-como-funciona-lisp/clase_de_lisp/mi_expansor_final/expansor_final.lisp#L24) `evaluar-mi-lisp` | Expande, muestra y evalúa. | **Arnés de ejecución.** `FORMAT` y `EVAL` son modernos; nunca dentro del expansor. |

**Veredicto:** el archivo respeta el kit. La única pieza que pretende ser lógica de expansión es `expansion-suma`, y usa solo tres nombres del kit. Las otras tres son el simulador del sistema: despacho, reconocimiento y ejecución.

**Matiz histórico:** en 1963, la tabla guardaría la lambda y la aplicaría con `APPLY`; aquí `FUNCALL` es andamiaje. No es una violación del kit porque está en el arnés, no en el expansor. Lo mismo vale para `EVAL` en `evaluar-mi-lisp`: simula al evaluador que recibe la forma expandida.

---

## 7. Errores de presupuesto y protocolo de sustitución

### 7.1. Errores frecuentes

| Error | Por qué falla | Corrección con el kit |
|---|---|---|
| `LET`/`LET*` dentro del expansor | No está en el kit; liga locales con semántica moderna. | `((LAMBDA (x) ...) valor)` o eliminar la ligadura. |
| `IF`/`WHEN`/`UNLESS`/`AND`/`OR` | Fuera del estilo y del kit; `AND`/`OR` existían pero no se usan. | `COND` y `NULL`. |
| `FUNCALL` dentro del expansor | El despacho es arnés; `FUNCALL` es moderno. | El reconocimiento va fuera; en el evaluador de época, `APPLY`. |
| `DEFUN` dentro del expansor | Definir no es expandir; `DEFUN` es andamiaje. | `LAMBDA`; `DEFUN` solo en el arnés. |
| Backquote o coma | Mecanismo prohibido. | `CONS`, `LIST`, `APPEND`, `SUBLIS`. |
| `EVAL` para «ver» la expansión | Evalúa dentro de la transformación; deja de ser pura. | Devolver la forma; evaluar en el arnés. |
| Citar de más: `(QUOTE (+ a b))` | Devuelve una forma citada, no la forma. | Quitar el `QUOTE` exterior. |
| Doble paréntesis: `(LIST (LIST (QUOTE temp) e))` | Añade un nivel de anidamiento. | `(LIST (QUOTE temp) e)`. |
| `APPEND` cuando basta `CONS` | `APPEND` copia; `CONS` añade al frente. | `(CONS x lista)`. |
| `FIRST`, `SECOND`, `NTH` | No están en el kit. | `CAR`, `CADR`, `CADDR`; `NTH` se replantea. |
| Introducir variables sin `GENSYM` | Riesgo de captura. | `GENSYM` + `LAMBDA` (Etapa 6). |
| `SETF`/`PUSH` dentro del expansor | Efecto secundario; no es transformación pura. | Construir con `CONS`; registrar fuera. |
| Confundir registro con expansión | Son dos momentos. | `DEFLIST`/`GET` antes o después; el expansor solo transforma. |
| `PAIRLIS`/`SUBLIS` en `mi-suma` | Sobrepresupuesto: el contrato no las necesita. | `CONS`/`CDR`/`QUOTE`. |

### 7.2. Protocolo cuando el estudiante pide una función fuera del kit

1. **Nombra y clasifica:** «`FIRST` es moderna», «`AND` es de época pero está fuera del kit», «`NTH` no está».
2. **Pregunta qué operación necesita:** extraer, construir, decidir, ligar, sustituir, nombrar o registrar.
3. **Ofrece una alternativa del kit.** Si hay dos, explica el coste de cada una.
4. **Si no hay alternativa, detente:** «el kit no lo permite; replanteamos la forma».
5. **No introduzcas la función «solo esta vez».** Una excepción destruye el contrato.

**Tabla rápida de sustituciones:**

| Petición | Alternativa de época |
|---|---|
| `FIRST` | `CAR` |
| `REST` | `CDR` |
| `SECOND` | `CADR` |
| `THIRD` | `CADDR` |
| `NTH` | No hay acceso general en el kit; `CAR`/`CDR` anidados o replantear. |
| `PUSH` | `CONS` dentro del expansor; `SETQ`+`CONS` fuera. |
| `WHEN`/`UNLESS` | `COND`. |
| `LET`/`LET*` | `((LAMBDA (x) cuerpo) valor)`. |
| `DEFMACRO` | `DEFINE` + `DEFLIST` + indicador `MACRO` (modelo) o tabla de despacho (arnés). |
| `MACROEXPAND` | Llamar al expansor una vez (arnés) o `*EXPAND` (Primer). |
| `FUNCALL` | `APPLY` en el evaluador; no en la expansión. |
| Backquote | `CONS`/`LIST`/`APPEND` + `SUBLIS`. |
| `FORMAT` | `PRINT`/`TERPRI` en el arnés. |
| `LOOP`/`DOLIST` | Recursión con `COND`/`NULL`. |
| `DEFVAR`/`DEFPARAMETER` | `CSETQ`/`SETQ` fuera del expansor. |

### 7.3. Frases que el tutor puede usar

- «Esa función existía en la época, pero no está en el kit del curso. Podemos hacerlo con ___».
- «Esa función es moderna; solo entra en el arnés de pruebas».
- «¿Qué operación necesitas: extraer, construir, decidir, ligar, sustituir, nombrar o registrar?».
- «La fuente no lo dice; no lo invento».
- «El contrato usa tres funciones; si necesitas más, justifica cada una».

---

## 8. Lo que el tutor debe enseñar con esta ficha

### Ideas que deben quedar claras

1. **El kit es un techo, no una lista de la compra.** El contrato usa tres nombres; los ejemplos históricos usan cinco o seis.
2. **Hay tres zonas:** expansor, registro y arnés. Una función de una zona no se mete en otra.
3. **Hay tres contadores:** nombres, piezas y líneas. Una solución se audita contando.
4. **Weissman aporta cuatro piezas; Hart, cuatro decisiones.** El mecanismo es pequeño; el sistema que lo rodea es grande.
5. **`CSETQ` usa 5 funciones; `*EXPAND`, 6; `mi-suma`, 3.** El coste se compara, no se intuye.
6. **El kit se abre por etapas.** No se usa `GENSYM` en la Etapa 2 ni `SUBLIS` en `mi-suma`.
7. **`EVAL` y `APPLY` están fuera del expansor.** Son vocabulario de época, no herramientas de expansión.
8. **Época fuera del kit no es lo mismo que moderna.** `AND` existía; `LET` no está en el estilo de 1963.
9. **«Solo QUOTE» no significa «solo la función QUOTE».** Significa que el único mecanismo de citación es `QUOTE`.
10. **Si una función no está, el tutor se detiene.** No se improvisa una excepción.

### Guion breve de sesión (30–45 minutos)

1. **Recuperación (5 min):** el estudiante explica, sin mirar, qué recibe una macro, dónde vive y cuándo se expande.
2. **Clasificar (10 min):** dar diez funciones (`CAR`, `AND`, `LET`, `DEFLIST`, `GENSYM`, `EVAL`, `FIRST`, `COND`, `PUTPROP`, `SUBLIS`) y pedir que las coloque en las tres zonas. Corregir `AND` (época fuera del kit) y `PUTPROP` (posterior).
3. **Contar (10 min):** comparar `mi-suma` (3 funciones), `CSETQ` (5) y `*EXPAND` (6). Explicar por qué `mi-suma` no necesita `*EXPAND`.
4. **Abrir por etapas (10 min):** recorrer la tabla 3.4. Justificar cada apertura y preguntar qué se rompe si se abre antes.
5. **Auditar (5 min):** leer `expansor_final.lisp` y clasificar sus cuatro funciones con la tabla de la sección 6.
6. **Cierre (5 min):** protocolo de la sección 7.2; una regla para la bitácora: «el expansor transforma; el arnés ejecuta».

---

## 9. Preguntas de recuperación

1. ¿Qué diferencia hay entre «el kit» y «todo LISP 1.5»?
2. ¿Cuántos nombres tiene el kit canónico? ¿Cuántos pueden aparecer dentro del expansor?
3. ¿Qué cinco nombres añade esta ficha a la lista del prompt y por qué?
4. ¿Qué diferencia hay entre `CONS`, `LIST` y `APPEND`?
5. ¿Qué hace `CADR` y de qué composición es abreviatura?
6. ¿Qué funciones evalúan sus argumentos y cuáles no en LISP 1.5?
7. ¿Qué cambia con `LIST` al pasar de LISP 1.5 a SBCL?
8. ¿Dónde se registra la macro en el modelo de Hart?
9. ¿Qué funciones se usan para registrar y cuáles para expandir?
10. ¿Por qué `EVAL` y `APPLY` no entran en el expansor?
11. ¿Qué cuatro piezas enumera Weissman?
12. ¿Qué cuatro decisiones enumera Hart?
13. ¿Cuántas funciones distintas usa `*EXPAND`? ¿Y `CSETQ`? ¿Y `mi-suma`?
14. ¿Qué se abre en la Etapa 6 y por qué?
15. ¿Qué funciones de época quedan fuera del kit y por qué?
16. ¿Qué garantiza `GENSYM` y qué no?
17. ¿Qué diferencia hay entre `*EXPAND` y una expansión completa?
18. ¿Qué hace el arnés y qué no es lógica de expansión?
19. ¿Qué imprime `(gensym)` en SBCL y qué significa?
20. ¿Por qué `PAIRLIS` imprime los pares en orden inverso en SBCL?

---

## 10. Lo que el tutor NO debe inferir

- **No** digas que el kit es todo LISP 1.5. Es un subconjunto didáctico.
- **No** digas que los 32 nombres son primitivas. Hay composiciones (`CADR`, `CADDR`, `CDDR`), formas (`LAMBDA`) y piezas de sistema (`EVAL`, `PRINT`).
- **No** digas que Hart usó los 32 nombres. Usó un subconjunto; el resto son piezas del sistema o del curso.
- **No** digas que `AND`/`OR`/`PROG` son modernas. Existían; están fuera por decisión.
- **No** digas que `EVAL`/`APPLY` están prohibidas en la época. Existían; esta ficha las confina al arnés.
- **No** digas que el prompt y esta ficha son idénticos. Esta ficha añade cinco nombres y separa tres zonas.
- **No** digas que `LIST` no evalúa en SBCL. En SBCL evalúa; en LISP 1.5 era FSUBR.
- **No** digas que `PAIRLIS` conserva el orden en SBCL. Lo invierte en la impresión.
- **No** digas que `GENSYM` produce nombres permanentes. No son permanentes (Manual, p. 66).
- **No** digas que `DEFINE`/`DEFLIST` existen en SBCL. No existen; se modelan.
- **No** digas que `PUTPROP`/`DEFPROP` son de 1963. Son de MACLISP (1974).
- **No** digas que `*EXPAND` es una primitiva. Es una función del sistema del *Primer*, reconstruible con el kit.
- **No** digas que la expansión evalúa argumentos. Construye una forma; la evaluación ocurre después.
- **No** digas que el arnés es lógica de expansión. El arnés ejecuta, registra o prueba.
- **No** conviertas el kit en `DEFMACRO`, `MACROEXPAND`, backquote o coma.
- **No** inventes páginas ni equivalencias de SBCL. Si no está verificado, dilo.
- **No** digas que una solución con más funciones es «más completa». Es más caro y más difícil de explicar.

---

## 11. Checklist de alcance para la IA tutora

Antes de responder cualquier pregunta basada en esta ficha:

- [ ] He leído esta ficha completa.
- [ ] Toda función que propongo está en la tabla de la sección 2.
- [ ] Distingo las tres zonas: expansor, registro y arnés.
- [ ] No uso `EVAL`, `APPLY`, `PRINT` ni `TERPRI` dentro del expansor.
- [ ] No uso `DEFUN`, `LET`, `LET*`, `IF`, `AND`, `OR`, `SETF` ni `FUNCALL` dentro del expansor.
- [ ] No uso backquote, coma ni coma-arroba.
- [ ] El contrato sigue siendo `(mi-suma a b)` → `(+ a b)`.
- [ ] Si introduzco variables, uso `GENSYM`.
- [ ] La expansión es pura y de un nivel.
- [ ] El registro usa `DEFINE`/`DEFLIST`/`GET` o la tabla de despacho del arnés.
- [ ] No llamo «modernas» a `AND`, `OR` o `PROG`: están fuera del kit por decisión.
- [ ] No importo `DEFMACRO`, `MACROEXPAND` ni `MACRO-FUNCTION`.
- [ ] No presento `PUTPROP`/`DEFPROP` como parte del kit de 1963.
- [ ] Explico que `LIST` evalúa en SBCL y no en LISP 1.5.
- [ ] Explico que `GENSYM` es único pero no permanente.
- [ ] Si la función no está, me detengo y ofrezco una alternativa de la sección 7.2.
- [ ] Si la fuente no responde, digo «la fuente no lo dice» y no invento.
- [ ] No presento el arnés como lógica de expansión.

---

## 12. Referencias de esta ficha

- Prompt del curso: [`prompt_tutor_macros_1963.md`](prompt_tutor_macros_1963.md). Regla de época, contrato y etapas.
- Hart, Timothy P. «MACRO Definitions for LISP». AIM-057, MIT Artificial Intelligence Laboratory, 1963. <https://bitsavers.org/pdf/mit/ai/aim/AIM-057.pdf>
- Weissman, Clark. *LISP 1.5 Primer*. Belmont, California: Dickenson Publishing Company, 1967. <https://softwarepreservation.computerhistory.org/LISP/book/Weismann_LISP1.5_Primer_1967.pdf>
- McCarthy, John; Abrahams, Paul W.; Edwards, Daniel J.; Hart, Timothy P.; Levin, Michael I. *LISP 1.5 Programmer's Manual*. Cambridge, Massachusetts: The MIT Press, 1962 (2.ª ed., 1985). <https://softwarepreservation.computerhistory.org/LISP/book/LISP%201.5%20Programmers%20Manual.pdf>
- Moon, David A. *MACLISP Reference Manual*. Revision 0. Cambridge, Massachusetts: Project MAC, Massachusetts Institute of Technology, abril de 1974. <https://softwarepreservation.computerhistory.org/LISP/MIT/Moon-MACLISP_Reference_Manual-Apr_08_1974.pdf>
- Índice de la familia LISP 1.5, Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/lisp15_family.html>

---

## 13. Estado de la serie

| Ficha | Contenido | Estado |
|---|---|---|
| 01 | Hart, AIM-057 (1963): property list, `macro[1]`, `define`, `CSETQ`, `GENSYM` | completada |
| 02 | Weissman, *LISP 1.5 Primer* (1967): `MACRO`, `*EXPAND`, `CSETQ`, reglas | completada |
| 03 | *LISP 1.5 Programmer's Manual* (1962): a-lists, `DEFLIST`/`GET`, p-lists, `SUBST`/`SUBLIS`, `EVAL`/`APPLY`, `GENSYM` | completada |
| 04 | Moon, *MACLISP Reference Manual* (1974): propiedad funcional `macro`, forma completa, reevaluación, compilador | completada |
| 05 | Kit cerrado de funciones y presupuesto histórico | **esta ficha** |
| 06 | Protocolo de lectura y enseñanza para la IA tutora | completada (ficha 06) |

Esta ficha 05 es la referencia normativa del kit y prevalece sobre los resúmenes de las fichas 01–04. La ficha 06 es el protocolo de lectura: qué archivos debe leer la IA, en qué orden y con qué reglas.
