# Preguntas frecuentes (y "puntos ciegos")

Son las dudas que suelen aparecer al abrir este repositorio por primera vez y que no se responden con solo mirar las carpetas.

> Esta página **explica** el manual, no lo cambia. Todo lo que hay en `clase_de_lisp/` se deja tal cual lo escribió el autor.

---

## Sobre el repositorio

### ¿Qué es exactamente esto? ¿Un curso, un libro, un proyecto?
Es un **manual de estudio personal** convertido en libro: lo que el autor fue aprendiendo de Lisp, en el orden y con las palabras con que lo entendió. Va desde cómo se lee Lisp hasta cómo construir macros que fabrican otras macros y un mini "lenguaje" propio con un expansor.

### ¿Qué dialecto de Lisp usa?
**Common Lisp.** Se probó con **SBCL**. Si usas Scheme, Racket, Clojure o Emacs Lisp, muchas cosas (`defmacro`, `defparameter`, `destructuring-bind`, `&rest`/`&body`, paquetes) no van a funcionar igual.

### ¿Necesito saber programar antes?
No. El Módulo 1 empieza explicando cómo **leer** Lisp (paréntesis, sangría, listas). Lo que sí ayuda es ir en orden y escribir los ejemplos a mano.

### ¿En qué orden lo leo?
Las carpetas no aparecen ordenadas en GitHub (se ordenan alfabéticamente, no por módulo). Hay un orden de lectura sugerido en [`mapa_del_contenido.md`](mapa_del_contenido.md). En corto: primero `Módulo_1` → `modulo_2` … `modulo_19`, después las carpetas `como_funciona_*` y por último las de macros (`como_hacer_*`, `molde_universal_*`, `mis_macros`, etc.).

### ¿Qué significa "patrones a copiar"?
Cada módulo tiene una carpeta `patrones_a_copiar_modulo_nX`. Son **ejemplos pensados para copiarse a mano** (no con copiar/pegar) y así fijar la sintaxis en la memoria. Muchos traen una "TAREA" o "EJERCICIO RESUELTO".

---

## Sobre los archivos

### Abrí un `.lisp` y es texto normal, no código. ¿Está mal?
No. **Muchos `.lisp` del manual son explicaciones** (prosa, Markdown, analogías, preguntas y respuestas) guardadas con extensión `.lisp` para tenerlas junto al código y verlas en el mismo editor. Hay tres tipos de archivo:

| Tipo | Cómo reconocerlo | Qué hacer |
|---|---|---|
| Código puro | Empieza con `(defun`, `(defmacro`, `(car` … | Cárgalo con `(load ...)` o cópialo al REPL |
| Código con comentarios | Líneas con `;;` explicando cada paso | Igual que el anterior |
| Explicación en texto | Empieza con una frase, títulos `#`, `**negritas**` | **Léelo**; copia al REPL solo los bloques de código |

### Hice `(load "...")` y me salió `The variable LA is unbound` (u otra palabra). ¿Qué pasó?
Cargaste un archivo de **explicación en texto**. Lisp intentó evaluar la primera palabra del texto (por ejemplo `La`) como si fuera una variable. No es un error del manual: ese archivo es para leerlo. Copia al REPL solo los bloques de código que te interesen.

### ¿Qué es `expansor_final.fasl`?
Es la versión **compilada** de `mi_expansor_final/expansor_final.lisp`. La generó SBCL 2.2.9. Un `.fasl` solo carga en **la misma versión de SBCL** que lo creó. Con otra versión sale `INVALID-FASL-VERSION`. En ese caso carga el `.lisp`:

```lisp
(load "clase_de_lisp/mi_expansor_final/expansor_final.lisp")
```

Si quieres tu propio `.fasl`, compílalo **fuera del repositorio** para no sobrescribir el original:

```lisp
(compile-file "clase_de_lisp/mi_expansor_final/expansor_final.lisp"
              :output-file "/tmp/expansor_final.fasl")
(load "/tmp/expansor_final.fasl")
```

### ¿Cómo pruebo el expansor final?
```lisp
(load "clase_de_lisp/mi_expansor_final/expansor_final.lisp")
(evaluar-mi-lisp '(mi-suma 1 2 3))
;; [Inspección] Forma expandida: (+ 1 2 3)
;; => 6
```
`dispatch` busca el operador (`mi-suma`) en una tabla con `assoc`, `expandir-forma` llama al expansor que le toca (`expansion-suma`) y `evaluar-mi-lisp` muestra la forma expandida y la evalúa con `eval`.

### ¿Cómo uso el paquete de `paquetes_de_mis_macros`?
Ese archivo define un paquete llamado `quinta-macro`. Después de cargarlo, la macro se llama con el nombre del paquete delante:

