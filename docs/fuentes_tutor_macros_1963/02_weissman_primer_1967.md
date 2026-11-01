# Ficha 02 — Clark Weissman, *LISP 1.5 Primer* (1967)

> **Serie:** fuentes para un tutor de macros al estilo de 1963.
> **Esta ficha:** fuente contemporánea que documenta el `MACRO` ya utilizable. Se lee completa antes de enseñar la Etapa 5 del prompt.
> **Objetivo:** que el tutor y el estudiante entiendan el contrato del `MACRO` del *Primer*: qué recibe, cuándo se ejecuta, cómo expande un nivel con `*EXPAND`, y por qué debe definirse antes de usarse y no puede ser recursivo.

---

## 0. Cómo usar esta ficha

Para el estudiante:

- Léela después de la ficha 01. Hart explica **dónde vive** la macro; Weissman explica **cómo se usa** en un sistema con compilador.
- No memorices el código de `*EXPAND`. Entiende qué hace en cada paso y por qué el compilador tiene que llamarlo varias veces.
- No la leas como un tutorial de Common Lisp. El *Primer* describe LISP 1.5 en 1967, con `DEFINE`, `MACRO` y `*EXPAND` como piezas del sistema.

Para la IA tutora:

1. Lee esta ficha completa antes de enseñar la Etapa 5.
2. Usa solo las citas marcadas **CITA** para afirmaciones históricas.
3. Trata **RECONSTRUCCIÓN** como ejemplo didáctico, nunca como texto de Weissman.
4. Antes de proponer una función, compruébala contra el kit cerrado de la ficha 05. Si no está, detente.
5. Si una pregunta no se responde con esta ficha, di «la fuente no lo dice» y no inventes.
6. No conviertas esta ficha en una excusa para usar `DEFMACRO`, backquote, coma o `&body`.
7. No atribuyas al *Primer* el registro en property lists que sí describe Hart. Son dos mecanismos emparentados, pero no idénticos.

---

## 1. Registro bibliográfico

- **Autor:** Clark Weissman.
- **Afiliación:** Programming Systems Staff Head, Research and Technology Division, System Development Corporation.
- **Título:** *LISP 1.5 Primer*.
- **Editorial:** Dickenson Publishing Company, Inc., Belmont, California.
- **Año:** 1967.
- **Número de catálogo de la Library of Congress:** 67-20611.
- **Extensión:** 243 páginas en el PDF consultado.
- **Capítulo relevante:** capítulo 19, «List Structures, Property Lists, and Macros», pp. 144–160.
- **Ejercicios de macros:** ejercicios 11–16, pp. 159–160.
- **Soluciones de esos ejercicios:** apéndice A, pp. 206–208.
- **Referencias:** p. 220; Hart aparece como referencia 11.
- **Fuente consultada:** PDF en Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/book/Weismann_LISP1.5_Primer_1967.pdf>
- **Acceso:** 31 de octubre de 2026.
- **Nota de transcripción:** el PDF tiene capa de texto, pero el OCR de las páginas mecanografiadas es irregular. Las citas se cotejaron con las imágenes de las páginas. Se normalizó el espaciado y la indentación; no se corrigieron las palabras del autor. El nombre del archivo dice «Weismann», pero el autor es **Clark Weissman**.

### Numeración de páginas

- Las citas «p. 152», «p. 153», etc. se refieren a la **página impresa** del libro.
- En el PDF descargado, la página impresa `N` corresponde a la página `N + 15`. Por ejemplo, la p. 152 es la página 167 del PDF; la p. 156 es la 171.
- El capítulo 19 empieza en la p. 144 (PDF 159). Las soluciones de los ejercicios de macros están en las pp. 206–208 (PDF 221–223).

---

## 2. Por qué esta fuente es la segunda piedra angular

Hart (1963) propone el mecanismo y muestra el ejemplo `CSETQ`. Weissman (1967) documenta el `MACRO` **ya integrado en un sistema LISP 1.5 con compilador**, con una sintaxis de uso, un auxiliar de expansión completo (`*EXPAND`) y una lista de reglas explícitas.

El *Primer* aporta cinco cosas que Hart no desarrolla con la misma claridad:

1. **Sintaxis de uso:** `MACRO` toma una lista de definiciones con el mismo formato que `DEFINE`.
2. **Momento de ejecución:** la función macro se ejecuta **antes** de que se compile la expresión lambda que la contiene.
3. **Argumento:** la macro recibe **la forma completa** en la que se usa, no los argumentos evaluados.
4. **Expansión de un nivel:** `*EXPAND` construye un solo nivel; el compilador repite la operación mientras encuentre la macro.
5. **Reglas:** debe definirse antes de usarse, no puede ser recursiva, y puede usarse dentro de otras definiciones de macros.

Además, el *Primer* incluye a Hart en su bibliografía (referencia 11, p. 220), lo que documenta la línea histórica. Pero **no reproduce** la notación de property lists del memo de Hart: en el *Primer*, `MACRO` es una pseudo-función, no un indicador registrado con `deflist`.

| Idea | Dónde aparece | Consecuencia para el curso |
|---|---|---|
| `MACRO` es una pseudo-función con sintaxis tipo `DEFINE` | CITA p. 152 | Define macros mediante una pseudo-función, no mediante una llamada en tiempo de ejecución. |
| La macro recibe la forma completa | CITA p. 152 | El expansor recibe `(PLUS ...)` o `(CSETQ A B)`, no `A` ni `B` evaluados. |
| Se ejecuta antes de compilar la lambda | CITA p. 152 | La expansión es de tiempo de compilación. |
| Sustituye todas las apariciones en la lambda | CITA pp. 152–153 | La función que contiene la macro se reescribe antes de compilarse. |
| `*EXPAND` expande un nivel por llamada | CITA p. 154 | El compilador repite; la macro no se llama a sí misma. |
| Hay que definirla antes de usarla | CITA p. 155 | No hay referencias hacia adelante. |
| No puede ser recursiva | CITA p. 155 | Una macro no puede llamarse a sí misma. |
| Una macro puede usar otra macro | CITA p. 155 | El orden de definición importa. |

