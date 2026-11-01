# Ficha 03 — John McCarthy et al., *LISP 1.5 Programmer's Manual* (1962)

> **Serie:** fuentes para un tutor de macros al estilo de 1963.
> **Esta ficha:** la infraestructura que Hart da por conocida: property lists, `DEFLIST`, `GET`, entornos con `PAIRLIS`/`ASSOC`, sustitución con `SUBST`/`SUBLIS` y el intérprete pedagógico `EVAL`/`APPLY`.
> **Objetivo:** que el tutor pueda explicar **dónde vive** una macro (`deflist[1;MACRO]`), **cómo se recupera** (`get`) y **qué significa expandir** en términos de listas, sin atribuir al Manual de 1962 ningún mecanismo de macros que no contiene.

---

## 0. Cómo usar esta ficha

Para el estudiante:

- Léela después de las fichas 01 y 02. Hart dice «pon el indicador `MACRO` en la property list»; esta ficha explica qué es una property list y qué hace `deflist`.
- No intentes memorizar las definiciones de `EVAL` y `APPLY`. Úsalas como un mapa de cómo LISP 1.5 relaciona funciones, argumentos y entorno.
- Ten presente que el Manual de 1962 **no documenta macros**. El indicador `MACRO` es la aportación de Hart en 1963. El Manual aporta el mecanismo general (`DEFLIST`) sobre el que Hart construye.
- Distingue tres cosas que se llaman parecido: el `CSETQ` del Manual (una forma especial del sistema), el `CSETQ` de Hart (una macro de ejemplo) y el `CSETQ` del *Primer* (la misma macro, documentada después).

Para la IA tutora:

1. Lee esta ficha completa antes de explicar el registro de macros o el entorno de expansión.
2. Usa solo las citas marcadas **CITA** para afirmaciones históricas.
3. Trata **RECONSTRUCCIÓN** como ejemplo didáctico, nunca como texto del Manual.
4. No presentes `EVAL` ni `APPLY` como funciones que el estudiante deba usar para construir la macro. Son modelos explicativos.
5. No digas que el Manual de 1962 define macros. No lo hace; define el almacenamiento en property lists y la función general `DEFLIST`.
6. Si una pregunta no se responde con esta ficha, di «la fuente no lo dice» y no inventes.
7. No conviertas nada de esta ficha en una excusa para usar `DEFMACRO`, backquote, coma, `&body` o `MACROEXPAND`.

---

## 1. Registro bibliográfico

- **Autores:** John McCarthy, Paul W. Abrahams, Daniel J. Edwards, Timothy P. Hart, Michael I. Levin.
- **Título:** *LISP 1.5 Programmer's Manual*.
- **Editorial:** The MIT Press, Cambridge, Massachusetts.
- **Año:** 1962. Hay una segunda edición de 1985.
- **Extensión:** 116 páginas en el PDF consultado.
- **Secciones relevantes:**
  - Sección I, «The LISP Language», pp. 11–14: `SUBST`, `PAIRLIS`, `ASSOC`, `SUBLIS`, `EVALQUOTE`, `APPLY`, `EVAL`.
  - Sección 2, pp. 17–18: constantes, funciones y búsqueda en property lists.
  - Sección 7.3, «Property Lists», pp. 39–41.
  - Apéndice A, pp. 58–59: `DEFINE`, `DEFLIST`, `PROP`, `GET`, `CSET`, `CSETQ`, `REMPROP`.
  - Apéndice A, p. 66: `GENSYM`.
  - Apéndice B, p. 70: definición del intérprete realmente implementado.
- **Fuente consultada:** PDF en Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/book/LISP%201.5%20Programmers%20Manual.pdf>
- **Acceso:** 1 de noviembre de 2026.
- **Nota de transcripción:** el PDF tiene capa de texto, pero el OCR de la tipografía mecanográfica es muy irregular, sobre todo en subíndices y corchetes. Las citas se cotejaron con las imágenes de las páginas. Se normalizó el espaciado, la indentación y la notación de las fórmulas; no se corrigieron las palabras ni las definiciones del autor. Cuando una fórmula impresa parece incompleta, se advierte en el texto.

### Numeración de páginas

- Las citas «p. 11», «p. 41», etc. se refieren a la **página impresa** del Manual.
- En el PDF descargado, la página impresa `N` corresponde a la página `N + 8`. Por ejemplo, la p. 11 es la página 19 del PDF; la p. 41 es la 49; la p. 66 es la 74.
- El Apéndice B empieza en la p. 70 (PDF 78); allí está la definición del intérprete implementado que citamos.

---

## 2. Por qué esta fuente es la tercera piedra angular

Hart (1963) no inventa un almacén nuevo para las macros. Reutiliza el almacén que el Manual ya describe: la **property list** de cada símbolo atómico, y la función general **`DEFLIST`**, que puede instalar *cualquier* indicador. Su aportación es elegir el indicador `MACRO` y enseñar a `define` a mirarlo.

Esta ficha aporta las piezas que hacen legible esa decisión:

1. **Property lists:** cada átomo tiene una lista plana de indicadores y valores (`EXPR`, `SUBR`, `APVAL`, `PNAME`).
2. **`DEFLIST`:** instala cualquier indicador en esa lista; `DEFINE` es solo `DEFLIST[x;EXPR]`.
3. **`GET`:** recupera el valor asociado a un indicador.
4. **Entornos:** `PAIRLIS` construye una a-list y `ASSOC` la consulta; `EVAL`/`APPLY` muestran cómo se usan.
5. **Sustitución:** `SUBST` y `SUBLIS` muestran la operación básica de reemplazar símbolos por valores, con sus límites.
6. **`GENSYM`:** genera nombres únicos no permanentes, útil cuando una expansión necesita un nombre fresco.

| Idea | Dónde aparece | Consecuencia para el curso |
|---|---|---|
| Cada átomo tiene property list | CITA p. 39 | El símbolo puede llevar su definición consigo; no hace falta un registro central. |
| `DEFLIST` instala cualquier indicador | CITA p. 41 | `MACRO` puede vivir en la misma estructura que `EXPR`. |
| `DEFINE` es `DEFLIST[x;EXPR]` | CITA pp. 41 y 58 | Hart puede escribir `macro[1] = deflist[1;MACRO]` sin inventar almacenamiento. |
| `GET` lee un indicador | CITA p. 41 | Recuperar el expansor es una lectura de p-list. |
| El `APPLY` real busca en la p-list | CITA p. 70 | La p-list es un lugar natural para definiciones de función. |
| `EVAL`/`APPLY` impresos son pedagógicos | CITA p. 14 | No son las funciones internas; no se usan como kit de expansión. |
| `PAIRLIS`/`ASSOC` manejan el entorno | CITA pp. 12–13 | Explican cómo se ligan parámetros y por qué la sustitución puede capturar variables. |
| `GENSYM` crea nombres únicos | CITA p. 66 | Hay una herramienta de época para evitar colisiones de nombres. |

