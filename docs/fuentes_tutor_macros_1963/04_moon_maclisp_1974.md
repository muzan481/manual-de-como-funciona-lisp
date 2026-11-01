# Ficha 04 — David A. Moon, *MACLISP Reference Manual* (1974)

> **Serie:** fuentes para un tutor de macros al estilo de 1963.
> **Esta ficha:** el contraste posterior. Qué pasa cuando la macro deja de ser solo un expansor de definiciones y se convierte en una **propiedad funcional** de un dialecto con intérprete y compilador.
> **Objetivo:** que el tutor sepa qué añade MACLISP (propiedad funcional, forma completa, reevaluación del resultado, compilador, `(macros t)`) y qué **no** debe importar al ejercicio de 1963.

---

## 0. Cómo usar esta ficha

Para el estudiante:

- Léela después de las fichas 01, 02 y 03. No es un manual nuevo para el curso: es un **espejo posterior**.
- Sirve para ver qué partes del mecanismo de Hart sobrevivieron y qué partes son añadidos de MACLISP.
- No copies la sintaxis de MACLISP en el ejercicio. El contrato del curso sigue siendo `(mi-suma a b)` → `(+ a b)` con el kit de 1963.
- Distingue tres cosas: la macro de Hart (1963), la macro documentada por Weissman (1967) y la **propiedad funcional `macro`** de MACLISP (1974). Se parecen, pero no son la misma pieza.
- Si una frase de esta ficha te tienta a usar `DEFMACRO`, backquote o `MACROEXPAND`, vuelve a la ficha 01: el curso no los usa.

Para la IA tutora:

1. Lee esta ficha completa antes de explicar «qué cambió después de 1963».
2. Usa solo las citas marcadas **CITA** para afirmaciones históricas.
3. Trata **RECONSTRUCCIÓN** como ejemplo didáctico, nunca como texto de Moon.
4. No presentes MACLISP como el sistema de Hart. MACLISP es un dialecto posterior, descendiente de LISP 1.5, con cambios y añadidos (CITA p. 1).
5. No importes al ejercicio de 1963 la reevaluación del resultado, el compilador, `(macros t)` ni la sintaxis `(defun ... macro ...)`. Son rasgos de MACLISP, no del contrato original.
6. No conviertas `macro` en `DEFMACRO`. En el manual consultado no aparece `DEFMACRO`, `MACROEXPAND` ni `MACRO-FUNCTION`; las macros se definen con `DEFUN` o `DEFPROP` y el tipo `macro`.
7. Si una pregunta no se responde con esta ficha, di «la fuente no lo dice» y no inventes.

---

## 1. Registro bibliográfico

- **Autor:** David A. Moon.
- **Título:** *MACLISP Reference Manual*.
- **Institución:** Project MAC, Massachusetts Institute of Technology (M.I.T.), Cambridge, Massachusetts.
- **Revisión:** Revision 0, abril de 1974. Las páginas llevan la fecha `04/08/74`.
- **Extensión:** 284 páginas de PDF. El cuerpo impreso llega hasta la p. 269; después vienen los índices.
- **Secciones relevantes:**
  - Sección 1.1, p. 1: qué es MACLISP y su relación con LISP 1.5.
  - Sección 3.3, «Application», pp. 13–15: propiedades funcionales, diferencia entre `fexpr` y `macro`, límites de `apply`.
  - Sección 3.5, p. 21: `funcall` no acepta macros.
  - Sección 6.2, «The Property List», pp. 49–51: p-list plana, `get`, `getl`, `putprop`, `defprop`, `remprop`.
  - Sección 6.4, p. 53: `gensym`.
  - Sección 6.5, «Defining Atomic Symbols as Functions», pp. 54–55: `defun` con tipo `expr`, `fexpr` o `macro`; `defprop`/`putprop` como definidores.
  - Sección 14.1.4, pp. 181–182: qué hace el compilador con una macro.
  - Sección 14.2, p. 186: declaraciones `(macros t)` y `(macros nil)`.
  - Sección 14.4, p. 190: opción `-macros` del compilador.
  - Sección 16, p. 227: `grindef` imprime las propiedades `expr`, `fexpr` y `macro`.
  - Sección 16.5.3, p. 240: esquema `(defprop <atom> <definition> <expr, fexpr, or macro>)` en un ejemplo de impresión con formato.
- **Fuente consultada:** PDF en Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/MIT/Moon-MACLISP_Reference_Manual-Apr_08_1974.pdf>
- **Acceso:** 1 de noviembre de 2026.
- **Nota de transcripción:** el PDF tiene capa de texto, pero el OCR de la tipografía mecanográfica es irregular, sobre todo en subíndices, comillas y signos de puntuación. Las citas se cotejaron con las imágenes de las páginas. Se normalizó el espaciado y la indentación; no se corrigieron las palabras ni las definiciones del autor. Cuando una lectura es insegura, se advierte.

### Numeración de páginas

- Las citas «p. 13», «p. 181», etc. se refieren a la **página impresa** del manual.
- En el PDF descargado, la página impresa `N` corresponde a la página `N + 8`. Por ejemplo, la p. 13 es la página 21 del PDF; la p. 49 es la 57; la p. 181 es la 189; la p. 186 es la 194.
- La p. 1 es la página 9 del PDF. Las páginas preliminares usan numeración romana (`iii`, etc.) y no entran en esta correspondencia.

### Una advertencia de alcance

MACLISP **no** es LISP 1.5. Es un dialecto posterior, desarrollado en Project MAC, que desciende de LISP 1.5 pero cambió y añadió muchas cosas. Esta ficha lo usa para contrastar, no para reemplazar las fuentes de 1962–1967.

**CITA (p. 1):**

> “MACLISP is a dialect of LISP developed at M.I.T.'s Project MAC for use in artificial intelligence research and related fields. MACLISP is descended from the commonly-known LISP 1.5 dialect, however many features of the language have been changed or added.”

**TRADUCCIÓN:**

> «MACLISP es un dialecto de LISP desarrollado en Project MAC del M.I.T. para uso en investigación de inteligencia artificial y campos relacionados. MACLISP desciende del conocido dialecto LISP 1.5; sin embargo, muchas características del lenguaje han sido cambiadas o añadidas.»

**Qué establece:** el tutor puede hablar de continuidad histórica, pero no de identidad. Lo que vale para MACLISP no vale automáticamente para Hart ni para Weissman.

---

## 2. Por qué esta fuente es la cuarta piedra angular

Las fichas 01–03 describen un mecanismo que vive en la property list y se aplica **al definir** una función: la forma de la macro se reemplaza antes de compilar la lambda que la contiene. MACLISP conserva la property list y la forma completa, pero añade dos cosas decisivas:

1. **La macro es una propiedad funcional.** El evaluador la busca en la p-list del símbolo, en la misma lista donde busca `expr`, `fexpr`, `subr`, etc. (CITA p. 13).
2. **El resultado de la macro se reevalúa.** No se devuelve como valor final: se trata como una forma y se evalúa; su valor es el resultado de la aplicación (CITA p. 14).