---

## 3. Citas textuales y traducción

### 3.1. El problema: funciones de aridad indefinida

**CITA (p. 152):**

> “A classic problem for compilers is this: How do you define a function of an indefinite number of arguments, such as PLUS? The key to the answer is that the arguments are only indefinite when you define the function, not when you run it. If you could delay compilation until run-time, at which time the number of arguments is definite, you could resolve this dilemma. In essence, this is what an interpreter does. To resolve this problem in LISP, we make use of macros via the pseudo-function MACRO.”

**TRADUCCIÓN:**

> «Un problema clásico para los compiladores es este: ¿cómo se define una función de un número indefinido de argumentos, como PLUS? La clave de la respuesta es que los argumentos solo son indefinidos cuando se define la función, no cuando se ejecuta. Si se pudiera retrasar la compilación hasta el tiempo de ejecución, cuando el número de argumentos es definido, se resolvería el dilema. En esencia, eso es lo que hace un intérprete. Para resolver este problema en LISP, usamos macros mediante la pseudo-función MACRO.»

**Qué establece:** la motivación del *Primer* no es la abstracción sintáctica moderna, sino resolver la aridad indefinida en un sistema compilado. La macro existe para reescribir la llamada antes de compilar, cuando ya se conoce el número concreto de argumentos.

**Contexto inmediatamente anterior (p. 151):**

> “In a compiler-based LISP system, we must be concerned with both compile-time and run-time activities of the system.”

> «En un sistema LISP basado en compilador, debemos ocuparnos tanto de las actividades de tiempo de compilación como de tiempo de ejecución.»

Ese par de conceptos —tiempo de compilación y tiempo de ejecución— es el vocabulario con el que el tutor debe explicar la diferencia entre una macro y una función ordinaria.

---

### 3.2. Qué es `MACRO` y cómo se escribe

**CITA (p. 152):**

> “The function MACRO takes an argument list in the same format as DEFINE, e.g.,”

**Transcripción normalizada de la sintaxis (la indentación es nuestra; el contenido es el del original):**

```text
MACRO ((
  (nombre1 (LAMBDA varlist body))
  (nombre2 (LAMBDA varlist body))
  ...
  (nombren (LAMBDA varlist body))
))
```

**CITA (p. 152):**

> “As with DEFINE, MACRO compiles each of these definitions. Now watch closely, for here comes the difference. When a macro function (defined by MACRO) is used in a lambda expression, either at the top level or within a DEFINE, the macro function is executed before the lambda expression (of which it is part) is compiled. The argument for the macro is the form in which it is used. In other words, the macro function is run before compile-time for its effect on the lambda expression.”

**TRADUCCIÓN:**

> «Como con DEFINE, MACRO compila cada una de estas definiciones. Ahora observa con atención, porque aquí viene la diferencia. Cuando una función macro (definida por MACRO) se usa en una expresión lambda, ya sea en el nivel superior o dentro de un DEFINE, la función macro se ejecuta antes de que se compile la expresión lambda (de la cual forma parte). El argumento de la macro es la forma en la que se usa. En otras palabras, la función macro se ejecuta antes del tiempo de compilación para producir su efecto sobre la expresión lambda.»

**Qué establece:** `MACRO` es una **pseudo-función** de definición, no una función que se llama en tiempo de ejecución. Recibe una lista de definiciones, como `DEFINE`. Lo que define es una **función macro** que el compilador ejecutará cuando encuentre su nombre en una lambda.

**CITA (p. 66), para el significado de «pseudo-función»:**

> “Pseudo-functions are expressions that are used like functions, but for their effect rather than for their value. They have ‘side effects’ of interest, but effects not reflected in the value of the expression.”

**TRADUCCIÓN:**

> «Las pseudo-funciones son expresiones que se usan como funciones, pero por su efecto y no por su valor. Tienen “efectos secundarios” de interés, pero efectos que no se reflejan en el valor de la expresión.»

**Consecuencia para el tutor:** `MACRO` no devuelve un valor útil como `CAR` o `CONS`; produce un efecto en el sistema: deja definida una función macro y hace que el compilador la reconozca. En el arnés de SBCL, ese efecto se simula registrando el expansor en una tabla de despacho.

---

### 3.3. El argumento es la forma completa y se ejecuta antes de compilar

**CITA (pp. 152–153):**

> “What does this buy us? That depends on the macro, but essentially it allows us to expand elements of the lambda expression before it is compiled, by substituting (for all occurrences of the macro function and its arguments) other expressions tailored to the particular use of the macro in the lambda expression. We call this macro expansion.”

**TRADUCCIÓN:**

> «¿Qué nos aporta esto? Depende de la macro, pero esencialmente nos permite expandir elementos de la expresión lambda antes de que se compile, sustituyendo (en todas las apariciones de la función macro y sus argumentos) otras expresiones adaptadas al uso particular de la macro en la expresión lambda. A esto lo llamamos expansión de macro.»

**Qué establece:** tres ideas que el estudiante debe poder repetir sin mirar:

1. La expansión ocurre **antes de compilar** la lambda que contiene la llamada.
2. Se sustituyen **todas las apariciones** de la forma macro, no solo la primera.
3. La expresión sustituta se **adapta al uso particular**: no es una plantilla fija, sino el resultado de ejecutar la función macro sobre esa forma concreta.

**Matiz importante:** «antes del tiempo de compilación» significa antes de compilar la lambda **que contiene** la llamada. No significa que la macro se ejecute al cargar el archivo ni al llamar a la función en tiempo de ejecución. En SBCL, nuestra reconstrucción llama al expansor manualmente antes de evaluar la forma; eso modela el momento, no lo reproduce con un compilador histórico.

---

### 3.4. Expansión de un nivel: `PLUS` y `*EXPAND`

**CITA (p. 153):**

> “For example, it permits us to define a ‘special form’ of an indefinite number of arguments by converting that special form to a composition of nested functions each having two arguments—the nesting being determined by examination of the particular use of the special form in the given lambda expression.”

**TRADUCCIÓN:**

> «Por ejemplo, nos permite definir una “forma especial” de un número indefinido de argumentos convirtiendo esa forma especial en una composición de funciones anidadas, cada una de dos argumentos; el anidamiento queda determinado por el examen del uso particular de la forma especial en la expresión lambda dada.»

**La definición de `PLUS` (p. 153):**

```text
MACRO ((
  (PLUS (LAMBDA (L) (*EXPAND L (QUOTE *PLUS))))
))
```

**CITA (p. 153):**

> “Here L, the argument for the macro PLUS, is the form (PLUS x1 x2 x3 x4).”

**TRADUCCIÓN:**

> «Aquí L, el argumento de la macro PLUS, es la forma (PLUS x1 x2 x3 x4).»

**CITA (p. 153):**

> “*EXPAND is a system function used exclusively for expanding macros. It has the form (*EXPAND form fn) where form is the expression to be expanded, as L above, and fn is the system function, a function of two arguments, to be used in the expansion.”

**TRADUCCIÓN:**

> «*EXPAND es una función del sistema usada exclusivamente para expandir macros. Tiene la forma (*EXPAND form fn), donde form es la expresión que se va a expandir, como L arriba, y fn es la función del sistema, una función de dos argumentos, que se usará en la expansión.»

**Definición completa de `*EXPAND` (p. 154), transcrita del original:**

```text
DEFINE ((
  (*EXPAND (LAMBDA (FORM FN)
     (COND ((NULL (CDDR FORM)) (CADR FORM))
           (T (CONS FN
                    (CONS (CADR FORM)
                          (CONS (CONS (CAR FORM) (CDDR FORM)) NIL)))))))
))
```

**CITA (p. 154):**

> “Note that *EXPAND just expands the form by one *PLUS when it is executed.”

**TRADUCCIÓN:**

> «Observa que *EXPAND solo expande la forma en un *PLUS cuando se ejecuta.»

**CITA (p. 154):**

> “By repeated application of *EXPAND each time the macro PLUS is encountered, we eventually arrive at the complete expanded form for PLUS regardless of the number of arguments, xₙ.”

**TRADUCCIÓN:**

> «Mediante la aplicación repetida de *EXPAND cada vez que se encuentra la macro PLUS, llegamos finalmente a la forma completamente expandida de PLUS, independientemente del número de argumentos, xₙ.»

**Qué establece:** `*EXPAND` **no** recorre el árbol entero ni expande todas las apariciones de una vez. Construye **un solo nivel**: sustituye la llamada exterior por `(*PLUS primer-argumento (PLUS resto))`. El compilador vuelve a encontrar la macro en el resto y repite. Esa repetición es la que produce el anidamiento completo.

**Traza verificada en SBCL; los resultados coinciden con la forma impresa en el original:**

| Llamada | Resultado |
|---|---|
| `(*EXPAND '(PLUS X1 X2 X3 X4) '*PLUS)` | `(*PLUS X1 (PLUS X2 X3 X4))` |
| `(*EXPAND '(PLUS X2 X3 X4) '*PLUS)` | `(*PLUS X2 (PLUS X3 X4))` |
| `(*EXPAND '(PLUS X3 X4) '*PLUS)` | `(*PLUS X3 (PLUS X4))` |
| `(*EXPAND '(PLUS X4) '*PLUS)` | `X4` |

Resultado final:

```text
(*PLUS X1 (*PLUS X2 (*PLUS X3 X4)))
```

**Funciones que usa `*EXPAND`:** `COND`, `NULL`, `CDDR`, `CADR`, `CONS`, `CAR`. Todas pertenecen al kit histórico. No hay backquote, coma ni `DEFMACRO`. `DEFINE` es la pseudo-función del sistema; en SBCL se sustituye por `DEFUN` solo como andamiaje.

**Nota de erratas:** en la p. 154, la traza intermedia del original imprime `form = (PLUS x2 x1 x4)`; por el contexto y por el resultado siguiente, la forma correcta es `(PLUS x2 x3 x4)`. Es una errata del libro, no una regla del mecanismo. El tutor no debe reproducirla como si fuera intencional.

---

### 3.5. Las cuatro piezas y las dos reglas

**CITA (p. 155):**

> “It should now be clear how elegant this macro system is. To solve the knotty problem of special forms of an indefinite number of arguments, all we need are four things:
>
> 1. *EXPAND—a single LISP function easily defined in LISP.
> 2. A function like the macro to be defined, but of just two arguments. Such a two-argument function is easily defined in LISP.
> 3. A macro definition of the special form.
> 4. MACRO recognition by the compiler.”

**TRADUCCIÓN:**