---

## 3. Citas textuales y traducción

### 3.1. Sustitución y entornos: `SUBST`, `SUBLIS`, `PAIRLIS`, `ASSOC` (pp. 11–12)

Estas funciones no son «macros»; son las piezas con las que el Manual explica cómo se reemplazan símbolos y cómo se guardan valores de variables. El tutor las necesita para hablar de expansión sin magia.

**CITA (p. 11):**

> “This function gives the result of substituting the S-expression x for all occurrences of the atomic symbol y in the S-expression z.”

**TRADUCCIÓN:**

> «Esta función da como resultado la sustitución de todas las apariciones del símbolo atómico `y` en la expresión-S `z` por la expresión-S `x`.»

**Fórmula impresa (p. 11), normalizada:**

```text
subst[x;y;z] = [equal[y;z] → x;
                atom[z]   → z;
                T         → cons[subst[x;y;car[z]];
                                  subst[x;y;cdr[z]]]]
```

**Ejemplo impreso (p. 11):**

```text
subst[(X . A);B;((A . B) . C)] = ((A . (X . A)) . C)
```

**Lectura:** `SUBST` no distingue posiciones: si encuentra `B`, lo cambia tanto en el lugar de un argumento como en el lugar de una función. Es una sustitución estructural ciega. Eso basta para el ejemplo `CSETQ`, pero no es un mecanismo higiénico.

**CITA (p. 12):**

> “This function gives the list of pairs of corresponding elements of the lists x and y, and appends this to the list a. The resultant list of pairs, which is like a table with two columns, is called an association list.”

**TRADUCCIÓN:**

> «Esta función da la lista de pares de elementos correspondientes de las listas `x` e `y`, y la añade a la lista `a`. La lista de pares resultante, que es como una tabla de dos columnas, se llama lista de asociación.»

**Fórmula impresa (p. 12), normalizada:**

```text
pairlis[x;y;a] = [null[x] → a;
                  T       → cons[cons[car[x];car[y]];
                                pairlis[cdr[x];cdr[y];a]]]
```

**Ejemplo impreso (p. 12):**

```text
pairlis[(A B C);(U V W);((D . X) (E . Y))] =
  ((A . U) (B . V) (C . W) (D . X) (E . Y))
```

**CITA (p. 12):**

> “If a is an association list such as the one formed by pairlis in the above example, then assoc will produce the first pair whose first term is x. Thus it is a table searching function.”

**TRADUCCIÓN:**

> «Si `a` es una lista de asociación como la que forma `pairlis` en el ejemplo anterior, entonces `assoc` produce el primer par cuyo primer término es `x`. Por tanto, es una función de búsqueda en tabla.»

**Fórmula impresa (p. 12), tal como aparece:**

```text
assoc[x;a] = [equal[caar[a];x] → car[a];
              T                → assoc[x;cdr[a]]]
```

**Advertencia de fidelidad:** la fórmula impresa **no incluye un caso base** para `a` vacía. Tal como está, una búsqueda que no encuentra `x` no termina en este modelo pedagógico (en el sistema real hay diagnósticos de error, pp. 32–33). Nuestra reconstrucción añade `(NULL A) → NIL` para poder probarla; es una corrección declarada, no una cita.

**Ejemplo impreso (p. 12):**

```text
assoc[B;((A . (M N)),(B . (CAR X)),(C . (QUOTE M)),(C . (CDR X)))]
  = (B . (CAR X))
```

**CITA (p. 12):**

> “Here a is assumed to be an association list of the form ((u1 . v1) ... (un . vn)), where the ui's are atomic, and y is any S-expression. What sublis does, is to treat the ui's as variables when they occur in y, and to substitute the corresponding vi's from the pair list. In order to define sublis, we first define an auxiliary function.”

**TRADUCCIÓN:**

> «Aquí se supone que `a` es una lista de asociación de la forma `((u1 . v1) ... (un . vn))`, donde los `ui` son atómicos, e `y` es una expresión-S cualquiera. Lo que hace `sublis` es tratar los `ui` como variables cuando aparecen en `y`, y sustituir los `vi` correspondientes de la lista de pares. Para definir `sublis`, primero definimos una función auxiliar.»

**Fórmulas impresas (p. 12), normalizadas:**

```text
sub2[a;z] = [null[a]        → z;
             eq[caar[a];z]  → cdar[a];
             T              → sub2[cdr[a];z]]

sublis[a;y] = [atom[y] → sub2[a;y];
               T       → cons[sublis[a;car[y]];
                             sublis[a;cdr[y]]]]
```

**Ejemplo impreso (p. 12):**

```text
sublis[((X . SHAKESPEARE) (Y . (THE TEMPEST)));(X WROTE Y)] =
  (SHAKESPEARE WROTE (THE TEMPEST))
```

**Por qué importa para macros:**

- Una a-list es el entorno de `EVAL`: una lista de pares `(variable . valor)`.
- `PAIRLIS` crea ese entorno al entrar en una `LAMBDA`.
- `ASSOC` busca el valor de una variable.
- `SUBLIS` es la versión «recorre todo el árbol y sustituye variables según una tabla».
- Ninguna de las dos es higiénica: `SUBLIS` sustituye también en la posición de función si el símbolo coincide. Ese riesgo es exactamente el que `GENSYM` ayuda a evitar.

**Funciones auxiliares del mismo bloque (p. 11):**

```text
equal[x;y] = [atom[x] → [atom[y] → eq[x;y]; T → F];
              equal[car[x];car[y]] → equal[cdr[x];cdr[y]];
              T → F]

append[x;y] = [null[x] → y;
               T       → cons[car[x];append[cdr[x];y]]]

member[x;y] = [null[y]        → F;
               equal[x;car[y]] → T;
               T               → member[x;cdr[y]]]
```

No hacen falta para el contrato `(mi-suma a b)` → `(+ a b)`, pero aparecen en el mismo pasaje y explican el vocabulario del Manual.

---

### 3.2. El intérprete universal: `EVALQUOTE`, `APPLY`, `EVAL` (pp. 13–14)

**CITA (p. 13):**

> “evalquote is defined by using two main functions, called eval and apply. apply handles a function and its arguments, while eval handles forms. Each of these functions also has another argument that is used as an association list for storing the values of bound variables and function names.”

**TRADUCCIÓN:**

> «`evalquote` se define usando dos funciones principales, llamadas `eval` y `apply`. `apply` maneja una función y sus argumentos, mientras que `eval` maneja formas. Cada una de estas funciones tiene además otro argumento que se usa como lista de asociación para guardar los valores de las variables ligadas y los nombres de funciones.»

**Fórmula impresa (p. 13):**

```text
evalquote[fn;x] = apply[fn;x;NIL]
```