Eso cambia el modelo mental. En 1963 la macro es un **expansor de definiciones**. En MACLISP es una **transformación que el evaluador o el compilador aplican en el momento de la aplicación o de la compilación**. La diferencia no es cosmética: explica por qué MACLISP puede tener macros en código interpretado, por qué el compilador las reconoce y por qué `apply`/`funcall` las rechazan.

| Idea | Dónde aparece | Consecuencia para el curso |
|---|---|---|
| MACLISP desciende de LISP 1.5, con cambios | CITA p. 1 | Es contraste, no continuación exacta. |
| La p-list se busca por propiedades funcionales | CITA p. 13 | `macro` compite con `expr`, `fexpr`, `subr`, etc. |
| La macro recibe la forma completa | CITA p. 14 | Igual que Hart; el primer lambda-variable no recibe el `cdr`. |
| El resultado se reevalúa | CITA p. 14 | Añadido de MACLISP; no está en el contrato de 1963. |
| `apply` y `funcall` no aceptan macros | CITA pp. 15 y 21 | La macro no es un valor de función ordinario. |
| `defun` acepta el tipo `macro` | CITA p. 54 | La sintaxis de definición cambia respecto de `macro[1]`. |
| El compilador aplica macros al procesar formas | CITA pp. 181–182 | La expansión es de tiempo de compilación en código compilado. |
| Por defecto las macros no se retienen en runtime | CITA p. 186 | `(macros t)` es una opción, no el comportamiento normal. |
| La p-list es plana y no tiene *flags* | CITA p. 49 | MACLISP elimina una comodidad de LISP 1.5. |
| `gensym` sigue existiendo | CITA p. 53 | Hay nombres frescos, pero el manual no los ata a las macros. |

### Lo que se conserva y lo que cambia

| Aspecto | Hart (1963) / Weissman (1967) | MACLISP (1974) |
|---|---|---|
| Dónde vive la macro | Property list, indicador `MACRO` | Property list, propiedad funcional `macro` |
| Qué recibe el expansor | La forma completa | La forma completa (primer lambda-variable) |
| Cuándo se aplica | Antes de compilar la lambda que la contiene | En la aplicación interpretada; en compilación, al procesar la forma |
| Qué pasa con el resultado | Reemplaza la forma original en las definiciones | Se trata como forma y se reevalúa; su valor es el resultado |
| Cómo se define | `macro[1] = deflist[1;MACRO]`; pseudo-función `MACRO` | `(defun ... macro ...)` o `(defprop ... macro)` |
| ¿Se puede llamar con `apply`/`funcall`? | No es una función ordinaria | No; `apply` y `funcall` la rechazan |
| ¿Se retiene en runtime? | No es una función de runtime | Solo si se pide con `(macros t)` o `-macros` |
| ¿Puede ser recursiva? | Weissman dice que no | El manual no lo dice; no se infiere |

**Lectura para el tutor:** las dos primeras filas son continuidad; las demás son diferencias. La continuidad permite conectar las fichas; las diferencias impiden mezclarlas.

---

## 3. Citas textuales y traducción

### 3.1. Aplicación y propiedades funcionales (p. 13)

**CITA (p. 13):**

> “The first step in application is an examination of the function. If it is atomic, then it is required to be an atomic symbol. The atomic symbol's property list is searched for one of the following properties, called ‘functional properties’:
>
> expr, fexpr, macro, subr, fsubr, lsubr, array, autoload”

**TRADUCCIÓN:**

> «El primer paso en la aplicación es un examen de la función. Si es atómica, entonces se requiere que sea un símbolo atómico. La property list del símbolo atómico se busca en una de las siguientes propiedades, llamadas “propiedades funcionales”:
>
> `expr`, `fexpr`, `macro`, `subr`, `fsubr`, `lsubr`, `array`, `autoload`»

**Qué establece:** el evaluador no busca primero una tabla global de funciones. Busca en la p-list del símbolo. `macro` es una entrada más de esa lista, no un objeto aparte.

**CITA (p. 54):**

> “Atomic symbols may be used as names for functions. This is done by putting the actual function (a subr-object or a lambda-expression) on the property list of the atomic symbol as a ‘functional property,’ i.e. under one of the indicators expr, fexpr, macro, subr, lsubr, or fsubr.”

**TRADUCCIÓN:**

> «Los símbolos atómicos pueden usarse como nombres de funciones. Esto se hace poniendo la función real (un objeto `subr` o una expresión lambda) en la property list del símbolo atómico como una “propiedad funcional”, es decir, bajo uno de los indicadores `expr`, `fexpr`, `macro`, `subr`, `lsubr` o `fsubr`.»

**Qué establece:** la definición de una macro es un valor almacenado bajo un indicador, exactamente como una función interpretada. La diferencia está en **cómo se aplica** ese valor, no en dónde se guarda.

#### Las propiedades funcionales, una por una

| Propiedad | Qué guarda | Cómo se aplica |
|---|---|---|
| `expr` | Una expresión lambda interpretada | Los argumentos se evalúan de izquierda a derecha, se ligan a las variables y se evalúa el cuerpo. |
| `fexpr` | Una expresión lambda interpretada | El primer lambda-variable recibe el `cdr` de la forma, es decir, la lista de argumentos **sin evaluar**. |
| `macro` | Una expresión lambda que “parece” un `fexpr` | El primer lambda-variable recibe la **forma completa**; el resultado se **reevalúa**. |
| `subr` | Una rutina de código máquina | Los argumentos se evalúan; número fijo de argumentos. |
| `fsubr` | Una rutina de código máquina | Recibe un argumento: el `cdr` de la forma; los argumentos no se evalúan. |
| `lsubr` | Una rutina de código máquina | Número variable de argumentos, dentro de límites. |
| `array` | Una referencia a un array | Los argumentos se evalúan y se usan como subíndices. |
| `autoload` | Una definición que se carga desde un archivo | Se carga y luego se usa. |

**Nota:** esta tabla resume la descripción de las pp. 13–14. No es una cita literal; es una lectura de apoyo. El manual distingue tres casos bajo `expr` (p. 14); la tabla resume el caso ordinario de una lambda con lista de variables. Esa simplificación no afecta a la comparación con `macro`.

---

### 3.2. Macro frente a `fexpr`: forma completa y reevaluación (pp. 13–14)

Para entender la macro de MACLISP hay que entender primero el `fexpr`, porque el manual dice que el valor de `macro` **debe parecerse** al de `fexpr`.

**CITA (p. 13):**

> “If a fexpr property is found, the value of the property must be a list whose car is the atom lambda and whose cadr is a list of one or two atomic symbols, referred to as lambda-variables. […] The first lambda-variable is bound to the cdr of the form being evaluated, i.e. to the list of unevaluated arguments.”

**TRADUCCIÓN:**