> «Ahora debería estar claro lo elegante que es este sistema de macros. Para resolver el intrincado problema de las formas especiales de un número indefinido de argumentos, solo necesitamos cuatro cosas:
>
> 1. *EXPAND: una sola función LISP fácil de definir en LISP.
> 2. Una función como la macro que se quiere definir, pero de solo dos argumentos. Esa función de dos argumentos es fácil de definir en LISP.
> 3. Una definición macro de la forma especial.
> 4. Reconocimiento de MACRO por parte del compilador.»

**CITA (p. 155):**

> “Macros must be defined before they are used. Once defined, macros may be used within other macro definitions, thereby providing complete generality of MACRO. Since a macro must be defined before it can be used, macro definitions cannot be recursive; i.e., a macro cannot call itself.”

**TRADUCCIÓN:**

> «Las macros deben definirse antes de usarse. Una vez definidas, las macros pueden usarse dentro de otras definiciones de macros, lo que proporciona una generalidad completa a MACRO. Como una macro debe definirse antes de poder usarse, las definiciones de macros no pueden ser recursivas; es decir, una macro no puede llamarse a sí misma.»

**Qué establece:** el *Primer* da un **presupuesto cerrado** de cuatro piezas y dos reglas. Ese presupuesto es la base de la ficha 05:

| Pieza | Qué es | Cómo se modela en el curso |
|---|---|---|
| `*EXPAND` | Función de dos argumentos que construye un nivel de expansión. | Se reconstruye con `COND`, `NULL`, `CDDR`, `CADR`, `CONS`, `CAR`. |
| Función binaria | La función “ladrillo” que la macro usa: `*PLUS`, `*TIMES`, `CSET`, etc. | Se define con `DEFINE`/`DEFUN` y el kit histórico. |
| Definición `MACRO` | Una `LAMBDA` de un argumento que devuelve la forma expandida. | Es el expansor; recibe la forma completa. |
| Reconocimiento del compilador | El sistema ejecuta la macro antes de compilar la lambda. | En SBCL lo simula el despachador del arnés de pruebas. |

Las dos reglas —**definir antes de usar** y **no recursiva**— no son detalles de implementación: son consecuencias directas de que la expansión ocurra antes de compilar. Si la macro no está definida, el compilador no puede reconocerla; si se llamara a sí misma, no habría un punto de parada antes de la compilación.

---

### 3.6. `CSETQ`: el ejemplo más cercano al contrato del curso

**CÓDIGO CITADO (p. 156):**

```text
MACRO ((
  (CSETQ (LAMBDA (FORM)
           (LIST (QUOTE CSET)
                 (LIST (QUOTE QUOTE) (CADR FORM))
                 (CADDR FORM))))
))
```

**CITA (p. 156):**

> “Then whenever the form (CSETQ A B) is encountered, (CSET (QUOTE A) B) will be substituted and compiled.”

**TRADUCCIÓN:**

> «Entonces, cada vez que se encuentre la forma (CSETQ A B), se sustituirá y compilará (CSET (QUOTE A) B).»

**Derivación:**

| Paso | Valor |
|---|---|
| Forma de entrada | `(CSETQ A B)` |
| `FORM` | `(CSETQ A B)` |
| `(CADR FORM)` | `A` |
| `(CADDR FORM)` | `B` |
| `(LIST (QUOTE QUOTE) (CADR FORM))` | `(QUOTE A)` |
| `(LIST (QUOTE CSET) ... (CADDR FORM))` | `(CSET (QUOTE A) B)` |

**Qué establece:**

- El expansor **no evalúa** `A` ni `B`; construye una forma con ellos.
- `(LIST (QUOTE QUOTE) (CADR FORM))` produce `(QUOTE A)`: el símbolo `A` queda como dato.
- `(LIST (QUOTE CSET) ... (CADDR FORM))` produce la llamada `(CSET (QUOTE A) B)`.
- No hace falta `*EXPAND` porque `CSETQ` tiene aridad fija: siempre dos argumentos. `*EXPAND` es para aridad indefinida.

**Continuidad histórica:** este es el mismo ejemplo que usa Hart en la ficha 01 (§3.3). Hart lo escribe en notación M-expression; Weissman lo escribe con `MACRO` y `DEFINE`. El patrón —`FORM`, `CADR`, `CADDR`, `LIST`, `QUOTE`— es el mismo. Eso permite al tutor mostrar que el mecanismo no cambió de naturaleza entre 1963 y 1967, solo se documentó y se integró en el compilador.

**Relación con `CSET` (p. 118):**

> “CSETQ is like CSET except that it quotes its first argument, e.g., (CSETQ PI 3.14159)”

> «CSETQ es como CSET, salvo que cita su primer argumento; por ejemplo, (CSETQ PI 3.14159).»

La macro `CSETQ` hace en tiempo de expansión el trabajo de citar el primer argumento, y deja una llamada a `CSET` que ya recibe `(QUOTE A)`. Esa es la razón de ser del ejemplo: la macro **prepara** la forma para que la función binaria `CSET` la ejecute después.

---

### 3.7. Property lists: contexto de datos, no el registro del `Primer`

El capítulo 19 empieza con estructuras de listas y property lists **antes** de llegar a las macros. Es importante no mezclar los dos niveles.

**CITA (p. 150):**

> “The property list is structured as a list of alternating indicators and properties; e.g., (SEX F PARENTS (CLARK MARCIA) AGE 6). Indicators and properties are general S-expressions.”

**TRADUCCIÓN:**

> «La property list está estructurada como una lista de indicadores y propiedades alternados; por ejemplo, (SEX F PARENTS (CLARK MARCIA) AGE 6). Los indicadores y las propiedades son S-expressions generales.»

