¡Aquí tienes tus 3 plantillas listas para guardar! Están diseñadas como bloques de construcción (piezas de Lego). Si entiendes estos 3 patrones, tendrás la base para armar casi cualquier macro manual.

Guarda esto textualmente en tu editor de código:

---

## Patrón 1: El Envoltorio Simple (Inyectar código antes y después)

**Para qué sirve:** Sirve para envolver un bloque de código que escribe el usuario dentro de otra función o macro del sistema (como `progn` o `let`). Es el patrón más usado.

```lisp
;; USO: (con-bloque (print "A") (print "B"))
;; TRANSFORMA EN: (progn (print "A") (print "B"))

(defmacro con-bloque (&rest cuerpo)
  ;; LINEA 1: 'cuerpo' recibe una lista con todo el código que metió el usuario.
  ;; LINEA 2: Usamos CONS porque 'cuerpo' ya es una lista, y solo queremos
  ;;          pegarle la palabra 'progn en la cabeza (al principio).
  (cons 'progn cuerpo))

```

---

## Patrón 2: El "Desarmador" de Variables (`destructuring-bind` + `list`)

**Para qué sirve:** Sirve para cuando el usuario te pasa parámetros específicos (como variables y valores) y tú necesitas desarmarlos uno por uno para crear una estructura limpia desde cero (como un `let` o un `setq`).

```lisp
;; USO: (asignar-doble x y 10 20)
;; TRANSFORMA EN: (progn (setq x 10) (setq y 20))

(defmacro asignar-doble (&rest todo)
  ;; LINEA 1: 'todo' agarra los 4 elementos juntos en una lista.
  ;; LINEA 2: destructuring-bind abre esa lista y le da un nombre a cada pieza suelta.
  (destructuring-bind (v1 v2 val1 val2) todo
    ;; LINEA 3: Usamos LIST para crear la lista externa (el 'progn' principal).
    (list 'progn
          ;; LINEA 4: Usamos LIST para armar la primera asignación independiente.
          (list 'setq v1 val1)
          ;; LINEA 5: Usamos LIST para armar la segunda asignación independiente.
          (list 'setq v2 val2))))

```

---

## Patrón 3: La Condición Combinada (`list` + `cons`)

**Para qué sirve:** Este es el patrón definitivo para macros que toman decisiones (como un `if`, `when` o `unless`). Combina `list` para la estructura fija de la decisión y `cons` para agrupar el cuerpo de código del usuario.

```lisp
;; USO: (hacer-si-verdadero (= 1 1) (print "Si") (print "Ok"))
;; TRANSFORMA EN: (if (= 1 1) (progn (print "Si") (print "Ok")))

(defmacro hacer-si-verdadero (condicion &rest cuerpo)
  ;; LINEA 1: Separamos la 'condicion' (primer argumento) del resto del 'cuerpo'.
  ;; LINEA 2: Usamos LIST porque sabemos exactamente cuántas piezas tiene el IF principal.
  (list 'if 
        ;; LINEA 3: Metemos la condición que nos dio el usuario tal cual.
        condicion
        ;; LINEA 4: Metemos el "entonces". Como el cuerpo tiene varias líneas,
        ;;          usamos CONS para empaquetarlas todas dentro de un 'progn'.
        (cons 'progn cuerpo)))

```

---

### 💡 El truco definitivo para probar tus macros en el editor:

Cuando estés escribiendo tus propias macros basadas en estas plantillas, pon esta línea abajo en tu archivo para verificar si la geometría de tu lista quedó bien armada:

```lisp
;; Ejecuta esto en tu consola REPL para ver el "rompecabezas" armado:
(macroexpand-1 '(hacer-si-verdadero (= 2 2) (print "Funciona")))

```