> «Si se encuentra una propiedad `fexpr`, el valor de la propiedad debe ser una lista cuyo `car` es el átomo `lambda` y cuyo `cadr` es una lista de uno o dos símbolos atómicos, llamados lambda-variables. […] El primer lambda-variable se liga al `cdr` de la forma que se está evaluando, es decir, a la lista de argumentos sin evaluar.»

**CITA (p. 14):**

> “If a macro property is found, its value must look like the value of a fexpr property. The difference between a macro and a fexpr is twofold. One, the first lambda-variable is bound to the whole form, instead of just the cdr of the form (the list of arguments). Two, the object returned by the macro is treated as a form and re-evaluated and its value becomes the result of the application.”

**TRADUCCIÓN:**

> «Si se encuentra una propiedad `macro`, su valor debe parecerse al valor de una propiedad `fexpr`. La diferencia entre una macro y un `fexpr` es doble. Primero, el primer lambda-variable se liga a la forma completa, en lugar de solo el `cdr` de la forma (la lista de argumentos). Segundo, el objeto devuelto por la macro se trata como una forma y se reevalúa, y su valor se convierte en el resultado de la aplicación.»

**Qué establece:** las dos diferencias, sin adornos:

1. **Qué entra:** el `fexpr` recibe `(a b)`; la macro recibe `(mi-suma a b)`.
2. **Qué sale:** el `fexpr` devuelve un valor; la macro devuelve una **forma**, y el evaluador la vuelve a evaluar.

| | `fexpr` | `macro` |
|---|---|---|
| Primer lambda-variable | `cdr` de la forma: `(a b)` | Forma completa: `(mi-suma a b)` |
| Argumentos | Sin evaluar | Sin evaluar |
| Resultado del cuerpo | Valor final | Forma que se reevalúa |
| Resultado de la aplicación | El valor del cuerpo | El valor de reevaluar la forma devuelta |
| Uso típico | Función especial | Transformación sintáctica |

**Consecuencia para el ejercicio:** si el expansor de `(mi-suma a b)` devuelve `(+ a b)`, MACLISP no se detiene ahí: evalúa `(+ a b)`. En el contrato de 1963, en cambio, la expansión reemplaza la forma en la definición y el compilador se encarga de compilarla. La diferencia parece pequeña, pero cambia el momento y el número de evaluaciones.

**Matiz sobre la lambda:** el manual dice que el valor de `macro` “debe parecerse” al de `fexpr`; por tanto, puede ser una lambda con uno o dos lambda-variables. En el `fexpr`, el segundo se liga a un “a-list pointer” (p. 13); el manual no repite esa frase para `macro`, aunque exige que su valor se parezca al de un `fexpr`. El ejemplo del curso no necesita ese segundo parámetro, y la reconstrucción tampoco lo modela. No lo presentes como si el manual lo exigiera.

**Matiz sobre `eval`:** el manual dice que el cuerpo de un `fexpr` puede evaluar los argumentos él mismo usando `eval` (p. 13). No repite esa frase para `macro`. No añadas esa posibilidad a la macro como si estuviera documentada; si el estudiante la pregunta, di que el manual describe el mecanismo para `fexpr` y que el valor de `macro` tiene la misma forma, pero no desarrolla ese punto.

---

### 3.3. Las macros no se llaman con `apply` ni con `funcall` (pp. 15 y 21)

Si la macro fuera una función ordinaria, podría pasarse a `apply` o a `funcall`. No lo es.

**CITA (p. 15):**

> “The main difference is that the function and the arguments are passed to apply separately. They are not consed up into a form. Consequently macros are not accepted by this version of application.”

**TRADUCCIÓN:**

> «La diferencia principal es que la función y los argumentos se pasan a `apply` por separado. No se unen en una forma. En consecuencia, las macros no son aceptadas por esta versión de la aplicación.»

**CITA (p. 21):**

> “If f is an expr, a lexpr, a subr, or an lsubr, the arguments are not re-evaluated. If f is a fexpr or an fsubr there must be exactly one argument. f may not be a macro.”

**TRADUCCIÓN:**

> «Si `f` es un `expr`, un `lexpr`, un `subr` o un `lsubr`, los argumentos no se reevalúan. Si `f` es un `fexpr` o un `fsubr`, debe haber exactamente un argumento. `f` no puede ser una macro.»

**Qué establece:** la macro no es un valor que se pase a otra función. Solo el evaluador (y el compilador) la reconocen en **posición de función**, cuando el `car` de la forma es un símbolo con propiedad `macro`. `apply` y `funcall` reciben la función y los argumentos ya separados; en ese punto la macro ya no tiene una forma completa que recibir.

**Consecuencia para el tutor:** no expliques la macro como “una función que se llama con `funcall`”. Explícala como “una propiedad que el evaluador consulta antes de aplicar”. Esa distinción es la que hace que `apply`/`funcall` la rechacen.

---

### 3.4. La property list en MACLISP (pp. 49–51)

La estructura de almacenamiento sigue siendo la p-list, pero MACLISP la describe con más detalle y elimina los *flags* de LISP 1.5.

**CITA (p. 49):**

> “A property-list is a list with an even number of elements. Each pair of elements constitutes a property: the first element is called the ‘indicator’ and the second is called the ‘value.’ The indicator is generally an atomic symbol which serves as the name of the property.”

**TRADUCCIÓN:**

> «Una property-list es una lista con un número par de elementos. Cada par de elementos constituye una propiedad: el primer elemento se llama “indicador” y el segundo se llama “valor”. El indicador es generalmente un símbolo atómico que sirve como nombre de la propiedad.»

**CITA (p. 49):**

> “Each atomic symbol has associated with it a property-list which is kept on its cdr.”

**TRADUCCIÓN:**

> «Cada símbolo atómico tiene asociada una property-list que se guarda en su `cdr`.»

**CITA (p. 49):**

> “The user familiar with LISP 1.5 will want to note that the property list ‘flags’ which are allowed on LISP 1.5 property lists do not exist in MACLISP.”

**TRADUCCIÓN:**

> «El usuario familiarizado con LISP 1.5 querrá notar que los “flags” de property list que se permiten en las property lists de LISP 1.5 no existen en MACLISP.»

**Qué establece:** la p-list es plana, de longitud par, con pares indicador/valor. No hay una lista aparte de *flags* como en LISP 1.5. Si el estudiante viene de la ficha 03, este es un cambio que debe registrar: la idea de “lista de propiedades” se conserva; la comodidad de los *flags* desaparece.

#### Las operaciones de p-list

**CITA (pp. 49–50):**

> “(get x y) gets x's y-property. x can be an atomic symbol or a disembodied property list. The value of x's y-property is returned, unless x has no y-property in which case nil is returned.”

**TRADUCCIÓN:**

> «`(get x y)` obtiene la propiedad `y` de `x`. `x` puede ser un símbolo atómico o una property list “desencarnada”. Se devuelve el valor de la propiedad `y` de `x`, a menos que `x` no tenga una propiedad `y`, en cuyo caso se devuelve `nil`.»

**CITA (p. 50):**