**CITA (p. 150), `GET`:**

> “GET is a function that searches the list X for an indicator EQUAL to Y. If such an indicator is found, its property—the next list element (i.e., the CAR of the rest of the list)—is returned as the value of GET. Otherwise, the value of GET is NIL.”

**TRADUCCIÓN:**

> «GET es una función que busca en la lista X un indicador EQUAL a Y. Si encuentra ese indicador, devuelve como valor de GET su propiedad —el siguiente elemento de la lista, es decir, el CAR del resto de la lista—. En caso contrario, el valor de GET es NIL.»

**CITA (p. 150), `PUT`:**

> “This function puts on the property list of the literal atom X the indicator Y followed by the property Z. Any previous property of Y is replaced by Z. The value of PUT is Y.”

**TRADUCCIÓN:**

> «Esta función pone en la property list del átomo literal X el indicador Y seguido de la propiedad Z. Cualquier propiedad anterior de Y se reemplaza por Z. El valor de PUT es Y.»

**CITA (p. 151), `PROP`:**

> “The function PROP searches the list X for an indicator EQUAL to Y. If such an indicator is found, the value of PROP is the rest of the list beginning immediately after that indicator. Otherwise, the value is FN (), where FN is a function of no arguments.”

**TRADUCCIÓN:**

> «La función PROP busca en la lista X un indicador EQUAL a Y. Si encuentra ese indicador, el valor de PROP es el resto de la lista que empieza inmediatamente después de ese indicador. En caso contrario, el valor es FN (), donde FN es una función sin argumentos.»

**CITA (p. 151), `REMPROP`:**

> “This function removes all occurrences of the indicator Y and its property from the property list X. The value of REMPROP is NIL.”

**TRADUCCIÓN:**

> «Esta función elimina todas las apariciones del indicador Y y su propiedad de la property list X. El valor de REMPROP es NIL.»

**Advertencia para el tutor:** en el *Primer*, estas funciones pertenecen al capítulo de **estructuras de datos**. El `MACRO` se presenta después, en 19.6–19.8, como una **pseudo-función** con sintaxis tipo `DEFINE`. El *Primer* **no dice** que `MACRO` se registre en la property list del símbolo. Ese registro es el mecanismo de Hart (`macro[1] = deflist[1;MACRO]`, ficha 01 §3.4). Se puede usar una property list o una alist en la reconstrucción, pero no se debe atribuir al *Primer* la frase «la macro vive en la p-list».

---

### 3.8. `GENSYM`: disponible en la época, pero ausente de los ejemplos de macros del *Primer*

**CITA (p. 124):**

> “GENSYM has no arguments. Its value is a new, distinct, and freshly created literal atom with a print name (on most systems) of the form G00001, G00002, ..., G99999. This function is useful in debugging and general LISP programming for creating a literal atom when one is needed; each one is guaranteed to be unique.”

**TRADUCCIÓN:**

> «GENSYM no tiene argumentos. Su valor es un átomo literal nuevo, distinto y recién creado, con un nombre imprimible (en la mayoría de los sistemas) de la forma G00001, G00002, ..., G99999. Esta función es útil en depuración y en programación LISP general para crear un átomo literal cuando se necesita uno; se garantiza que cada uno es único.»

**Qué establece y qué no:**

- `GENSYM` existe en LISP 1.5 y el *Primer* lo documenta.
- Los ejemplos de macros del *Primer* (`PLUS`, `CSETQ`, y los ejercicios 11–16) **no** usan `GENSYM`.
- Hart sí lo usa dentro de `select` (ficha 01 §3.5).
- Por tanto, el tutor puede decir: «`GENSYM` está en el kit de la época y Hart lo usa; el *Primer* no lo usa en sus macros». No debe decir: «el *Primer* enseña a usar `GENSYM` en macros», porque no lo hace.

---

## 4. Derivaciones y reconstrucción

### 4.1. `CSETQ` paso a paso

```text
Entrada:             (CSETQ A B)
FORM:                (CSETQ A B)
(CADR FORM):         A
(CADDR FORM):        B
(QUOTE A):           (QUOTE A)
Salida:              (CSET (QUOTE A) B)
```

**Lectura:** la macro no ejecuta `CSET`; construye la forma `(CSET (QUOTE A) B)` para que el compilador la compile en lugar de `(CSETQ A B)`. El `QUOTE` interno es esencial: sin él, `A` se evaluaría y se perdería el nombre del átomo que se quiere asignar.

### 4.2. `PLUS` paso a paso

```text
Entrada:             (PLUS X1 X2 X3 X4)
Primer *EXPAND:      (*PLUS X1 (PLUS X2 X3 X4))
Segundo *EXPAND:     (*PLUS X1 (*PLUS X2 (PLUS X3 X4)))
Tercer *EXPAND:      (*PLUS X1 (*PLUS X2 (*PLUS X3 X4)))
```

**Lectura:** cada llamada a `*EXPAND` consume **un** argumento de la izquierda y deja el resto como una nueva llamada a `PLUS`. Cuando queda un solo argumento, el caso base `(NULL (CDDR FORM))` devuelve `(CADR FORM)` y la expansión termina. El compilador es quien repite; la macro no se llama a sí misma.

### 4.3. Del ejemplo al contrato del curso

Contrato: `(mi-suma a b)` → `(+ a b)`.

**Opción A — `CONS` y `CDR` (la más corta para aridad fija):**

```lisp
(cons '+ (cdr forma))
```

Resultado verificado: `(+ A B)`.

**Opción B — `LIST`, `CADR` y `CADDR` (la más legible para dos argumentos):**