**Ejemplo impreso (p. 13):**

```text
evalquote[(LAMBDA (X Y) (CONS (CAR X) Y));((A B) (C D))] = (A C D)
```

**Fórmulas impresas (p. 13), normalizadas:**

```text
apply[fn;x;a] =
  [atom[fn] → [eq[fn;CAR]  → caar[x];
               eq[fn;CDR]  → cdar[x];
               eq[fn;CONS] → cons[car[x];cadr[x]];
               eq[fn;ATOM] → atom[car[x]];
               eq[fn;EQ]   → eq[car[x];cadr[x]];
               T           → apply[eval[fn;a];x;a]];
   eq[car[fn];LAMBDA] → eval[caddr[fn];pairlis[cadr[fn];x;a]];
   eq[car[fn];LABEL]  → apply[caddr[fn];x;
                             cons[cons[cadr[fn];caddr[fn]];a]]]

eval[e;a] = [atom[e] → cdr[assoc[e;a]];
             atom[car[e]] →
               [eq[car[e];QUOTE] → cadr[e];
                eq[car[e];COND]  → evcon[cdr[e];a];
                T                → apply[car[e];evlis[cdr[e];a];a]];
             T → apply[car[e];evlis[cdr[e];a];a]]

evcon[c;a] = [eval[caar[c];a] → eval[cadar[c];a];
              T               → evcon[cdr[c];a]]

evlis[m;a] = [null[m] → NIL;
              T       → cons[eval[car[m];a];evlis[cdr[m];a]]]
```

**Lectura guiada:**

1. `eval` de un átomo busca su valor en la a-list: `cdr[assoc[e;a]]`.
2. `eval` de `(QUOTE X)` devuelve `X` sin evaluarlo.
3. `eval` de `(COND ...)` llama a `evcon`.
4. Cualquier otra forma se evalúa como llamada: se evalúan los argumentos con `evlis` y se pasan a `apply`.
5. `apply` de un símbolo atómico comprueba si es una de las cinco funciones básicas; si no, busca su definición en la a-list.
6. `apply` de una `LAMBDA` liga los parámetros con `pairlis` y evalúa el cuerpo.
7. `apply` de un `LABEL` añade el nombre y la definición a la a-list.

**CITA (p. 14):**

> “The reader is warned that the definitions of apply and eval given above are pedagogical devices and are not the same functions as those built into the LISP programming system. Appendix B contains the computer implemented version of these functions and should be used to decide questions about how things really work.”

**TRADUCCIÓN:**

> «Se advierte al lector que las definiciones de `apply` y `eval` dadas arriba son dispositivos pedagógicos y no son las mismas funciones que las incorporadas al sistema de programación LISP. El Apéndice B contiene la versión implementada en computadora de estas funciones y debe usarse para decidir cuestiones sobre cómo funcionan realmente las cosas.»

**Consecuencia para el tutor:** `EVAL` y `APPLY` existen en el sistema (p. 58 los lista entre las funciones del intérprete), pero las definiciones recursivas de la Sección I son un **modelo para leer**, no el código interno. No son el kit con el que se escribe la macro. Si el estudiante pregunta «¿puedo usar `EVAL` para expandir?», la respuesta de época es: no; la expansión se hace construyendo listas con `CONS`, `LIST` y `QUOTE`.

**El `APPLY` real (p. 70):**

**Fórmula impresa (p. 70), normalizada:**

```text
evalquote[fn;args] = [get[fn;FEXPR] ∨ get[fn;FSUBR] → eval[cons[fn;args];NIL];
                      T                          → apply[fn;args;NIL]]
```

**Lectura:** `evalquote` usa `get` para comprobar si el símbolo tiene un indicador `FEXPR` o `FSUBR`; si lo tiene, evalúa la forma; si no, llama a `apply`.

**Extracto normalizado (p. 70) de la definición ampliada de `apply`:**

```text
apply[fn;args;a] = [null[fn] → NIL;
                    atom[fn] → [get[fn;EXPR] → ...;
                                get[fn;SUBR] → spread[args];
                                ...];
                    ...]
```

No hace falta reproducir toda la definición. Lo esencial es que el `APPLY` implementado **consulta la property list** (`get[fn;EXPR]`, `get[fn;SUBR]`) antes de buscar en la a-list. Eso confirma que la p-list es el lugar natural donde el sistema guarda definiciones.

**CITA (p. 18):**

> “When apply interprets a function represented by an atomic symbol, it searches the p-list of the atomic symbol before searching the current a-list. Thus a define will override a LABEL.”

**TRADUCCIÓN:**

> «Cuando `apply` interpreta una función representada por un símbolo atómico, busca en la p-list del símbolo antes de buscar en la a-list actual. Por tanto, un `define` prevalece sobre un `LABEL`.»

**CITA (p. 32), diagnóstico A2:**

> “FUNCTION OBJECT HAS NO DEFINITION - APPLY. This occurs when an atomic symbol, given as the first argument of apply, does not have a definition either on its property list or on the a-list of apply.”

**TRADUCCIÓN:**

> «EL OBJETO FUNCIÓN NO TIENE DEFINICIÓN - APPLY. Esto ocurre cuando un símbolo atómico, dado como primer argumento de `apply`, no tiene definición ni en su property list ni en la a-list de `apply`.»

Ese diagnóstico es la versión real del bucle que produce nuestra reconstrucción pedagógica cuando se le pasa una función atómica sin definición. El Manual lo trata como error, no como no-terminación.

---

### 3.3. Property lists (pp. 39–41)

**CITA (p. 39):**

> “Every atomic symbol has a property list. When an atomic symbol is read in for the first time, a property list is created for it.”

**TRADUCCIÓN:**

> «Todo símbolo atómico tiene una property list. Cuando un símbolo atómico se lee por primera vez, se crea una property list para él.»

**CITA (p. 39):**

> “A property list is characterized by having the special constant 77777₈ (i.e., minus 1) as the first element of the list. The rest of the list contains various properties of the atomic symbol. Each property is preceded by an atomic symbol which is called its indicator. Some of the indicators are: PNAME — the BCD print name of the atomic symbol for input-output use. EXPR — S-expression defining a function whose name is the atomic symbol on whose property list the EXPR appears. SUBR — Function defined by a machine language subroutine. APVAL — Permanent value for the atomic symbol considered as a variable.”

**TRADUCCIÓN:**

> «Una property list se caracteriza por tener la constante especial `77777₈` (es decir, menos 1) como primer elemento de la lista. El resto de la lista contiene diversas propiedades del símbolo atómico. Cada propiedad va precedida por un símbolo atómico que se llama su indicador. Algunos de los indicadores son: `PNAME` — el nombre imprimible en BCD del símbolo atómico para entrada y salida. `EXPR` — expresión-S que define una función cuyo nombre es el símbolo atómico en cuya property list aparece `EXPR`. `SUBR` — función definida por una subrutina en lenguaje de máquina. `APVAL` — valor permanente del símbolo atómico considerado como variable.»