> “(putprop x y z) gives x a z-property of y and returns y. x may be an atomic symbol or a disembodied property list. After somebody does (putprop x y z), (get x z) will return y.”

**TRADUCCIÓN:**

> «`(putprop x y z)` le da a `x` una propiedad `z` de valor `y` y devuelve `y`. `x` puede ser un símbolo atómico o una property list “desencarnada”. Después de que alguien hace `(putprop x y z)`, `(get x z)` devolverá `y`.»

**CITA (p. 50):**

> “(defprop x y z) gives x a z-property of y. The arguments are not evaluated.”

**TRADUCCIÓN:**

> «`(defprop x y z)` le da a `x` una propiedad `z` de valor `y`. Los argumentos no se evalúan.»

**CITA (p. 51):**

> “(remprop x y) removes x's y-property, by splicing it out of x's property list. The value is t if x had a y-property, nil if it didn't.”

**TRADUCCIÓN:**

> «`(remprop x y)` elimina la propiedad `y` de `x`, empalmándola fuera de la property list de `x`. El valor es `t` si `x` tenía una propiedad `y`, `nil` si no la tenía.»

#### Tabla de operaciones

| Operación | Firma | ¿Evalúa sus argumentos? | Devuelve |
|---|---|---|---|
| `get` | `(get x y)` | Sí (`SUBR` de 2 argumentos) | El valor de la propiedad `y`, o `nil`. |
| `putprop` | `(putprop x y z)` | Sí (`SUBR` de 3 argumentos) | `y`. |
| `defprop` | `(defprop x y z)` | **No** (`FSUBR`) | El manual no documenta el valor de retorno. |
| `remprop` | `(remprop x y)` | Sí (`SUBR` de 2 argumentos) | `t` si existía, `nil` si no. |

**Lectura:** `defprop` es la operación cómoda para instalar una definición sin evaluarla. Por eso sirve para guardar una lambda bajo `macro`:

```lisp
(defprop mi-suma
         (lambda (form) (cons (quote +) (cdr form)))
         macro)
```

Los argumentos no se evalúan: el segundo argumento se guarda tal cual, como lista. `putprop`, en cambio, evalúa sus argumentos; para guardar una lista habría que citarla:

```lisp
(putprop 'mi-suma
         '(lambda (form) (cons (quote +) (cdr form)))
         'macro)
```

**Nota:** el manual no imprime una definición concreta de una macro con `defprop`; imprime `(defprop foo bar often-with)` (p. 50) para mostrar el orden de los argumentos. En el capítulo de impresión con formato usa el esquema `(defprop <atom> <definition> <expr, fexpr, or macro>)` (p. 240), donde `macro` aparece como uno de los tipos posibles; es un esquema, no una macro concreta. El uso con `macro` es una **RECONSTRUCCIÓN** basada en la sintaxis documentada, no una cita.

---

### 3.5. Definir una macro: `DEFUN` con tipo `macro` o `DEFPROP` (pp. 54–55)

El manual consultado no documenta una pseudo-función `MACRO` como la de Weissman. Documenta dos caminos: `defun` con un tipo y `defprop`/`putprop` con el indicador `macro`.

**CITA (p. 54):**

> “defun is used for defining functions. The general form is:
>
> (defun <name> <type>
>     ( <lambda-variable> ... )
>     <body> ... )
>
> however, <name> and <type> may be interchanged. <type>, which is optional, may be expr, fexpr, or macro. If it is omitted, expr is assumed.”

**TRADUCCIÓN:**

> «`defun` se usa para definir funciones. La forma general es:
>
> `(defun <nombre> <tipo> ( <lambda-variable> ... ) <cuerpo> ... )`
>
> sin embargo, `<nombre>` y `<tipo>` pueden intercambiarse. `<tipo>`, que es opcional, puede ser `expr`, `fexpr` o `macro`. Si se omite, se asume `expr`.»

**Ejemplos impresos (p. 54):**

```lisp
(defun addone (x) (1+ x))          ;defines an expr

(defun quot fexpr (x) (car x))     ;defines a fexpr

(defun fexpr quot (x) (car x))     ;is the same

(defun zzz expr x
  (foo (arg 1)(arg 2)))            ;this is how you define a lexpr.
```

**Lectura:** el manual muestra el tipo `fexpr` con un ejemplo, pero no imprime un ejemplo con `macro`. La sintaxis, sin embargo, es explícita: `<type>` puede ser `macro`. Por eso la forma siguiente es una **RECONSTRUCCIÓN** válida según la sintaxis documentada:

```lisp
(defun mi-suma macro (form)
  (cons (quote +) (cdr form)))
```

El nombre `mi-suma` y el cuerpo son nuestros; el tipo `macro` y la posición del nombre son del manual.

**CITA (p. 55):**

> “Note: the functions defprop and putprop may also be used for defining functions.”

**TRADUCCIÓN:**

> «Nota: las funciones `defprop` y `putprop` también pueden usarse para definir funciones.»

**Qué establece:** no hay una única forma de instalar una macro. `defun` con tipo `macro` es la forma “de definición de función”; `defprop` es la forma “de propiedad”. Ambas terminan poniendo una lambda bajo el indicador `macro` en la p-list del símbolo.

#### Las tres formas, lado a lado

| Forma | Cómo se escribe | Qué evalúa | Cuándo conviene |
|---|---|---|---|
| `defun` con tipo | `(defun mi-suma macro (form) ...)` | El cuerpo se guarda como definición; la lambda se instala. | Cuando quieres la sintaxis de definición de función. |
| `defprop` | `(defprop mi-suma (lambda (form) ...) macro)` | No evalúa los argumentos; guarda la lambda tal cual. | Cuando quieres instalar la propiedad sin citar la lambda. |
| `putprop` | `(putprop 'mi-suma '(lambda (form) ...) 'macro)` | Evalúa los argumentos; hay que citar la lambda y el indicador. | Cuando ya tienes la lambda en una variable o quieres calcularla. |

**Advertencia de nomenclatura:** `(defun ... macro ...)` **no** es `DEFMACRO`. Es una extensión del `defun` de MACLISP para elegir el tipo de propiedad funcional. El manual consultado no documenta `DEFMACRO`, `MACROEXPAND` ni `MACRO-FUNCTION`; si el estudiante los menciona, son vocabulario posterior o de otro sistema, no de esta fuente.

**Observación de texto:** en el PDF consultado no aparecen las palabras `DEFMACRO`, `MACROEXPAND` ni `MACRO-FUNCTION`. Tampoco aparecen `&BODY`, `&REST`, `&OPTIONAL`, `&AUX`, `&KEY` ni `DESTRUCTURING-BIND`. Esto es una observación sobre **este manual**, no una prueba de que MACLISP careciera de esas cosas en todas sus versiones. No la uses para afirmar más de lo que dice.

---

### 3.6. El compilador y el tiempo de compilación (pp. 181–182, 186, 190)

La macro de MACLISP no solo vive en el intérprete. El compilador también la reconoce, y el manual dedica varias páginas a explicar qué hace.