```lisp
(list '+ (cadr forma) (caddr forma))
```

Resultado verificado: `(+ A B)`.

**Opción C — `*EXPAND` (la del *Primer*, para aridad indefinida):**

```lisp
(*expand forma '+)
```

Primera llamada: `(+ A (MI-SUMA B))`. Segunda llamada sobre `(MI-SUMA B)`: `B`. Resultado completo: `(+ A B)`.

**Cuándo usar cada una:**

- Si la macro siempre tiene dos argumentos, la opción A o B es suficiente y usa menos piezas.
- Si la macro debe aceptar cualquier número de argumentos, la opción C es la que documenta el *Primer*.
- La opción C no es “más avanzada” en el sentido moderno: es una función de la época que construye listas con `CONS`. No usa backquote ni `DEFMACRO`.

**Comparación con Hart:** Hart no usa `*EXPAND` en su ejemplo `CSETQ` porque `CSETQ` tiene aridad fija. Weissman usa `*EXPAND` en `PLUS` porque `PLUS` tiene aridad indefinida. La elección depende de la aridad, no de la época.

### 4.4. Reconstrucción ejecutable en SBCL (no es una cita)

```lisp
;; *EXPAND tal como aparece en la p. 154, traducido a DEFUN para SBCL.
;; DEFUN es andamiaje moderno; el cuerpo usa solo funciones del kit.
(defun *expand (form fn)
  (cond ((null (cddr form)) (cadr form))
        (t (cons fn
                 (cons (cadr form)
                       (cons (cons (car form) (cddr form)) nil))))))

;; El expansor de PLUS es la lambda de la p. 153, con nombre para poder llamarlo.
(defun expandir-plus (forma)
  (*expand forma '*plus))

;; El expansor de CSETQ es la lambda de la p. 156, con nombre para poder llamarlo.
(defun expandir-csetq (forma)
  (list 'cset
        (list 'quote (cadr forma))
        (caddr forma)))
```

**Salidas verificadas en SBCL:**

```text
(expandir-plus '(plus x1 x2 x3 x4))  =>  (*PLUS X1 (PLUS X2 X3 X4))
(*expand '(plus x2 x3 x4) '*plus)    =>  (*PLUS X2 (PLUS X3 X4))
(*expand '(plus x3 x4) '*plus)       =>  (*PLUS X3 (PLUS X4))
(*expand '(plus x4) '*plus)          =>  X4
(expandir-csetq '(csetq a b))        =>  (CSET 'A B)
(cons '+ '(a b))                     =>  (+ A B)
(list '+ 'a 'b)                      =>  (+ A B)
(*expand '(mi-suma a b) '+)          =>  (+ A (MI-SUMA B))
(*expand '(mi-suma b) '+)            =>  B
```

**Nota de impresión:** SBCL imprime `(QUOTE A)` como `'A`. La estructura es la misma: `(CSET 'A B)` y `(CSET (QUOTE A) B)` son la misma lista. El tutor debe advertirlo para que el estudiante no confunda la abreviatura del impresor con una forma distinta.

**Qué es andamiaje y qué es histórico:**

- `DEFUN`: andamiaje moderno para dar nombre a los expansores y poder probarlos.
- `DEFINE`: la pseudo-función histórica que usaría el *Primer* para definir `*EXPAND`.
- `COND`, `NULL`, `CDDR`, `CADR`, `CONS`, `CAR`, `LIST`, `QUOTE`: kit histórico.
- `*EXPAND`: función del sistema del *Primer*, reconstruida aquí con funciones del kit.
- El despacho “nombre → expansor” no lo imprime el *Primer* en 19.7; es la parte que el arnés moderno añade para simular el reconocimiento del compilador.

---

## 5. Lo que el tutor debe enseñar con esta ficha

### Etapa 5 del prompt: el `MACRO` del *Primer*

1. **`MACRO` es una pseudo-función de definición.** Se escribe como `DEFINE`, con una lista de definiciones; no se llama como `CAR` ni `CONS`.
2. **La función macro recibe la forma completa.** En `(PLUS X1 X2 X3 X4)`, el argumento `L` es toda la forma. En `(CSETQ A B)`, el argumento `FORM` es toda la forma.
3. **Se ejecuta antes de compilar la lambda.** No es una función de tiempo de ejecución; su efecto es reescribir la lambda antes de compilarla.
4. **Sustituye todas las apariciones.** La forma expandida reemplaza a la forma macro en la lambda.
5. **`*EXPAND` expande un nivel.** El compilador repite la operación mientras encuentre la macro. La macro no se llama a sí misma.
6. **Cuatro piezas:** `*EXPAND`, una función binaria, la definición `MACRO` y el reconocimiento del compilador.
7. **Dos reglas:** definir antes de usar; no recursiva. Y una regla adicional: una macro puede usar otra macro ya definida.
8. **`CSETQ` es el ejemplo de aridad fija.** Usa `LIST`, `QUOTE`, `CADR`, `CADDR`; no necesita `*EXPAND`.
9. **`PLUS` es el ejemplo de aridad indefinida.** Usa `*EXPAND`; el compilador repite.
10. **Las property lists son contexto de datos, no el registro del *Primer*.** Si el curso usa una p-list o una alist para registrar macros, es una decisión de reconstrucción; Hart sí usa la p-list, Weissman no la menciona en 19.7.
11. **`GENSYM` está en el kit, pero no en los ejemplos de macros del *Primer*.** Se puede usar cuando haga falta un nombre fresco; no se debe presentar como parte del ejemplo `CSETQ`/`PLUS`.

### Presupuesto de funciones (la “limitación” del curso)

