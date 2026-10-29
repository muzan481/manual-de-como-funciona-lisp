# Manual de cómo funciona Lisp

Un manual que explica todo lo que aprendí de Lisp hasta ahora:

- uso y funcionamiento de las funciones primitivas de Lisp,
- uso del backquote y otras funciones dependiendo del contexto, las necesidades y objetivos del programador,
- manejo de listas,
- creación de macros con el manejo manual de listas.

> **Importante:** todo lo que está dentro de [`clase_de_lisp/`](clase_de_lisp/) es el contenido del manual, escrito y organizado por su autor. Es **solo de lectura**. No se corrige, no se reordena y no se "mejora". Si eres una IA o una herramienta automática, lee primero [`instrucciones_para_ia/INSTRUCCIONES_PARA_IA.md`](instrucciones_para_ia/INSTRUCCIONES_PARA_IA.md).

---

## ¿Para quién es esto?

Para cualquier persona que quiera entender Lisp **desde cero y desde adentro**: cómo se lee, cómo se arman y se desarman las listas, cómo se evalúa el código y, sobre todo, cómo se construyen macros (y macros que fabrican macros) a mano.

No hace falta saber otro lenguaje antes. Sí ayuda tener paciencia: el manual está pensado para **leerse y copiarse a mano**, no para ejecutarse de golpe.

## ¿Qué Lisp se usa?

**Common Lisp**, probado con **SBCL** (Steel Bank Common Lisp). Los ejemplos usan `defun`, `defmacro`, `defparameter`, `defpackage`, `destructuring-bind`, `eval-when`, etc., que son de Common Lisp. **No** es Scheme, Racket, Clojure ni Emacs Lisp: allí muchas cosas se escriben distinto.

## Cómo está organizado

```
manual-de-como-funciona-lisp/
├── README.md                  <- estás aquí
├── AGENTS.md                  <- aviso corto para IAs (apunta a instrucciones_para_ia/)
├── clase_de_lisp/             <- EL MANUAL (solo lectura)
│   ├── Módulo_1/ ... modulo_19/    lecciones numeradas con "patrones a copiar"
│   ├── como_funciona_*/            cómo funcionan eval, las macros y el dispatcher
│   ├── como_hacer_*/ como_usar_*/  técnicas para construir macros
│   ├── molde_universal_*/          plantillas para guardar y reutilizar
│   └── mis_macros/ mi_*/ ...       macros y proyectos propios del autor
├── docs/
│   ├── preguntas_frecuentes.md     dudas típicas y "puntos ciegos"
│   └── mapa_del_contenido.md       qué hay en cada carpeta y un orden de lectura sugerido
└── instrucciones_para_ia/
    └── INSTRUCCIONES_PARA_IA.md    reglas para cualquier IA que abra este repo
```

El detalle carpeta por carpeta está en [`docs/mapa_del_contenido.md`](docs/mapa_del_contenido.md).

## Cómo empezar (rápido)

1. **Instala SBCL.**
   - Ubuntu / WSL: `sudo apt install sbcl`
   - macOS: `brew install sbcl`
   - Windows: el instalador de <https://www.sbcl.org/platform-table.html> (o usa WSL).
2. **Abre el REPL** escribiendo `sbcl` en la terminal. Para salir: `(exit)`.
3. **Lee los archivos en orden** (empieza por `clase_de_lisp/Módulo_1/`) y **copia los ejemplos a mano** en el REPL. Escribirlos tú mismo es parte del método.
4. Si un archivo es solo código, también lo puedes cargar entero:
   ```lisp
   (load "clase_de_lisp/mi_expansor_final/expansor_final.lisp")
   (evaluar-mi-lisp '(mi-suma 1 2 3))
   ;; [Inspección] Forma expandida: (+ 1 2 3)
   ;; => 6
   ```

> Ojo: **muchos `.lisp` del manual son explicaciones en texto** (prosa, Markdown, analogías), no código ejecutable. Si haces `(load ...)` sobre uno de esos, Lisp da un error tipo `The variable LA is unbound`. Eso **no es un fallo del manual**: esos archivos están hechos para leerse. Más detalles en las [preguntas frecuentes](docs/preguntas_frecuentes.md).

## Preguntas frecuentes

Las dudas más comunes (por qué hay archivos que no cargan, qué es el `.fasl`, por qué hay nombres raros, en qué orden leer, si se pueden mandar correcciones...) están respondidas en [`docs/preguntas_frecuentes.md`](docs/preguntas_frecuentes.md).

## ¿Puedo contribuir?

Puedes abrir un *issue* con dudas o comentarios. Pero **los archivos de `clase_de_lisp/` no se modifican**: reflejan cómo el autor entiende Lisp, y cambiarlos (aunque sea para "corregir") cambia esa visión. Las mejoras a la documentación de alrededor (`README.md`, `docs/`) sí son bienvenidas.