**CITA (p. 181):**

> “A function definition is a form whose car is one of the atoms defun, defprop. When the compiler encounters a function definition if it defines a macro the macro is defined for use at compile time.”

**TRADUCCIÓN:**

> «Una definición de función es una forma cuyo `car` es uno de los átomos `defun`, `defprop`. Cuando el compilador encuentra una definición de función, si define una macro, la macro se define para uso en tiempo de compilación.»

**CITA (p. 182):**

> “Note that if a form is read from the input file and its car has been defined as a macro, the compiler will apply the macro and then process the result as if it had been read from the input file.”

**TRADUCCIÓN:**

> «Nota que si se lee una forma del archivo de entrada y su `car` ha sido definido como una macro, el compilador aplicará la macro y luego procesará el resultado como si se hubiera leído del archivo de entrada.»

**Qué establece:** el compilador no se limita a copiar la llamada a la macro. La reconoce, la aplica y **vuelve a procesar el resultado**. Esa es la versión MACLISP de la expansión de tiempo de compilación que Weissman describe con `*EXPAND`, pero el manual de 1974 no formula la regla de “un nivel por llamada” ni la de “no recursiva”. No le atribuyas esas reglas a Moon.

**CITA (p. 186):**

> “(macros t)
> Causes macros to be defined at run time as well as at compile time.
>
> (macros nil)
> Causes macros to be defined only at compile time. This is the default case.”

**TRADUCCIÓN:**

> «`(macros t)`
> Hace que las macros se definan en tiempo de ejecución además de en tiempo de compilación.
>
> `(macros nil)`
> Hace que las macros se definan solo en tiempo de compilación. Este es el caso por defecto.»

**CITA (p. 190):**

> “-macros -mc
> Equivalent to the (macros t) declaration: Causes macro definitions to be retained at run time.”

**TRADUCCIÓN:**

> «`-macros` `-mc`
> Equivalente a la declaración `(macros t)`: hace que las definiciones de macros se retengan en tiempo de ejecución.»

**Qué establece:** por defecto, una macro compilada **no** queda definida en el entorno de ejecución; solo se usa mientras se compila. Si el programa necesita la macro en runtime (por ejemplo, para código interpretado que se evalúa después), hay que pedir `(macros t)` o usar `-macros`. Es una decisión del compilador, no una propiedad automática de la macro.

**Lectura conjunta de pp. 181–182 y 186:** el compilador lee las formas en orden. Si una forma usa una macro, la definición de esa macro tiene que haber sido procesada antes; si está después, el `car` aún no está definido como macro y no se aplica. El manual no formula esta regla como una regla general, pero se sigue de la lectura sucesiva que describe. No la presentes como una cita textual.

**Contraste con Weissman:** el *Primer* dice explícitamente que las macros deben definirse antes de usarse y que no pueden ser recursivas (ficha 02). Moon describe la lectura sucesiva y el procesamiento del resultado, pero no repite esas dos reglas. El tutor debe decir qué dice cada fuente, no fusionarlas.

---

### 3.7. Herramientas que reconocen la propiedad `macro` (pp. 53 y 227)

**CITA (p. 53):**

> “gensym creates and returns a new atomic symbol, which is not interned on the obarray (is not recognized by read). The atomic symbol's pname is of the form <prefix><number>, e.g. g0001. The <number> is incremented each time.”

**TRADUCCIÓN:**

> «`gensym` crea y devuelve un símbolo atómico nuevo, que no está internado en la obarray (no es reconocido por `read`). El `pname` del símbolo atómico tiene la forma `<prefijo><número>`, por ejemplo `g0001`. El `<número>` se incrementa cada vez.»

**Qué establece:** MACLISP conserva un generador de nombres frescos. **No** establece que `gensym` sea una herramienta específica para macros; el manual lo documenta como función general. No le atribuyas una conexión que la fuente no hace.

**CITA (p. 227):**

> “grindef is used to grind the properties of an atom; usually the functional properties expr, fexpr, and macro, and the atom's value.”

**TRADUCCIÓN:**

> «`grindef` se usa para imprimir con formato las propiedades de un átomo; normalmente las propiedades funcionales `expr`, `fexpr` y `macro`, y el valor del átomo.»

**Qué establece:** las herramientas del sistema tratan `macro` como una propiedad funcional más, junto a `expr` y `fexpr`. Es otra evidencia de que la macro vive en la misma estructura, no en un registro aparte.

---

## 4. Reconstrucción en SBCL (no es una cita)

Esta reconstrucción **modela** la semántica de las pp. 13–14: una propiedad `macro` en la p-list, un expansor que recibe la forma completa y un evaluador que reevalúa el resultado. No es una implementación de MACLISP y no usa `DEFMACRO`.

### 4.1. El código

```lisp
;;;; Reconstruccion pedagogica de la semantica de macro de MACLISP (1974).
;;;; Andamiaje moderno: DEFUN, SETF, GET, FORMAT.
;;;; Logica de expansion: COND, ATOM, EQ, NULL, CAR, CDR, CONS, QUOTE, ASSOC, PAIRLIS.

(defun mi-assoc (x a)
  (cond ((null a) nil)
        ((equal (car (car a)) x) (car a))
        (t (mi-assoc x (cdr a)))))

(defun mi-pairlis (x y a)
  (cond ((null x) a)
        (t (cons (cons (car x) (car y))
                 (mi-pairlis (cdr x) (cdr y) a)))))

(defun mi-evlis (m a)
  (cond ((null m) nil)
        (t (cons (mi-eval (car m) a)
                 (mi-evlis (cdr m) a)))))

(defun mi-macro-p (x)
  (cond ((atom x) (get x 'macro))
        (t nil)))

;; El valor de la propiedad MACRO se aplica a la forma completa.
(defun mi-expand-macro (name form)
  (mi-apply (get name 'macro) (list form) nil))

(defun mi-eval (e a)
  (cond ((atom e) (cdr (mi-assoc e a)))
        ((eq (car e) 'quote) (cadr e))
        ((mi-macro-p (car e))
         (mi-eval (mi-expand-macro (car e) e) a))
        (t (mi-apply (car e) (mi-evlis (cdr e) a) a))))

(defun mi-apply (fn x a)
  (cond ((atom fn)
         (cond ((eq fn 'car) (car (car x)))
               ((eq fn 'cdr) (cdr (car x)))
               ((eq fn 'cadr) (cadr (car x)))
               ((eq fn 'cons) (cons (car x) (cadr x)))
               ((eq fn 'list) x)
               ((eq fn '+) (+ (car x) (cadr x)))
               (t nil)))
        ((eq (car fn) 'lambda)
         (mi-eval (caddr fn) (mi-pairlis (cadr fn) x a)))
        (t nil)))

;; Registro de la macro: el valor parece una lambda de FEXPR,
;; pero su primer parametro recibe la forma completa.
(setf (get 'mi-suma 'macro)
      '(lambda (form) (cons '+ (cdr form))))

(format t "~&PROP   : ~S~%" (get 'mi-suma 'macro))
(format t "EXPANDE: ~S~%" (mi-expand-macro 'mi-suma '(mi-suma a b)))
(format t "EVAL1  : ~S~%" (mi-eval '(mi-suma a b) '((a . 1) (b . 2))))

;; Una macro que devuelve una forma que hay que volver a evaluar.
(setf (get 'mi-doble 'macro)
      '(lambda (form) (list '+ (cadr form) (cadr form))))
(format t "EXPANDE: ~S~%" (mi-expand-macro 'mi-doble '(mi-doble x)))
(format t "EVAL2  : ~S~%" (mi-eval '(mi-doble x) '((x . 4))))

;; La forma completa llega entera al expansor.
(setf (get 'mi-ident 'macro)
      '(lambda (form) (list 'quote form)))
(format t "EVAL3  : ~S~%" (mi-eval '(mi-ident hola) nil))

;; Un fexpr solo recibiria el cdr (la lista de argumentos), no la forma completa.
(format t "CDR    : ~S~%" (cdr '(mi-suma a b)))
```