El *Primer* reduce el mecanismo a cuatro piezas. Para el curso, eso se traduce en este presupuesto:

| Necesidad | Función o pieza permitida | Prohibido |
|---|---|---|
| Recibir la forma completa | `LAMBDA` de un argumento | `&body`, `&rest`, destructuring |
| Extraer piezas | `CAR`, `CDR`, `CADR`, `CADDR`, `CDDR` | `FIRST`, `SECOND`, `NTH`, `DESTRUCTURING-BIND` |
| Construir la forma | `CONS`, `LIST`, `APPEND`, `QUOTE` | backquote, coma, coma-arroba |
| Decidir el caso base | `COND`, `NULL`, `ATOM`, `EQ` | `IF`, `WHEN`, `UNLESS`, `AND`, `OR` |
| Expandir un nivel | `*EXPAND` reconstruida con el kit | `MACROEXPAND`, `MACROEXPAND-1` |
| Registrar/definir | `DEFINE` (histórico) o tabla de despacho (arnés) | `DEFMACRO`, `MACRO-FUNCTION` |
| Nombres frescos | `(GENSYM)` sin argumentos, como en el *Primer* | variantes modernas con prefijo o paquete |

**Regla de oro:** si una solución necesita una función que no está en la tabla de la izquierda, el tutor debe detenerse y buscar una alternativa con el kit. No debe “resolver” el ejercicio con una función moderna y luego llamarlo estilo 1963.

### Ejercicios del *Primer* que sirven de escalera

| Ejercicio | Página | Qué enseña |
|---|---|---|
| 11. `PROD` | p. 159; solución p. 206 | Usar `*EXPAND` con `*TIMES`; mismo patrón que `PLUS`. |
| 12. `MAXIMUM` y `MINIMUM` | p. 159; solución p. 206 | Repetir el patrón con `*MAX` y `*MIN`. |
| 13. `FLAMBDA` | p. 159; solución p. 206 | Construir con `LIST` y `CONS` sin `*EXPAND`. |
| 14. `LIST1` y `LIST2` | p. 159; solución pp. 206–207 | Una macro puede usar otra macro; el orden importa. |
| 15. `PRINTQ` | p. 160; solución pp. 207–208 | `LIST` + `QUOTE` y una función auxiliar `PRINTQ1`. |
| 16. `PROGN` | p. 160; solución p. 208 | `*EXPAND` con `PROG2`; generalizar una función binaria. |

**Uso didáctico:** no es necesario resolver los seis. El 11 y el 13 son los más útiles para el contrato del curso: el 11 muestra `*EXPAND`; el 13 muestra la construcción directa con `LIST`/`CONS`.

### Secuencia de preguntas

- ¿Qué recibe la función macro: la forma completa o los argumentos ya evaluados?
- ¿Cuándo se ejecuta: antes de compilar la lambda o al llamar a la función?
- ¿Qué hace exactamente `*EXPAND` en una llamada?
- ¿Por qué el compilador tiene que llamarlo varias veces?
- ¿Por qué `CSETQ` no necesita `*EXPAND` y `PLUS` sí?
- ¿Cuáles son las cuatro piezas del sistema?
- ¿Por qué una macro no puede ser recursiva?
- ¿Por qué debe definirse antes de usarse?
- ¿Puede una macro usar otra macro? ¿En qué orden?
- ¿Dónde vive la macro en Hart y dónde la describe Weissman? ¿Son lo mismo?

---

## 6. Lo que el tutor NO debe inferir

- **No** atribuyas a Weissman backquote, coma, coma-arroba, `&body`, `&rest`, `&optional`, `&aux`, `DEFMACRO`, `MACRO-FUNCTION`, `MACROEXPAND` ni `DESTRUCTURING-BIND`. No aparecen en el *Primer*.
- **No** digas que el *Primer* registra las macros en la property list del símbolo. El *Primer* presenta `MACRO` como pseudo-función; la p-list es el tema de 19.4–19.5. El registro con `deflist[1;MACRO]` es de Hart.
- **No** digas que `MACRO` es una función ordinaria. Es una pseudo-función: se usa por su efecto, no por su valor.
- **No** digas que una macro puede ser recursiva. El *Primer* lo prohíbe explícitamente (p. 155).
- **No** digas que la macro se ejecuta en tiempo de ejecución. Se ejecuta antes de compilar la lambda que la contiene.
- **No** digas que `*EXPAND` recorre todo el árbol. Expande un nivel por llamada; el compilador repite.
- **No** digas que `*EXPAND` es una función moderna de expansión. Es una función de la época que construye listas con `CONS`.
- **No** digas que el *Primer* usa `GENSYM` en sus macros. Lo documenta como utilidad general (p. 124); Hart lo usa en `select`.
- **No** digas que el código del *Primer* se ejecuta tal cual en SBCL. `DEFINE` y `MACRO` no son Common Lisp; la traducción a `DEFUN` es una reconstrucción.
- **No** digas que el *Primer* inventó las macros. Hart las propuso en 1963; el *Primer* las documenta y las cita en su bibliografía.
- **No** confundas el `MACRO` del *Primer* con el `macro[1]` de Hart. Están emparentados, pero usan notaciones y niveles distintos: Hart registra un indicador en la p-list y modifica `define`; Weissman define una pseudo-función que el compilador reconoce.
- **No** conviertas `MACRO` en `DEFMACRO`. En esta serie, el mecanismo se llama «mi-defmacro» para evitar el anacronismo.

---

## 7. Guion breve de sesión (30–45 minutos)