```lisp
(load "clase_de_lisp/paquetes_de_mis_macros/paquete_quinta_macro.lisp")
(macroexpand-1 '(quinta-macro:mi-quinta-macro progn (1 2) (print :fin)))
;; => (PROGN (QUINTA-MACRO::FUNCION 1) (QUINTA-MACRO::FUNCION 2) (PRINT :FIN))
```

Ojo: al cargarlo, el REPL queda "dentro" del paquete `quinta-macro` por el `in-package`. Para volver: `(in-package :cl-user)`.

### Los nombres de archivo tienen paréntesis, comillas, espacios, `&` y tildes. ¿Es un problema?
En GitHub y en el editor no pasa nada. En la **terminal** sí: hay que poner la ruta **entre comillas dobles**:

```bash
sbcl --load "clase_de_lisp/como_usar_&rest_y_&key/uso_de_&rest.lisp"
```

Dentro de Lisp, `(load "...")` ya lleva comillas, así que funciona tal cual. Los símbolos en el nombre (`( ' )`, `( '' )`, `( ,', )`) indican de qué trata el archivo: comilla, doble comilla, coma-comilla-coma, etc.

### ¿Por qué `Módulo_1` lleva tilde y mayúscula, y `modulo-9` lleva guion en vez de guion bajo?
Son los nombres originales del autor y se mantienen así. A efectos prácticos:
- `Módulo_1` es el primer módulo (aparece al final en el orden alfabético de GitHub por la mayúscula/tilde).
- `modulo-9` es el módulo 9 (equivale a "modulo_9").
- Dentro de `modulo_11/` el archivo se llama `patron_n1_modulo_n10(uso_SET).lisp` y su título dice "Módulo 10 (Antes de continuar)". Es un tema (`set`/`setq`) que se intercaló antes de seguir con el curso, y se guardó en la carpeta del módulo 11.

### ¿`destructuring_bing` es lo mismo que `destructuring-bind`?
Sí. La carpeta `como_usar_destructuring_bing/` trata sobre la macro de Common Lisp **`destructuring-bind`**. En el código hay que escribirlo con guion y **bind**: `(destructuring-bind (a b) lista ...)`.

### Algunos archivos parecen respuestas de una conversación ("¡Muy buena observación!", "Aquí tienes…"). ¿Por qué?
El manual se construyó estudiando con preguntas y respuestas, y el autor guardó las explicaciones que le sirvieron, tal cual le ayudaron a entender. Forman parte del recorrido de aprendizaje y por eso se conservan sin editar.

---

## Sobre los conceptos (glosario mínimo)

| Término | Qué significa en este manual |
|---|---|
| **Forma** | Cualquier expresión de Lisp, por ejemplo `(+ 1 2)`. |
| **`car` / `cdr`** | Primer elemento de una lista / el resto de la lista. `cadr`, `caddr`, `cadddr` son combinaciones (módulos 8–10). |
| **Comilla `'`** | "No evalúes esto, déjalo como dato." `'(a b)` es una lista, no una llamada. |
| **Doble / triple comilla `''` `'''`** | Comillas que sobreviven a una o dos evaluaciones. Se usan en meta-macros (macros que generan macros). |
| **Backquote `` ` ``, coma `,`, coma-arroba `,@`** | Plantilla de código: `` ` `` copia literal, `,` inserta un valor, `,@` inserta y "desparrama" una lista. |
| **`,',`** | Truco de meta-macros para insertar un valor de la macro externa dentro de la plantilla de la macro interna. |
| **Construcción manual de listas** (*manual list construction*) | Armar el código de una macro con `list`, `cons` y `append` en vez de backquote. Es el estilo central del manual. |
| **Meta-macro** | Una macro cuyo resultado es otra `defmacro`. |
| **Dispatcher / expansor** | Mini sistema propio: una tabla (`assoc`) decide qué función transforma cada forma antes de evaluarla con `eval`. |
| **`&rest` / `&body` / `&key`** | Parámetros que reciben "el resto" de argumentos, el cuerpo de una macro o argumentos con nombre. |

---

## Sobre colaborar

### ¿Puedo corregir un error que encontré en `clase_de_lisp/`?
**No directamente.** Esa carpeta es solo de lectura porque refleja cómo el autor entiende Lisp. Si crees que algo está mal, abre un *issue* explicando el archivo y la línea. El autor decide.

### ¿Qué sí se puede mejorar?
La documentación de alrededor: `README.md`, esta carpeta `docs/` e `instrucciones_para_ia/`.

### Uso una IA (Copilot, Cursor, Claude, ChatGPT, Devin…) con este repo. ¿Cómo evito que toque el manual?
El repositorio ya trae [`AGENTS.md`](../AGENTS.md) en la raíz (lo leen automáticamente muchas herramientas) y las reglas completas, con prompts listos para copiar, en [`instrucciones_para_ia/INSTRUCCIONES_PARA_IA.md`](../instrucciones_para_ia/INSTRUCCIONES_PARA_IA.md). Pega el prompt de la sección 6.1 al empezar cada conversación.