### 4.2. Salidas verificadas en SBCL

```text
PROP   : (LAMBDA (FORM) (CONS '+ (CDR FORM)))
EXPANDE: (+ A B)
EVAL1  : 3
EXPANDE: (+ X X)
EVAL2  : 8
EVAL3  : (MI-IDENT HOLA)
CDR    : (A B)
```

### 4.3. Qué muestra cada salida

| Salida | Qué prueba |
|---|---|
| `PROP` | La macro está guardada como una lambda bajo la propiedad `macro`. |
| `EXPANDE` de `mi-suma` | El expansor devuelve `(+ A B)`: construye una forma, no evalúa los argumentos. |
| `EVAL1` | El evaluador reevalúa `(+ A B)` con `A = 1` y `B = 2`; el resultado es `3`. |
| `EXPANDE` de `mi-doble` | El expansor devuelve `(+ X X)`. |
| `EVAL2` | La forma devuelta se reevalúa con `X = 4`; el resultado es `8`. |
| `EVAL3` | `mi-ident` devuelve la **forma completa** citada; al reevaluarla se obtiene `(MI-IDENT HOLA)`. Si hubiera recibido solo el `cdr`, se obtendría `(HOLA)`. |
| `CDR` | El `cdr` de la forma es `(A B)`: eso es lo que recibiría un `fexpr`, no una macro. |

### 4.4. Qué es andamiaje y qué es histórico

- **Andamiaje moderno de prueba:** `DEFUN`, `SETF`, `GET` de SBCL, `FORMAT`.
- **Kit histórico:** `COND`, `NULL`, `ATOM`, `EQ`, `EQUAL`, `CAR`, `CDR`, `CADR`, `CONS`, `LIST`, `QUOTE`, `ASSOC`, `PAIRLIS`.
- **Reconstrucción del evaluador:** `MI-ASSOC`, `MI-PAIRLIS`, `MI-EVLIS`, `MI-EVAL`, `MI-APPLY`.
- **Reconstrucción de la semántica de pp. 13–14:** `MI-MACRO-P` y `MI-EXPAND-MACRO`.
- **Macros de prueba:** `MI-SUMA`, `MI-DOBLE`, `MI-IDENT`.
- **Equivalente moderno de `DEFPROP`/`PUTPROP`:** `(setf (get 'mi-suma 'macro) ...)`. No es la forma histórica; es la forma de instalar la propiedad en SBCL.

### 4.5. Límites de la reconstrucción

- **Los números no se autoevalúan en nuestro evaluador simplificado.** `(mi-eval '(mi-suma 1 2) nil)` fallaría porque `1` y `2` se tratan como variables y no están en la a-list. Por eso las pruebas ligan `a` y `b` a números. En un Lisp completo los números se evalúan a sí mismos; esta simplificación no cambia la semántica de la macro, solo evita añadir el caso numérico al evaluador.
- **No modelamos el segundo lambda-variable** (el “a-list pointer” que el manual describe para `fexpr` en la p. 13). El ejemplo no lo necesita. El manual exige que el valor de `macro` se parezca al de `fexpr`, pero no desarrolla ese segundo parámetro para las macros; la reconstrucción no lo cubre.
- **No modelamos el compilador.** La reconstrucción muestra la semántica de aplicación interpretada (p. 14), no la de compilación (pp. 181–182). Para el compilador haría falta un segundo modelo, y no es necesario para el contraste.
- **No modelamos `defun ... macro` ni `defprop`.** Instalamos la propiedad con `setf`/`get` de SBCL. La forma histórica está en la sección 3.5; la reconstrucción se concentra en la aplicación.
- **No usamos `DEFMACRO`, `MACROEXPAND` ni backquote.** La expansión se construye con `CONS`, `LIST` y `QUOTE`, como en el kit del curso.

---

## 5. Lo que el tutor debe enseñar con esta ficha

### Lo que aporta a las etapas del curso

1. **MACLISP es posterior.** Desciende de LISP 1.5, pero cambió y añadió cosas (p. 1). No es el sistema de Hart.
2. **La p-list sigue siendo el almacén.** La macro vive bajo un indicador; en MACLISP ese indicador es una propiedad funcional (p. 13).
3. **La macro no es una función ordinaria.** `apply` y `funcall` la rechazan (pp. 15 y 21).
4. **La forma completa es la continuidad.** El primer lambda-variable recibe la forma entera, no el `cdr` (p. 14). Es la misma idea de Hart.
5. **La reevaluación es la diferencia.** El resultado se trata como forma y se evalúa; su valor es el resultado de la aplicación (p. 14). Esto no está en el contrato de 1963.
6. **El cuerpo construye datos.** La macro no evalúa los argumentos; construye una forma con `CONS`, `LIST` y `QUOTE`. La evaluación ocurre después.
7. **El compilador reconoce la macro.** La define para uso en tiempo de compilación y procesa el resultado como si se hubiera leído del archivo (pp. 181–182).
8. **La retención en runtime es opcional.** Por defecto, `(macros nil)`; para conservar las definiciones, `(macros t)` o `-macros` (pp. 186 y 190).
9. **La p-list es plana y sin *flags*.** MACLISP elimina los *flags* de LISP 1.5 (p. 49).
10. **El contraste evita anacronismos.** La macro de 1963 no tenía reevaluación, compilador con `(macros t)` ni sintaxis `defun ... macro`. No se las atribuyas.

### Presupuesto de funciones (la «limitación» del curso)