1. **Recuperación de Hart (5 min):** el estudiante explica, sin mirar, qué recibe una macro, dónde vive el indicador y cuándo se expande.
2. **Lectura guiada (10 min):** leer las citas de 3.2 y 3.3; marcar las tres ideas: forma completa, antes de compilar, sustitución.
3. **`CSETQ` (10 min):** derivar `(CSETQ A B)` → `(CSET (QUOTE A) B)` con la tabla de 3.6. Preguntar por qué el `QUOTE` interno es necesario.
4. **`PLUS` y `*EXPAND` (10 min):** trazar una llamada de `*EXPAND`; predecir la siguiente; comprobar que el caso base devuelve el último argumento.
5. **Contrato del curso (5 min):** implementar `(mi-suma a b)` → `(+ a b)` con `CONS`/`CDR`; luego con `*EXPAND`; comparar.
6. **Reglas y cierre (5 min):** definir antes de usar, no recursiva, macros que usan macros; una regla para la bitácora.

---

## 8. Preguntas de recuperación

1. ¿Qué sintaxis tiene `MACRO` según el *Primer*?
2. ¿Qué recibe la función macro: la forma completa o los argumentos evaluados?
3. ¿En qué momento se ejecuta la macro?
4. ¿Qué significa «expansión de macro» en la p. 153?
5. ¿Qué hace `*EXPAND` en una sola llamada?
6. ¿Por qué el compilador tiene que llamar a `*EXPAND` varias veces?
7. ¿Por qué `CSETQ` no usa `*EXPAND`?
8. ¿Cuáles son las cuatro piezas del sistema de macros?
9. ¿Por qué una macro no puede ser recursiva?
10. ¿Por qué debe definirse antes de usarse?
11. ¿Puede una macro usar otra macro? ¿Qué implica para el orden de definición?
12. ¿Dónde vive la macro en Hart y dónde la describe Weissman?
13. ¿Qué diferencia hay entre `(CSET 'A B)` y `(CSET (QUOTE A) B)`?
14. ¿Qué funciones del kit usa `*EXPAND`?
15. ¿Qué función de la época genera nombres únicos y en qué ejemplo de Hart aparece?

---

## 9. Checklist de alcance para la IA tutora

Antes de responder cualquier pregunta basada en esta ficha:

- [ ] He leído esta ficha completa.
- [ ] Toda afirmación histórica está respaldada por una **CITA** con página.
- [ ] No he introducido ninguna función moderna en la lógica de expansión.
- [ ] El contrato del ejercicio sigue siendo `(mi-suma a b)` → `(+ a b)`.
- [ ] La expansión usa solo funciones del kit cerrado (ficha 05).
- [ ] `DEFUN`, `LET`, `FORMAT` y `SETF` aparecen solo como andamiaje de pruebas.
- [ ] Distingo entre **cita**, **traducción** y **reconstrucción**.
- [ ] No atribuyo a Weissman el registro en property lists de Hart.
- [ ] No atribuyo a Weissman el uso de `GENSYM` en los ejemplos de macros.
- [ ] No presento `*EXPAND` como un expansor de árbol completo.
- [ ] Si el estudiante pide una función fuera del kit, me detengo y le ofrezco una alternativa de época.
- [ ] Si la fuente no responde, digo «la fuente no lo dice» y no invento.

---

## 10. Referencias de esta ficha

- Weissman, Clark. *LISP 1.5 Primer*. Belmont, California: Dickenson Publishing Company, 1967. Library of Congress catalog card number 67-20611. <https://softwarepreservation.computerhistory.org/LISP/book/Weismann_LISP1.5_Primer_1967.pdf>
- Hart, Timothy P. «MACRO Definitions for LISP». AIM-057, MIT Artificial Intelligence Laboratory, 1963. <https://bitsavers.org/pdf/mit/ai/aim/AIM-057.pdf>
- Índice de la familia LISP 1.5, Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/lisp15_family.html>
- McCarthy, John; Abrahams, Paul W.; Edwards, Daniel J.; Hart, Timothy P.; Levin, Michael I. *LISP 1.5 Programmer's Manual*. MIT Press, 1962 (2.ª ed., 1985). <https://softwarepreservation.computerhistory.org/LISP/book/LISP%201.5%20Programmers%20Manual.pdf>
- Moon, David A. *Maclisp Reference Manual*. MIT Project MAC, 1974. <https://softwarepreservation.computerhistory.org/LISP/MIT/Moon-MACLISP_Reference_Manual-Apr_08_1974.pdf>

---

## 11. Estado de la serie

| Ficha | Contenido | Estado |
|---|---|---|
| 01 | Hart, AIM-057 (1963): property list, `macro[1]`, `define`, `CSETQ`, `GENSYM` | completada |
| 02 | Weissman, *LISP 1.5 Primer* (1967): `MACRO`, `*EXPAND`, `CSETQ`, reglas | **esta ficha** |
| 03 | *LISP 1.5 Programmer's Manual*: `PAIRLIS`, `ASSOC`, `SUBLIS`, `EVAL`, `APPLY`, `GENSYM`, property lists | completada (ficha 03) |
| 04 | Moon, *MACLISP Reference Manual* (1974): propiedad funcional `macro`, forma completa, reevaluación, compilador | completada (ficha 04) |
| 05 | Kit cerrado de funciones y presupuesto histórico | pendiente |
| 06 | Protocolo de lectura y enseñanza para la IA tutora | pendiente |

La ficha 03 amplía el kit de sustitución (`PAIRLIS`, `ASSOC`, `SUBLIS`) y el `EVAL`/`APPLY` que el *Primer* da por conocidos. La ficha 06 será la que indique, en una sola página, **qué archivos debe leer la IA, en qué orden y con qué reglas**.
