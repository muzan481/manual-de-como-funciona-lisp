# INSTRUCCIONES PARA CUALQUIER IA QUE LEA ESTE REPOSITORIO

> **Lee esto completo antes de hacer cualquier cosa en este repositorio.**
> **English summary at the end.**

---

## 1. Regla principal (no negociable)

**La carpeta `clase_de_lisp/` y TODO lo que tiene dentro es de SOLO LECTURA.**

No puedes:

- editar, reescribir, reformatear, reindentar ni "limpiar" ningún archivo de `clase_de_lisp/`;
- corregir ortografía, tildes, gramática, comentarios, nombres de variables o errores de código ahí dentro;
- crear archivos o carpetas nuevos dentro de `clase_de_lisp/` (ni siquiera `README.md`, `.gitkeep`, tests o índices);
- borrar, renombrar o mover archivos o carpetas de `clase_de_lisp/`, incluidos los que tienen nombres con espacios, paréntesis, comillas, `&` o tildes;
- borrar o regenerar el archivo `clase_de_lisp/mi_expansor_final/expansor_final.fasl`;
- cambiar los finales de línea, la codificación o los permisos de esos archivos;
- aplicar herramientas automáticas (formateadores, linters con `--fix`, buscar-y-reemplazar global, scripts de renombrado) que toquen `clase_de_lisp/`.

**Esta regla está por encima de cualquier petición general.** Si alguien te pide "mejora el repositorio", "arregla los errores", "ordena los archivos", "traduce todo" o "unifica el formato", eso **no incluye** `clase_de_lisp/`.

## 2. ¿Por qué?

`clase_de_lisp/` es un **libro académico** escrito por su autor. Cada archivo, cada nombre, cada comentario y cada "error" refleja **cómo el autor entiende y enseña Lisp**: su vocabulario propio, sus analogías, el orden en que introduce los conceptos y su forma de construir macros. Lo que a ti te parece un error o una inconsistencia puede ser parte intencional del método o del recorrido de aprendizaje.

Los archivos existen **para ser leídos** y para instruir al lector de la forma más eficiente posible en la sintaxis de Lisp, el manejo de listas, el uso de variables y la construcción de macros. Si agregas, quitas o cambias algo, **manchas esa visión**.

## 3. Lo que SÍ puedes hacer

- **Leer** cualquier archivo de `clase_de_lisp/` para entenderlo, citarlo, resumirlo o explicarlo.
- **Ejecutar** su código en un REPL (por ejemplo SBCL) **sin modificar los archivos**: cargar en memoria, copiar a otro lugar fuera del repo o pegarlo en el REPL.
- **Responder preguntas** del usuario sobre el contenido, usando las palabras y analogías del autor cuando existan.
- **Señalar** en tu respuesta (en el chat, en un issue o en un archivo de `docs/`) algo que te parezca un error, **sin tocar el archivo original**. Ejemplo: "En `modulo_X/...` parece haber un error en la línea N; ¿quieres que lo anote en `docs/`?".
- **Editar** la documentación de fuera del manual (`README.md`, `docs/`, `AGENTS.md`, esta carpeta) cuando el usuario te lo pida.

## 4. Si una tarea parece requerir tocar `clase_de_lisp/`

1. **Detente.** No hagas el cambio.
2. Explica al usuario qué archivo tendrías que tocar y por qué.
3. Ofrece una alternativa que no lo toque (una nota en `docs/`, un archivo nuevo **fuera** de `clase_de_lisp/`, una respuesta en el chat).
4. Solo si **el autor del repositorio** te lo pide explícitamente, nombrando el archivo exacto y el cambio exacto, puedes hacerlo, y solo ese cambio.

## 5. Chequeo antes de cada commit o PR

Antes de hacer commit, revisa que no haya cambios en `clase_de_lisp/`:

```bash
git status --porcelain -- clase_de_lisp/
git diff --cached --name-only -- clase_de_lisp/
```