| Necesidad | Permitido | Prohibido |
|---|---|---|
| Guardar el expansor | Property list + `DEFLIST` (1963) | `DEFMACRO`, `MACRO-FUNCTION`, tabla hash global |
| Recuperar el expansor | `GET` | `MACROEXPAND`, `MACROEXPAND-1` |
| Construir la forma | `CONS`, `LIST`, `APPEND`, `QUOTE` | backquote, coma, coma-arroba |
| Decidir | `COND`, `NULL`, `ATOM`, `EQ`, `EQUAL` | `IF`, `WHEN`, `UNLESS`, `AND`, `OR` en la expansión |
| Nombres frescos | `(GENSYM)` sin argumentos | variantes modernas con prefijo o paquete |
| Probar / registrar | `DEFUN`, `LET`, `SETQ`, `FORMAT` | usarlos dentro de la lógica de expansión |
| Contrastar historia | `DEFUN ... macro`, `DEFPROP ... macro`, `(macros t)` | usarlos como herramientas del ejercicio |

**Regla de oro:** si una solución necesita una función que no está en la columna «Permitido», el tutor se detiene y busca una alternativa con el kit. No «resuelve» con una función moderna y luego la llama estilo 1963.

**Nota sobre MACLISP:** `(defun mi-suma macro ...)`, `(defprop ... macro)` y `(macros t)` son **evidencia histórica** para explicar qué cambió. No son herramientas del ejercicio. El ejercicio sigue usando el contrato de 1963: p-list + `DEFLIST`/`GET` + `CONS`/`LIST`/`QUOTE`.

**Nota sobre `AND`/`OR`:** el Manual de 1962 los documenta (p. 58), así que no son modernos. El curso los deja fuera de la lógica de expansión para mantener el estilo de Hart, que usa `COND`. Si el estudiante pregunta, hay que decir la verdad: existían, pero el kit elegido no los usa.

### Ejercicios de lectura

| Ejercicio | Fuente | Qué enseña |
|---|---|---|
| Explicar por qué `macro` está en la lista de propiedades funcionales | p. 13 | La macro vive en la p-list, junto a `expr` y `fexpr`. |
| Comparar lo que recibe un `fexpr` y lo que recibe una `macro` | pp. 13–14 | `cdr` frente a forma completa. |
| Explicar qué significa “el resultado se reevalúa” | p. 14 | La diferencia central con 1963. |
| Trazar `(mi-suma a b)` con la macro de la reconstrucción | §4 | Forma completa → `(+ a b)` → valor. |
| Explicar por qué `(apply ...)` no acepta una macro | p. 15 | La macro no es un valor de función ordinario. |
| Explicar por qué `(funcall ...)` no acepta una macro | p. 21 | La misma razón, desde el otro operador. |
| Escribir una macro con `defun ... macro` y otra con `defprop ... macro` | pp. 54–55 | Dos formas de instalar la misma propiedad. |
| Explicar qué hace el compilador con una forma cuya `car` es una macro | pp. 181–182 | Expansión de tiempo de compilación. |
| Explicar la diferencia entre `(macros t)` y `(macros nil)` | p. 186 | Retención en runtime. |
| Explicar por qué la p-list de MACLISP no tiene *flags* | p. 49 | Cambio respecto de LISP 1.5. |
| Identificar qué partes de la reconstrucción son de 1963 y cuáles son de MACLISP | §§3–4 | Separar continuidad de añadido. |

### Secuencia de preguntas

- ¿Qué es una propiedad funcional?
- ¿Qué propiedades funcionales menciona el manual?
- ¿Dónde busca el evaluador la definición de un símbolo atómico?
- ¿Qué recibe el primer lambda-variable de un `fexpr`?
- ¿Qué recibe el primer lambda-variable de una `macro`?
- ¿Qué hace el evaluador con el objeto que devuelve una macro?
- ¿Por qué `apply` no acepta macros?
- ¿Por qué `funcall` no acepta macros?
- ¿Cómo se define una macro con `defun`?
- ¿Cómo se define una macro con `defprop`?
- ¿Qué diferencia hay entre `defprop` y `putprop`?
- ¿Qué evalúa `defprop`? ¿Y `putprop`?
- ¿Qué hace el compilador cuando encuentra una forma cuya `car` es una macro?
- ¿Qué significa `(macros t)`? ¿Y `(macros nil)`?
- ¿Qué hace `-macros`?
- ¿Qué diferencia hay entre la p-list de LISP 1.5 y la de MACLISP?
- ¿Qué dice el manual sobre la recursión de macros?
- ¿Qué dice el manual sobre `gensym` y las macros?
- ¿Qué partes de esta ficha son continuidad con Hart y cuáles son añadidos de MACLISP?

---

## 6. Lo que el tutor NO debe inferir

- **No** digas que Hart tenía reevaluación del resultado. La reevaluación es de MACLISP (p. 14); Hart reemplaza la forma en las definiciones.
- **No** digas que Hart tenía un compilador con `(macros t)`. Es una opción de MACLISP (pp. 186 y 190).
- **No** digas que la macro de Hart se aplicaba en tiempo de ejecución como una función. Hart la aplica al definir; Weissman antes de compilar.
- **No** digas que `(defun ... macro ...)` es `DEFMACRO`. Es una extensión de `defun` de MACLISP; el manual consultado no documenta `DEFMACRO`.
- **No** digas que `DEFMACRO` existía en 1974 por el hecho de que MACLISP tuviera macros. La fuente consultada no lo documenta.
- **No** digas que las macros se pueden llamar con `apply` o `funcall`. El manual dice lo contrario (pp. 15 y 21).
- **No** digas que la macro evalúa sus argumentos. Recibe la forma completa sin evaluar; el cuerpo construye una forma.
- **No** digas que el resultado de la macro se devuelve directamente. Se trata como forma y se reevalúa (p. 14).
- **No** digas que un `fexpr` recibe la forma completa. Recibe el `cdr`, la lista de argumentos (p. 13).
- **No** digas que una macro recibe solo los argumentos. Recibe la forma completa (p. 14).
- **No** digas que `(macros t)` es el comportamiento por defecto. El manual dice que `(macros nil)` es el caso por defecto (p. 186).
- **No** digas que las macros de MACLISP son recursivas o no recursivas. El manual no lo dice; Weissman sí dice que no pueden serlo, pero es otra fuente.
- **No** digas que `gensym` está documentado como herramienta de macros. El manual lo documenta como función general (p. 53).
- **No** digas que la p-list de MACLISP tiene *flags*. El manual dice que no existen en MACLISP (p. 49).
- **No** digas que `defprop` evalúa sus argumentos. No los evalúa (p. 50).
- **No** digas que `putprop` no los evalúa. Los evalúa (p. 50).
- **No** digas que el manual de 1974 documenta backquote, `&rest`, `&optional`, `&body` o `destructuring-bind`. No aparecen en el texto consultado.
- **No** uses MACLISP como excusa para introducir `DEFMACRO`, `MACROEXPAND`, backquote o coma en el ejercicio. Esta ficha es contraste, no kit.
- **No** presentes la reconstrucción de SBCL como una implementación de MACLISP. Es un modelo didáctico de la semántica de aplicación.

---

## 7. Guion breve de sesión (30–45 minutos)

