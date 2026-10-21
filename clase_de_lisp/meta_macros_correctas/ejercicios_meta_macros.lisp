;;;; EJEMPLOS EJECUTABLES: META-MACROS PASO A PASO
;;;; Copia y pega en tu REPL para ver funcionar

;;;; ============================================================================
;;;; EJERCICIO 1: Meta-macro simple (estilo quasiquoting)
;;;; ============================================================================

;;; Paso 1: Define la meta-macro
(defmacro crear-triplicadora ()
  `(defmacro triplicadora (x)
     (list x x x)))

;;; Paso 2: Expande la meta-macro para ver qué genera
(macroexpand-1 '(crear-triplicadora))
;;; Salida esperada:
;;; (DEFMACRO TRIPLICADORA (X)
;;;   (LIST X X X))

;;; Paso 3: Crea la macro generada
(crear-triplicadora)

;;; Paso 4: Usa la macro generada
(triplicadora 5)
;;; Salida esperada: (5 5 5)

;;; Paso 5: Expande la macro generada para ver su expansión
(macroexpand-1 '(triplicadora 5))
;;; Salida esperada: (LIST 5 5 5)


;;;; ============================================================================
;;;; EJERCICIO 2: Meta-macro con parámetros (estilo quasiquoting)
;;;; ============================================================================

;;; Paso 1: Define meta-macro que recibe el nombre de la macro
(defmacro crear-multiplicadora (nombre multiplicador)
  `(defmacro ,nombre (x)
     (list '* x ,multiplicador)))

;;; Paso 2: Expande para ver qué genera
(macroexpand-1 '(crear-multiplicadora por-dos 2))
;;; Salida: (DEFMACRO POR-DOS (X) (LIST '* X 2))

;;; Paso 3: Crea la macro
(crear-multiplicadora por-dos 2)

;;; Paso 4: Usa la macro
(por-dos 5)
;;; Salida: (* 5 2) → 10

;;; Paso 5: Crea OTRA macro con diferente multiplicador
(crear-multiplicadora por-tres 3)

;;; Paso 6: Usa ambas
(por-dos 5)   ;;; → (* 5 2) → 10
(por-tres 5)  ;;; → (* 5 3) → 15


;;;; ============================================================================
;;;; EJERCICIO 3: Meta-macro que genera macro con &rest (estilo quasiquoting)
;;;; ============================================================================

;;; Paso 1: Define meta-macro que genera una macro envolvente
(defmacro crear-envolvente (nombre prefix suffix)
  `(defmacro ,nombre (&rest expresiones)
     `(progn
        (print ,prefix)
        ,@expresiones
        (print ,suffix))))

;;; Paso 2: Expande para ver estructura
(macroexpand-1 '(crear-envolvente con-borde "=== INICIO ===" "=== FIN ==="))
;;; Salida: Verás la estructura con unquotes anidados

;;; Paso 3: Crea la macro
(crear-envolvente con-borde "=== INICIO ===" "=== FIN ===")

;;; Paso 4: Usa la macro generada
(con-borde
  (print "Línea 1")
  (print "Línea 2"))

;;; Salida esperada:
;;; === INICIO ===
;;; Línea 1
;;; Línea 2
;;; === FIN ===


;;;; ============================================================================
;;;; EJERCICIO 4: Comparación LIST vs QUASIQUOTING
;;;; ============================================================================

;;; VERSIÓN CON LIST (construcción manual)
(defmacro crear-sumadora-list ()
  (list
   'defmacro
   'sumadora
   '(a b)
   (list 'list ''+ 'a 'b)))

;;; VERSIÓN CON QUASIQUOTING (backtick)
(defmacro crear-sumadora-backtick ()
  `(defmacro sumadora (a b)
     (list '+ a b)))

;;; Ambas generan LO MISMO, pero la segunda es más legible


;;;; ============================================================================
;;;; EJERCICIO 5: Meta-macro con lógica más compleja
;;;; ============================================================================

;;; Meta-macro que crea una macro "repetidora"
(defmacro crear-repetidor (nombre veces)
  `(defmacro ,nombre (expr)
     (loop repeat ,veces collect expr)))

;;; Crea una macro que repite 3 veces
(crear-repetidor repite-tres 3)

;;; Usa la macro
(repite-tres "hola")
;;; Salida: ("hola" "hola" "hola")

;;; Crea otra que repite 5 veces
(crear-repetidor repite-cinco 5)
(repite-cinco 42)
;;; Salida: (42 42 42 42 42)


;;;; ============================================================================
;;;; EJERCICIO 6: MINI CHALLENGE - Crea tu propia meta-macro
;;;; ============================================================================

;;; Desafío: Crea una meta-macro que genere una macro "negadora"
;;; que convierta un valor en su negación (NOT)

;;; Solución:
(defmacro crear-negadora (nombre)
  `(defmacro ,nombre (valor)
     (list 'not valor)))

;;; Pruébalo:
(crear-negadora negar)
(negar t)
;;; Salida: NIL


;;;; ============================================================================
;;;; NOTAS SOBRE UNQUOTING ANIDADO `,',variable`
;;;; ============================================================================

;;; Cuando tienes backticks anidados en una meta-macro que crea
;;; una macro que a su vez usa backticks, necesitas:
;;;
;;; `,',variable = "unquote(quote(variable))"
;;;
;;; Esto significa: "Protege variable para que se interpole 
;;; correctamente en la macro generada, no en la meta-macro"

;;; Ejemplo:
(defmacro crear-comparadora (nombre tipo)
  `(defmacro ,nombre (a b)
     `(,',tipo a b)))

;;; Crea una macro que compara si a es mayor que b
(crear-comparadora es-mayor >)

;;; Pruébalo:
(es-mayor 5 3)
;;; Expande a: (> 5 3)
;;; Resultado: T