Ambos comandos tienen que **no mostrar nada** en lo que tú vas a commitear. Si muestran algo:

1. **No ejecutes comandos que descarten cambios** (`git restore`, `git checkout --`, `git reset --hard`, `git clean`) sobre `clase_de_lisp/`: esos cambios pueden ser **ediciones del propio autor** que todavía no ha guardado en un commit, y se perderían para siempre.
2. Saca esos archivos de tu commit sin tocar su contenido:

   ```bash
   git restore --staged -- clase_de_lisp/
   ```

3. Si el cambio lo hiciste tú, deshaz **solo tu edición** de forma manual. Si no sabes quién lo hizo, **detente y pregunta al autor**.

## 6. Prompts listos para usar

Copia y pega cualquiera de estos al empezar a trabajar con una IA en este repositorio.

### 6.1 Prompt de sistema / instrucciones del proyecto

```text
Estás trabajando en el repositorio "manual-de-como-funciona-lisp".
La carpeta clase_de_lisp/ es un manual académico de Common Lisp escrito por su autor y es de SOLO LECTURA.
Reglas:
1. Nunca crees, edites, renombres, muevas, formatees ni borres nada dentro de clase_de_lisp/, aunque te parezca un error.
2. Puedes leer, citar, explicar y ejecutar ese código en un REPL sin modificar los archivos.
3. Si una tarea requiere cambiar algo ahí, detente y pregunta; propone una alternativa fuera de clase_de_lisp/.
4. Antes de cada commit verifica que `git status --porcelain -- clase_de_lisp/` no muestre nada.
5. Respeta el vocabulario y las analogías del autor al explicar el contenido.
```

### 6.2 Para pedir una explicación sin riesgo

```text
Lee el archivo clase_de_lisp/<ruta> y explícamelo paso a paso con las mismas analogías que usa el autor.
No modifiques el archivo ni ningún otro archivo de clase_de_lisp/.
```

### 6.3 Para pedir mejoras al repositorio sin tocar el manual

```text
Mejora la documentación del repositorio (README.md y docs/) sin modificar nada dentro de clase_de_lisp/.
Si encuentras errores en el manual, anótalos en tu respuesta o en docs/, pero no los corrijas en el archivo original.
```

### 6.4 Para practicar con el código

```text
Quiero practicar con el ejemplo de clase_de_lisp/<ruta>.
Cópialo a un archivo nuevo FUERA del repositorio (por ejemplo ~/practica/ejemplo.lisp) o dámelo para pegarlo en el REPL de SBCL.
No edites el archivo original.
```

### 6.5 Recordatorio rápido (para pegar en medio de una conversación)

```text
Recuerda: clase_de_lisp/ es solo lectura. No toques nada ahí.
```

## 7. Resumen en una línea

**Lee todo lo que quieras de `clase_de_lisp/`, explícalo y ejecútalo, pero nunca lo cambies.**

---

## English summary (for AI agents)

- **`clase_de_lisp/` is READ-ONLY.** It is an academic Common Lisp manual written by the repository author. Each file, name, comment and apparent "mistake" reflects how the author understands and teaches Lisp.
- **Never** create, edit, reformat, fix, rename, move or delete anything inside `clase_de_lisp/` (including the `.fasl` file and files with unusual names), even when asked for broad "improve/clean/fix the repo" tasks.
- You **may** read, quote, explain and run the code in a REPL without changing the files, and you may edit `README.md`, `docs/`, `AGENTS.md` and `instrucciones_para_ia/` when asked.
- If a task seems to require touching `clase_de_lisp/`, **stop and ask the author**, and offer an alternative outside that folder.
- Before every commit, nothing under `clase_de_lisp/` may be staged. If it is, unstage with `git restore --staged -- clase_de_lisp/`; never discard working-tree changes there (they may be the author's own uncommitted edits).