1. **Recuperación (5 min):** el estudiante explica, sin mirar, qué recibe la macro de Hart y cuándo se aplica. Si duda, vuelve a la ficha 01.
2. **Linaje (5 min):** leer la cita de p. 1. Preguntar qué significa “descendiente” y qué no significa. Aclarar que MACLISP no es LISP 1.5.
3. **Aplicación (10 min):** leer p. 13 y la lista de propiedades funcionales. Dibujar la p-list de un símbolo con `expr` y `macro`. Explicar la diferencia entre `expr`, `fexpr` y `macro` con una tabla.
4. **La diferencia central (10 min):** leer p. 14. Hacer la tabla `fexpr` vs. `macro`. Trazar `(mi-suma a b)` con la reconstrucción: forma completa → `(+ a b)` → `3`.
5. **Definición (5 min):** leer p. 54 y p. 55. Escribir la misma macro con `defun ... macro` y con `defprop ... macro`. Señalar que no es `DEFMACRO`.
6. **Compilador (5 min):** leer pp. 181–182 y 186. Explicar qué hace el compilador y qué cambia con `(macros t)`. Cerrar con la lista de lo que **no** se importa al ejercicio.

---

## 8. Preguntas de recuperación

1. ¿Qué es MACLISP y de qué dialecto desciende?
2. ¿Qué es una propiedad funcional?
3. ¿Qué propiedades funcionales menciona el manual en la p. 13?
4. ¿Dónde busca el evaluador la definición de un símbolo atómico?
5. ¿Qué recibe el primer lambda-variable de un `fexpr`?
6. ¿Qué recibe el primer lambda-variable de una `macro`?
7. ¿Qué hace el evaluador con el objeto que devuelve una macro?
8. ¿Por qué `apply` no acepta macros?
9. ¿Por qué `funcall` no acepta macros?
10. ¿Cómo se define una macro con `defun`?
11. ¿Cómo se define una macro con `defprop`?
12. ¿Qué diferencia hay entre `defprop` y `putprop`?
13. ¿Qué hace el compilador cuando encuentra una forma cuya `car` es una macro?
14. ¿Qué significa `(macros t)`?
15. ¿Qué significa `(macros nil)` y cuál es el valor por defecto?
16. ¿Qué hace la opción `-macros`?
17. ¿Qué diferencia hay entre la p-list de LISP 1.5 y la de MACLISP?
18. ¿Qué dice el manual sobre la recursión de macros?
19. ¿Qué dice el manual sobre `gensym` y las macros?
20. ¿Qué partes de esta ficha son continuidad con Hart y cuáles son añadidos de MACLISP?

---

## 9. Checklist de alcance para la IA tutora

Antes de responder cualquier pregunta basada en esta ficha:

- [ ] He leído esta ficha completa.
- [ ] Toda afirmación histórica está respaldada por una **CITA** con página.
- [ ] Distingo entre **cita**, **traducción**, **reconstrucción** y **observación de texto**.
- [ ] No presento MACLISP como el sistema de Hart.
- [ ] No atribuyo a Hart la reevaluación del resultado, el compilador o `(macros t)`.
- [ ] No convierto `(defun ... macro ...)` en `DEFMACRO`.
- [ ] No digo que `DEFMACRO`, `MACROEXPAND` o `MACRO-FUNCTION` estén en el manual de 1974.
- [ ] No digo que las macros se llamen con `apply` o `funcall`.
- [ ] No digo que la macro evalúe sus argumentos.
- [ ] No digo que el resultado de la macro se devuelva sin reevaluar.
- [ ] No confundo `fexpr` (recibe el `cdr`) con `macro` (recibe la forma completa).
- [ ] No digo que `(macros t)` sea el comportamiento por defecto.
- [ ] No atribuyo a Moon la regla de “no recursiva” de Weissman.
- [ ] No digo que `gensym` sea una herramienta específica de macros según este manual.
- [ ] No digo que la p-list de MACLISP tenga *flags*.
- [ ] No digo que `defprop` evalúe sus argumentos ni que `putprop` no los evalúe.
- [ ] No introduzco backquote, coma, coma-arroba, `&body`, `&rest`, `&optional`, `&aux` ni `DESTRUCTURING-BIND` en la lógica de expansión.
- [ ] El contrato del ejercicio sigue siendo `(mi-suma a b)` → `(+ a b)`.
- [ ] Si el estudiante pide una función fuera del kit, me detengo y le ofrezco una alternativa de época.
- [ ] Si la fuente no responde, digo «la fuente no lo dice» y no invento.

---

## 10. Referencias de esta ficha

- Moon, David A. *MACLISP Reference Manual*. Revision 0. Cambridge, Massachusetts: Project MAC, Massachusetts Institute of Technology, abril de 1974. <https://softwarepreservation.computerhistory.org/LISP/MIT/Moon-MACLISP_Reference_Manual-Apr_08_1974.pdf>
- Hart, Timothy P. «MACRO Definitions for LISP». AIM-057, MIT Artificial Intelligence Laboratory, 1963. <https://bitsavers.org/pdf/mit/ai/aim/AIM-057.pdf>
- Weissman, Clark. *LISP 1.5 Primer*. Belmont, California: Dickenson Publishing Company, 1967. <https://softwarepreservation.computerhistory.org/LISP/book/Weismann_LISP1.5_Primer_1967.pdf>
- McCarthy, John; Abrahams, Paul W.; Edwards, Daniel J.; Hart, Timothy P.; Levin, Michael I. *LISP 1.5 Programmer's Manual*. Cambridge, Massachusetts: The MIT Press, 1962 (2.ª ed., 1985). <https://softwarepreservation.computerhistory.org/LISP/book/LISP%201.5%20Programmers%20Manual.pdf>
- Índice de la familia LISP 1.5, Software Preservation Society: <https://softwarepreservation.computerhistory.org/LISP/lisp15_family.html>

---

## 11. Estado de la serie

| Ficha | Contenido | Estado |
|---|---|---|
| 01 | Hart, AIM-057 (1963): property list, `macro[1]`, `define`, `CSETQ`, `GENSYM` | completada |
| 02 | Weissman, *LISP 1.5 Primer* (1967): `MACRO`, `*EXPAND`, `CSETQ`, reglas | completada |
| 03 | *LISP 1.5 Programmer's Manual* (1962): a-lists, `DEFLIST`/`GET`, p-lists, `SUBST`/`SUBLIS`, `EVAL`/`APPLY`, `GENSYM` | completada |
| 04 | Moon, *MACLISP Reference Manual* (1974): propiedad funcional `macro`, forma completa, reevaluación, compilador, `(macros t)` | **esta ficha** |
| 05 | Kit cerrado de funciones y presupuesto histórico | completada (ficha 05) |
| 06 | Protocolo de lectura y enseñanza para la IA tutora | completada (ficha 06) |

La ficha 04 muestra el contraste posterior: qué se conserva de 1963 (la p-list, la forma completa, la construcción de listas) y qué se añade en MACLISP (la reevaluación, el compilador, la retención en runtime). La ficha 05 cierra el kit de funciones; la 06 da el protocolo de lectura para la IA tutora.