**Estructura esquemática de una p-list:**

```text
(-1  PNAME  CSETQ   EXPR  (LAMBDA ...)   APVAL  ...)
     └──────┬──────┘
        indicador + propiedad
```

**CITA (p. 41):**

> “The function get[x;i] can be used to find a property of x whose indicator is i. The value of get[FF;EXPR] would be (LAMBDA (X) (COND ...”

**TRADUCCIÓN:**

> «La función `get[x;i]` puede usarse para encontrar una propiedad de `x` cuyo indicador sea `i`. El valor de `get[FF;EXPR]` sería `(LAMBDA (X) (COND ...`.»

**CITA (p. 41):**

> “The function deflist[x;i] can be used to put any indicator on a property list. The first argument is a list of pairs as for define, the second argument is the indicator to be used. define[x] = deflist[x;EXPR].”

**TRADUCCIÓN:**

> «La función `deflist[x;i]` puede usarse para poner cualquier indicador en una property list. El primer argumento es una lista de pares como para `define`; el segundo argumento es el indicador que se va a usar. `define[x] = deflist[x;EXPR]`.»

**CITA (p. 41):**

> “An indicator on a property list that does not have a property following it is called a flag.”

**TRADUCCIÓN:**

> «Un indicador en una property list que no tiene una propiedad detrás se llama bandera (`flag`).»

**Diferencia clave:** una p-list **no** es una a-list.

| Estructura | Forma | Uso |
|---|---|---|
| a-list | `((x . 1) (y . 2))` | Entorno temporal de `EVAL`/`APPLY`; se construye con `PAIRLIS`. |
| p-list | `(IND1 v1 IND2 v2 ...)` | Atributos permanentes del símbolo; se consulta con `GET` y se modifica con `DEFLIST`/`CSET`. |

Confundirlas lleva a explicaciones falsas del tipo «la macro se guarda en el entorno». Hart la guarda en la **p-list**.

---

### 3.4. `DEFINE` y `DEFLIST` (pp. 58–59)

**CITA (p. 58):**

> “The argument of define, x, is a list of pairs ((u1 v1) (u2 v2) ... (un vn)) where each u is a name and each v is a λ-expression for a function. For each pair, define puts an EXPR on the property list for u pointing to v. The function of define puts things on at the front of the property list. The value of define is the list of u's.”

**TRADUCCIÓN:**

> «El argumento de `define`, `x`, es una lista de pares `((u1 v1) (u2 v2) ... (un vn))`, donde cada `u` es un nombre y cada `v` es una expresión lambda para una función. Para cada par, `define` pone un `EXPR` en la property list de `u` apuntando a `v`. La función `define` pone las cosas al frente de la property list. El valor de `define` es la lista de las `u`.»

**Fórmula impresa (p. 58):**

```text
define[x] = deflist[x;EXPR]
```

**CITA (p. 58):**

> “The function deflist is a more general defining function. Its first argument is a list of pairs as for define. Its second argument is the indicator that is to be used. After deflist has been executed with (ui vi) among its first argument, the property list of ui will begin:”

**TRADUCCIÓN:**

> «La función `deflist` es una función definidora más general. Su primer argumento es una lista de pares como para `define`. Su segundo argumento es el indicador que se va a usar. Después de ejecutar `deflist` con `(ui vi)` entre su primer argumento, la property list de `ui` empezará así:»

**Esquema impreso (p. 59):**

```text
ui → (-1  IND  vi  ...)
```

**CITA (p. 59):**

> “If deflist or define is used twice on the same object with the same indicator, the old value will be replaced by the new one.”

**TRADUCCIÓN:**

> «Si `deflist` o `define` se usan dos veces sobre el mismo objeto con el mismo indicador, el valor viejo será reemplazado por el nuevo.»

**Tabla comparativa:**

| Función | Indicador | Uso |
|---|---|---|
| `DEFINE[x]` | siempre `EXPR` | Definir funciones ordinarias. |
| `DEFLIST[x;ind]` | el que se indique | Definir funciones o instalar cualquier otro atributo. |
| `MACRO[1]` (Hart, 1963) | `MACRO` | Definir macros; es `DEFLIST[1;MACRO]`. |

**El puente histórico exacto:** el Manual autoriza `DEFLIST` con cualquier indicador. Hart elige `MACRO`. No hay una estructura nueva; hay un uso nuevo de una estructura existente. Esa es la idea que el tutor debe hacer explícita.

---

### 3.5. `GET`, `PROP`, `CSET`, `CSETQ`, `REMPROP` (p. 59)

**CITA (p. 59):**

> “The function prop searches the list x for an item that is eq to y. If such an element is found, the value of prop is the rest of the list beginning immediately after the element. Otherwise the value is u[], where u is a function of no arguments.”

**TRADUCCIÓN:**

> «La función `prop` busca en la lista `x` un elemento que sea `eq` a `y`. Si encuentra tal elemento, el valor de `prop` es el resto de la lista que empieza inmediatamente después del elemento. En caso contrario, el valor es `u[]`, donde `u` es una función sin argumentos.»

**Fórmula impresa (p. 59):**

```text
prop[x;y;u] = [null[x]       → u[];
               eq[car[x];y]  → cdr[x];
               T             → prop[cdr[x];y;u]]
```

**CITA (p. 59):**

> “get is somewhat like prop; however its value is car of the rest of the list if the indicator is found, and NIL otherwise.”

**TRADUCCIÓN:**

> «`get` es parecido a `prop`; sin embargo, su valor es el `car` del resto de la lista si se encuentra el indicador, y `NIL` en caso contrario.»

**Fórmula impresa (p. 59):**

```text
get[x;y] = [null[x]       → NIL;
            eq[car[x];y]  → cadr[x];
            T             → get[cdr[x];y]]
```

**Detalle importante:** `GET` avanza con `cdr`, no con `cddr`. Comprueba cada posición, no solo las posiciones pares. Nuestra reconstrucción respeta ese detalle.

**CITA (p. 59):**

> “This pseudo-function is used to create a constant by putting the indicator APVAL and a value on the property list of an atomic symbol. The first argument should be an atomic symbol; the second argument is the value [...]”

**TRADUCCIÓN:**

> «Esta pseudo-función se usa para crear una constante poniendo el indicador `APVAL` y un valor en la property list de un símbolo atómico. El primer argumento debe ser un símbolo atómico; el segundo argumento es el valor [...]»

**CITA (p. 59):**

> “csetq is like cset except that it quotes its first argument instead of evaluating it.”

**TRADUCCIÓN:**

> «`csetq` es como `cset` salvo que cita su primer argumento en lugar de evaluarlo.»

**CITA (p. 59):**

> “The pseudo-function remprop searches the list, x, looking for all occurrences of the indicator ind. When such an indicator is found, its name and the succeeding property are removed from the list. [...] The value of remprop is NIL.”

**TRADUCCIÓN:**

> «La pseudo-función `remprop` busca en la lista `x` todas las apariciones del indicador `ind`. Cuando encuentra tal indicador, su nombre y la propiedad siguiente se eliminan de la lista. [...] El valor de `remprop` es `NIL`.»

**No confundir los tres `CSETQ`:**

| Nombre | Qué es | Fuente |
|---|---|---|
| `CSETQ` del Manual | Forma especial del sistema (`FEXPR`) que crea una constante con `APVAL`. | Manual, p. 59 |
| `CSETQ` de Hart | Macro de ejemplo que expande `(CSETQ A B)` a `(CSET (QUOTE A) B)`. | Hart, p. 1 |
| `CSETQ` del *Primer* | La misma macro, documentada como ejemplo de `MACRO`. | Weissman, p. 156 |

El tutor debe nombrar la fuente cada vez que use la palabra `CSETQ`, o el estudiante creerá que son la misma cosa.

---

### 3.6. `GENSYM` (p. 66)

**CITA (p. 66):**

> “The function gensym has no arguments. Its value is a new, distinct, and freshly-created atomic symbol with a print name of the form G00001, G00002, ..., G99999. This function is useful for creating atomic symbols when one is needed; each one is guaranteed unique. gensym names are not permanent and will not be recognized if read back in.”

**TRADUCCIÓN:**

> «La función `gensym` no tiene argumentos. Su valor es un símbolo atómico nuevo, distinto y recién creado, con un nombre imprimible de la forma `G00001`, `G00002`, ..., `G99999`. Esta función es útil para crear símbolos atómicos cuando se necesita uno; cada uno está garantizado como único. Los nombres de `gensym` no son permanentes y no serán reconocidos si se vuelven a leer.»

**Consecuencias:**

- Un símbolo de `GENSYM` sirve para evitar colisiones dentro de una expansión, pero no se puede escribir en un archivo y recuperar después con el mismo significado.
- En el curso, `(GENSYM)` sin argumentos es la forma de época. Las variantes modernas con prefijo o paquete no pertenecen a 1962.
- Hart usa `(GENSYM)` en su macro `select` (ficha 01, p. 3). Eso muestra que el problema de los nombres frescos ya estaba presente, aunque el memo no desarrolle una teoría de higiene.

---

## 4. Derivaciones y reconstrucción

### 4.1. El puente exacto hacia Hart

Tres fórmulas, dos fuentes:

```text
Manual, p. 41:   define[x]   = deflist[x;EXPR]
Hart, p. 2:      macro[1]    = deflist[1;MACRO]
Hart, p. 2:      define[1]   = deflist[mdef[1];EXPR]
```

**Lectura:**

1. El Manual ya tiene un definidor general: `DEFLIST`.
2. `DEFINE` es el caso particular en que el indicador es `EXPR`.
3. Hart usa el mismo `DEFLIST` con el indicador `MACRO`. Eso es `macro[1]`.
4. Hart cambia `define` para que, antes de instalar el `EXPR`, recorra la definición con `mdef` y expanda las macros que encuentre.
5. Por eso `define[1] = deflist[mdef[1];EXPR]`: no es una función distinta, es `DEFLIST` aplicado a la definición ya expandida.

**Lo que Hart añade no es almacenamiento, sino un indicador y un recorrido.** El Manual aporta el almacenamiento; Hart aporta la convención y la expansión.

### 4.2. Anatomía de una p-list con `MACRO`

Antes de registrar la macro, la p-list de `CSETQ` podría tener solo su nombre imprimible:

```text
(-1  PNAME  CSETQ)
```

Después de `deflist` con el indicador `MACRO`:

```text
(-1  MACRO  (LAMBDA (FORM) ...)  PNAME  CSETQ)
```

Después de `get`:

```text
get[CSETQ;MACRO]  →  (LAMBDA (FORM) ...)
get[CSETQ;EXPR]   →  NIL
```

**Lectura:** la macro no está «en el entorno» ni «en una variable global». Está en la lista plana de atributos del símbolo, precedida por el indicador `MACRO`. `GET` la recupera; `DEFLIST` la instala; `REMPROP` la quitaría.

### 4.3. `CSETQ` paso a paso (reconstrucción)

Contrato de la macro de Hart: `(CSETQ A B)` → `(CSET (QUOTE A) B)`.

```text
Entrada:                 (CSETQ A B)
FORMA:                   (CSETQ A B)
(CADR FORMA):            A
(CADDR FORMA):           B
(QUOTE A):               (QUOTE A)
(LIST (QUOTE CSET) (LIST (QUOTE QUOTE) A) B):
                         (CSET (QUOTE A) B)
```

**Por qué el `QUOTE` interno:** el resultado se evaluará como una llamada a `CSET`. Si se construyera `(CSET A B)`, `A` se evaluaría y se perdería el nombre del símbolo que se quiere convertir en constante. El `QUOTE` conserva el nombre.

**Dónde entra `DEFLIST`:** la lambda anterior se instala con `deflist` bajo el indicador `MACRO`. La expansión en sí no usa `DEFLIST`; el registro sí. Son dos momentos distintos:

1. **Registro:** `deflist` pone la lambda en la p-list.
2. **Expansión:** la lambda recibe la forma y devuelve la forma nueva.

### 4.4. Reconstrucción ejecutable en SBCL (no es una cita)

```lisp
;;;; Reconstruccion pedagogica de primitivas del Manual LISP 1.5 (1962).
;;;; La logica usa solo primitivas de la epoca. DEFUN, LET, SETQ y FORMAT
;;;; son andamiaje moderno para poder probar las definiciones.

(defun mi-pairlis (x y a)
  (cond ((null x) a)
        (t (cons (cons (car x) (car y))
                 (mi-pairlis (cdr x) (cdr y) a)))))

;; La formula impresa no trae caso base; anadimos (NULL A) para que termine.
(defun mi-assoc (x a)
  (cond ((null a) nil)
        ((equal (car (car a)) x) (car a))
        (t (mi-assoc x (cdr a)))))

(defun mi-sub2 (a z)
  (cond ((null a) z)
        ((eq (car (car a)) z) (cdr (car a)))
        (t (mi-sub2 (cdr a) z))))

(defun mi-sublis (a y)
  (cond ((atom y) (mi-sub2 a y))
        (t (cons (mi-sublis a (car y))
                 (mi-sublis a (cdr y))))))

(defun mi-subst (x y z)
  (cond ((equal y z) x)
        ((atom z) z)
        (t (cons (mi-subst x y (car z))
                 (mi-subst x y (cdr z))))))

(defun mi-evlis (m a)
  (cond ((null m) nil)
        (t (cons (mi-eval (car m) a)
                 (mi-evlis (cdr m) a)))))

(defun mi-evcon (c a)
  (cond ((mi-eval (car (car c)) a)
         (mi-eval (car (cdr (car c))) a))
        (t (mi-evcon (cdr c) a))))

(defun mi-eval (e a)
  (cond ((atom e) (cdr (mi-assoc e a)))
        ((eq (car e) 'quote) (cadr e))
        ((eq (car e) 'cond) (mi-evcon (cdr e) a))
        (t (mi-apply (car e) (mi-evlis (cdr e) a) a))))

(defun mi-apply (fn x a)
  (cond ((atom fn)
         (cond ((eq fn 'car) (car (car x)))
               ((eq fn 'cdr) (cdr (car x)))
               ((eq fn 'cons) (cons (car x) (cadr x)))
               ((eq fn 'atom) (atom (car x)))
               ((eq fn 'eq) (eq (car x) (cadr x)))
               (t (mi-apply (mi-eval fn a) x a))))
        ((eq (car fn) 'lambda)
         (mi-eval (caddr fn) (mi-pairlis (cadr fn) x a)))
        ((eq (car fn) 'label)
         (mi-apply (caddr fn) x (cons (cons (cadr fn) (caddr fn)) a)))))

;; GET avanza con CDR, como la formula impresa (p. 59).
(defun mi-get (plist ind)
  (cond ((null plist) nil)
        ((eq (car plist) ind) (cadr plist))
        (t (mi-get (cdr plist) ind))))

(defun mi-deflist (pairs ind plist)
  (cond ((null pairs) plist)
        (t (mi-deflist (cdr pairs) ind
                       (cons ind
                             (cons (cadr (car pairs)) plist))))))

;; El expansor de CSETQ, con nombre para poder llamarlo.
;; Es la lambda que Hart registra con el indicador MACRO.
(defun expandir-csetq (forma)
  (list 'cset
        (list 'quote (cadr forma))
        (caddr forma)))
```

**Salidas verificadas en SBCL:**

```text
(mi-pairlis '(a b c) '(u v w) '((d . x) (e . y)))
  => ((A . U) (B . V) (C . W) (D . X) (E . Y))

(mi-assoc 'b '((a . (m n)) (b . (car x)) (c . (quote m)) (c . (cdr x))))
  => (B CAR X)

(mi-sublis '((x . shakespeare) (y . (the tempest))) '(x wrote y))
  => (SHAKESPEARE WROTE (THE TEMPEST))

(mi-subst '(x . a) 'b '((a . b) . c))
  => ((A X . A) . C)

(mi-eval '((lambda (x y) (cons (car x) y)) (quote (a b)) (quote (c d))) nil)
  => (A C D)

(mi-eval '(cons (quote a) (quote b)) nil)
  => (A . B)

(mi-eval '(cond ((eq (quote a) (quote b)) (quote no))
                ((atom (quote a)) (quote yes)))
         nil)
  => YES

(mi-eval '((lambda (x) (cons x x)) (quote a)) nil)
  => (A . A)

(mi-get (mi-deflist '((csetq (lambda (form)
                               (list 'cset
                                     (list 'quote (cadr form))
                                     (caddr form)))))
                    'macro
                    nil)
        'macro)
  => (LAMBDA (FORM) (LIST 'CSET (LIST 'QUOTE (CADR FORM)) (CADDR FORM)))

(mi-get <esa misma p-list> 'expr)
  => NIL

(expandir-csetq '(csetq a b))
  => (CSET 'A B)
```

**Salida de la sustitución:** el Manual imprime `((A . (X . A)) . C)`; SBCL imprime `((A X . A) . C)`. Son la misma estructura: `(A . (X . A))` y `(A X . A)` son dos notaciones de la misma lista.

**Salida de `GET`:** devuelve la lista `(LAMBDA ...)`, no un objeto función. En 1962 la definición se guarda como datos; el intérprete la evalúa cuando la necesita. Para probar la expansión en SBCL damos nombre a la misma lambda (`expandir-csetq`), en lugar de convertirla en función moderna.

**Nota sobre `MI-APPLY`:** si se le pasa un símbolo atómico sin definición, la reconstrucción entra en un bucle, porque el caso `T` vuelve a llamar a `mi-eval` sobre el mismo símbolo y `assoc` devuelve `NIL`. El sistema real no hace eso: emite el diagnóstico A2 (p. 32). No añadimos ese diagnóstico para no inventar comportamiento que la fórmula pedagógica no muestra; solo lo advertimos.

**Qué es andamiaje y qué es histórico:**

- `DEFUN`, `LET`, `SETQ`, `FORMAT`: andamiaje moderno de prueba.
- `COND`, `NULL`, `ATOM`, `EQ`, `EQUAL`, `CAR`, `CDR`, `CONS`, `CADR`, `CADDR`, `QUOTE`, `LIST`: kit histórico.
- `MI-PAIRLIS`, `MI-ASSOC`, `MI-SUB2`, `MI-SUBLIS`, `MI-SUBST`, `MI-EVLIS`, `MI-EVCON`, `MI-EVAL`, `MI-APPLY`: reconstrucciones de las definiciones impresas.
- `MI-GET`, `MI-DEFLIST`: reconstrucciones de las operaciones sobre property lists.
- `EXPANDIR-CSETQ`: la lambda de Hart, con nombre para probarla.

---

## 5. Lo que el tutor debe enseñar con esta ficha

### Lo que aporta a las etapas del curso

1. **La p-list es el almacén.** Una macro no necesita una variable global: vive como indicador en la property list del símbolo.
2. **`DEFLIST` es general.** No está atado a `EXPR`; acepta cualquier indicador. Por eso Hart puede usar `MACRO`.
3. **`DEFINE` es un caso particular.** `define[x] = deflist[x;EXPR]`. Entender esa identidad evita tratar `DEFINE` como magia.
4. **`GET` es una lectura.** Recuperar el expansor no ejecuta nada; devuelve datos.
5. **El `APPLY` real consulta la p-list.** La p-list no es un cajón secundario: es donde el sistema busca definiciones (p. 70).
6. **`EVAL`/`APPLY` impresos son un modelo.** Sirven para explicar el entorno, no para construir la macro.
7. **La a-list es el entorno.** `PAIRLIS` liga parámetros; `ASSOC` busca valores; `EVAL` usa `cdr[assoc[e;a]]`.
8. **La sustitución es ciega.** `SUBST` y `SUBLIS` no respetan posiciones ni alcance; pueden capturar variables. `GENSYM` existe para mitigar colisiones de nombres.
9. **`GENSYM` no es permanente.** Sus nombres no sobreviven a la lectura posterior.
10. **El Manual de 1962 no documenta macros.** Tiene el mecanismo general; Hart añade la convención `MACRO` en 1963.

### Presupuesto de funciones (la «limitación» del curso)

| Necesidad | Permitido | Prohibido |
|---|---|---|
| Guardar el expansor | Property list + `DEFLIST` | `DEFMACRO`, `MACRO-FUNCTION`, tabla hash global |
| Recuperar el expansor | `GET` | `MACROEXPAND`, `MACROEXPAND-1` |
| Construir el entorno | `PAIRLIS`, `ASSOC` (reconstruidas) | `LET`, `LET*`, cierres léxicos |
| Sustituir símbolos | `SUBST`, `SUBLIS`, `SUB2` | backquote, coma, `DESTRUCTURING-BIND` |
| Construir la forma | `CONS`, `LIST`, `APPEND`, `QUOTE` | backquote, coma, coma-arroba |
| Decidir | `COND`, `NULL`, `ATOM`, `EQ`, `EQUAL` | `IF`, `WHEN`, `UNLESS`, `AND`, `OR` en la expansión |
| Nombres frescos | `(GENSYM)` sin argumentos | variantes modernas con prefijo o paquete |
| Probar / registrar | `DEFUN`, `LET`, `SETQ`, `FORMAT` | usarlos dentro de la lógica de expansión |

**Nota sobre `AND`/`OR`:** el Manual sí los documenta (p. 58), así que no son modernos. El curso los deja fuera de la lógica de expansión para mantener el estilo de Hart, que usa `COND`. Si el estudiante pregunta, hay que decir la verdad: existían, pero el kit elegido no los usa.

**Regla de oro:** si una solución necesita una función que no está en la columna «Permitido», el tutor se detiene y busca una alternativa con el kit. No «resuelve» con una función moderna y luego la llama estilo 1963.

### Ejercicios de lectura

| Ejercicio | Fuente | Qué enseña |
|---|---|---|
| Trazar `pairlis[(A B C);(U V W);((D . X) (E . Y))]` | p. 12 | Cómo se construye una a-list. |
| Trazar `assoc[B;...]` y explicar por qué falta el caso base | p. 12 | Búsqueda en tabla y límites de la fórmula impresa. |
| Calcular `sublis[((X . SHAKESPEARE) (Y . (THE TEMPEST)));(X WROTE Y)]` | p. 12 | Sustitución por tabla. |
| Calcular `subst[(X . A);B;((A . B) . C)]` | p. 11 | Sustitución estructural ciega. |
| Dada una p-list, calcular `get` y `prop` | p. 59 | Lectura de indicadores. |
| Instalar una lambda con `deflist` bajo `MACRO` y recuperarla con `get` | pp. 58–59 | Registro de macros. |
| Explicar `define[x] = deflist[x;EXPR]` y `macro[1] = deflist[1;MACRO]` | pp. 41 y Hart p. 2 | El puente histórico. |
| Expandir `(CSETQ A B)` a mano | Hart p. 1 | Construcción con `LIST`/`QUOTE`. |
| Explicar por qué el `APPLY` real busca en la p-list | p. 70 | La p-list como almacén del sistema. |
| Explicar qué garantiza `GENSYM` y qué no | p. 66 | Unicidad frente a permanencia. |

### Secuencia de preguntas

- ¿Qué es una property list y en qué se diferencia de una a-list?
- ¿Qué indicadores conoce el Manual y para qué sirve cada uno?
- ¿Qué hace `deflist` que no hace `define`?
- ¿Qué devuelve `define`?
- ¿Cómo se recupera el valor de un indicador?
- ¿Avanza `get` de dos en dos o de uno en uno?
- ¿Qué pasa si `deflist` se usa dos veces con el mismo indicador?
- ¿Por qué `macro[1]` es `deflist[1;MACRO]` y no una estructura nueva?
- ¿Qué diferencia hay entre el `EVAL`/`APPLY` de la Sección I y los del Apéndice B?
- ¿Cómo se liga un parámetro en `apply`?
- ¿Qué hace `sublis` que no hace `subst`?
- ¿Por qué `subst`/`sublis` pueden capturar variables?
- ¿Qué garantiza `gensym` y qué no?
- ¿Tenía el Manual de 1962 un indicador `MACRO`?

---

## 6. Lo que el tutor NO debe inferir

- **No** digas que el Manual de 1962 define macros o el indicador `MACRO`. No lo documenta; el indicador es de Hart (1963).
- **No** digas que `EVAL` y `APPLY` de la Sección I son las funciones internas del sistema. El propio Manual advierte que son dispositivos pedagógicos (p. 14).
- **No** digas que `EVAL`/`APPLY` no existen en el sistema. Existen (p. 58), pero las definiciones impresas no son su implementación.
- **No** uses `EVAL`, `APPLY` ni `FUNCALL` modernos dentro de la lógica de expansión. El kit construye listas; no evalúa formas.
- **No** digas que `ASSOC` impreso termina cuando no encuentra la clave. La fórmula de la p. 12 no trae caso base; la reconstrucción lo añade y lo declara.
- **No** digas que `SUBLIS` es higiénico. Sustituye cualquier átomo cuyo nombre coincida, incluso en posición de función, y puede capturar variables ligadas.
- **No** digas que `SUBST` y `SUBLIS` son lo mismo. `SUBST` reemplaza un símbolo por otro en todo el árbol; `SUBLIS` usa una a-list de variables atómicas.
- **No** digas que `PAIRLIS` modifica la a-list existente. Construye una nueva lista de pares y la antepone.
- **No** digas que `GET` modifica la p-list. Solo lee; para escribir están `DEFLIST`, `CSET` y `REMPROP`.
- **No** digas que `GET` avanza de dos en dos. La fórmula impresa avanza con `CDR`.
- **No** digas que `DEFINE` devuelve la función definida. Devuelve la lista de nombres (p. 59).
- **No** digas que `DEFLIST` solo sirve para funciones. Acepta cualquier indicador; esa generalidad es justamente lo que Hart aprovecha.
- **No** digas que los nombres de `GENSYM` se pueden escribir y volver a leer con el mismo significado. No son permanentes (p. 66).
- **No** confundas el `CSETQ` del Manual (FEXPR que crea una constante) con la macro `CSETQ` de Hart y Weissman (que expande a `CSET`).
- **No** atribuyas al Manual backquote, coma, coma-arroba, `DEFMACRO`, `MACRO-FUNCTION`, `MACROEXPAND`, `&BODY`, `&REST`, `&OPTIONAL`, `&AUX`, `DESTRUCTURING-BIND`, `LET`, `LET*`, `IF`, `SETF`, `DEFVAR`, `DEFPARAMETER`, `LOOP` ni `DOLIST`.
- **No** presentes `AND`/`OR` como modernos: están en el Manual (p. 58). Simplemente no forman parte del kit de expansión del curso.
- **No** digas que la p-list y la a-list son la misma estructura. Una es plana y permanente; la otra es una lista de pares temporal.
- **No** conviertas `MACRO` en `DEFMACRO`. En esta serie, el mecanismo se llama «mi-defmacro» para evitar el anacronismo.

---

## 7. Guion breve de sesión (30–45 minutos)

1. **Recuperación (5 min):** el estudiante explica, sin mirar, dónde vive la macro según Hart y qué recibe la función macro.
2. **Entorno (10 min):** leer `PAIRLIS`, `ASSOC` y el fragmento de `EVAL` de la p. 13. Trazar `(mi-eval '((lambda (x) x) (quote a)) nil)` y localizar el par `(x . a)` en la a-list.
3. **Property lists (10 min):** leer las pp. 39–41. Dibujar una p-list con `PNAME`, `EXPR` y `APVAL`. Calcular `get` a mano.
4. **El puente (5 min):** comparar `define[x] = deflist[x;EXPR]` con `macro[1] = deflist[1;MACRO]`. Preguntar qué cambia y qué no.
5. **`CSETQ` (10 min):** derivar `(CSETQ A B)` → `(CSET (QUOTE A) B)`; explicar el `QUOTE` interno; registrar la lambda con `deflist` y recuperarla con `get`.
6. **Cierre (5 min):** `GENSYM`, límites de `SUBST`/`SUBLIS`, y una regla para la bitácora: «la macro vive en la p-list; la expansión construye listas».

---

## 8. Preguntas de recuperación

1. ¿Qué es una property list?
2. ¿Qué son el indicador y la propiedad en una p-list?
3. ¿Qué significan `PNAME`, `EXPR`, `SUBR` y `APVAL`?
4. ¿Qué hace `DEFLIST` y en qué se diferencia de `DEFINE`?
5. ¿Qué valor devuelve `DEFINE`?
6. ¿Qué pasa si se usa `DEFLIST` dos veces con el mismo indicador?
7. ¿Qué hace `GET` y cómo avanza por la lista?
8. ¿Qué hace `PROP` y en qué se diferencia de `GET`?
9. ¿Por qué `macro[1] = deflist[1;MACRO]`?
10. ¿Qué hace `PAIRLIS` y para qué sirve la a-list resultante?
11. ¿Qué hace `ASSOC` y qué le falta a la fórmula impresa?
12. ¿Qué diferencia hay entre `SUBST` y `SUBLIS`?
13. ¿Por qué `SUBST`/`SUBLIS` pueden capturar variables?
14. ¿Qué garantiza `GENSYM` y qué no garantiza?
15. ¿Qué diferencia hay entre el `EVAL`/`APPLY` de la Sección I y los del Apéndice B?
16. ¿Dónde busca el `APPLY` real la definición de una función atómica?
17. ¿Tenía el Manual de 1962 un indicador `MACRO`? ¿Quién lo introdujo?
18. ¿Por qué el `CSETQ` del Manual no es la macro `CSETQ` de Hart?

---

## 9. Checklist de alcance para la IA tutora

Antes de responder cualquier pregunta basada en esta ficha:

- [ ] He leído esta ficha completa.
- [ ] Toda afirmación histórica está respaldada por una **CITA** con página.
- [ ] No he introducido ninguna función moderna en la lógica de expansión.
- [ ] El contrato del ejercicio sigue siendo `(mi-suma a b)` → `(+ a b)`.
- [ ] La expansión usa solo funciones del kit cerrado (ficha 05).
- [ ] `DEFUN`, `LET`, `SETQ` y `FORMAT` aparecen solo como andamiaje de pruebas.
- [ ] Distingo entre **cita**, **traducción** y **reconstrucción**.
- [ ] No atribuyo al Manual de 1962 el indicador `MACRO`.
- [ ] No presento `EVAL`/`APPLY` de la Sección I como las funciones internas.
- [ ] No presento `ASSOC` impreso como una definición que termina siempre.
- [ ] No presento `SUBST`/`SUBLIS` como mecanismos higiénicos.
- [ ] No confundo p-list con a-list.
- [ ] No confundo el `CSETQ` del Manual con la macro `CSETQ`.
- [ ] No presento `GENSYM` como un nombre permanente.
- [ ] Si el estudiante pide una función fuera del kit, me detengo y le ofrezco una alternativa de época.
- [ ] Si la fuente no responde, digo «la fuente no lo dice» y no invento.

---

## 10. Referencias de esta ficha

- McCarthy, John; Abrahams, Paul W.; Edwards, Daniel J.; Hart, Timothy P.; Levin, Michael I. *LISP 1.5 Programmer's Manual*. Cambridge, Massachusetts: The MIT Press, 1962 (2.ª ed., 1985). <https://softwarepreservation.computerhistory.org/LISP/book/LISP%201.5%20Programmers%20Manual.pdf>
- Hart, Timothy P. «MACRO Definitions for LISP». AIM-057, MIT Artificial Intelligence Laboratory, 1963. <https://bitsavers.org/pdf/mit/ai/aim/AIM-057.pdf>
- Weissman, Clark. *LISP 1.5 Primer*. Belmont, California: Dickenson Publishing Company, 1967. <https://softwarepreservation.computerhistory.org/LISP/book/Weismann_LISP1.5_Primer_1967.pdf>
- Moon, David A. *Maclisp Reference Manual*. MIT Project MAC, 1974. <https://softwarepreservation.computerhistory.org/LISP/MIT/Moon-MACLISP_Reference_Manual-Apr_08_1974.pdf>
- Índice de la familia LISP 1.5, Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/lisp15_family.html>

---

## 11. Estado de la serie

| Ficha | Contenido | Estado |
|---|---|---|
| 01 | Hart, AIM-057 (1963): property list, `macro[1]`, `define`, `CSETQ`, `GENSYM` | completada |
| 02 | Weissman, *LISP 1.5 Primer* (1967): `MACRO`, `*EXPAND`, `CSETQ`, reglas | completada |
| 03 | *LISP 1.5 Programmer's Manual* (1962): a-lists, `DEFLIST`/`GET`, p-lists, `SUBST`/`SUBLIS`, `EVAL`/`APPLY`, `GENSYM` | **esta ficha** |
| 04 | Moon, *MACLISP Reference Manual* (1974): propiedad funcional `macro`, forma completa, reevaluación, compilador | completada (ficha 04) |
| 05 | Kit cerrado de funciones y presupuesto histórico | pendiente |
| 06 | Protocolo de lectura y enseñanza para la IA tutora | pendiente |

La ficha 04 muestra qué cambia cuando las macros pasan a MACLISP y por qué ese contraste ayuda a no retroproyectar rasgos modernos al mecanismo de 1963. La ficha 05 cerrará el kit de funciones; la 06 dará el protocolo de lectura para la IA tutora.
