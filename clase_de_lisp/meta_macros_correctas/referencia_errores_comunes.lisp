;;;; REFERENCIA RÁPIDA: ERRORES COMUNES Y CÓMO EVITARLOS
;;;; Consulta este archivo cuando debuggees tus meta-macros

;;;; ============================================================================
;;;; ERROR 1: PROGN sin comilla en construcción manual
;;;; ============================================================================

;;; ✗ INCORRECTO (causa: "undefined variable PROGN")
(defmacro malo ()
  (list
   'defmacro 'nombre '(x)
   (list 'list 'progn x)))  ;;; ← PROGN sin comilla

;;; ✓ CORRECTO: Usa comilla simple o doble
(defmacro correcto-v1 ()
  (list
   'defmacro 'nombre '(x)
   (list 'list ''progn x)))  ;;; ← ''progn (comilla doble)

;;; ✓ MEJOR: Usa quasiquoting
(defmacro correcto-v2 ()
  `(defmacro nombre (x)
     (list 'progn x)))  ;;; ← 'progn (literalmente comilla-progn)


;;;; ============================================================================
;;;; ERROR 2: Olvidar comillas en LIST
;;;; ============================================================================

;;; ✗ INCORRECTO (Lisp intenta evaluar defmacro como código)
(defmacro malo ()
  (list defmacro 'nombre '(x) x))

;;; ✓ CORRECTO: Todas las palabras clave deben llevar comilla
(defmacro correcto ()
  (list 'defmacro 'nombre '(x) x))


;;;; ============================================================================
;;;; ERROR 3: Unquoting incorrecto en QUASIQUOTING
;;;; ============================================================================

;;; ✗ INCORRECTO: Olvidas la coma para interpolar parámetro
(defmacro malo (nombre)
  `(defmacro nombre (x) x))  ;;; ← nombre es LITERAL, no se interpola

;;; ✓ CORRECTO: Usa coma para interpolar
(defmacro correcto (nombre)
  `(defmacro ,nombre (x) x))  ;;; ← ,nombre interpola el valor


;;;; ============================================================================
;;;; ERROR 4: Usar coma en lugar de coma-arroba con listas
;;;; ============================================================================

;;; ✗ INCORRECTO: &rest termina como lista anidada
(defmacro malo (&rest cuerpo)
  `(progn
     (print "inicio")
     ,cuerpo  ;;; ← NETA: (progn (print "inicio") (expr1 expr2 expr3))
     (print "fin")))

;;; ✓ CORRECTO: Usa coma-arroba para desparramar
(defmacro correcto (&rest cuerpo)
  `(progn
     (print "inicio")
     ,@cuerpo  ;;; ← BIEN: (progn (print "inicio") expr1 expr2 expr3)
     (print "fin")))


;;;; ============================================================================
;;;; ERROR 5: "Invalid number of arguments" en macro generada
;;;; ============================================================================

;;; Causa: El cuerpo de la macro generada no es una lista S-expression válida
;;;
;;; ✗ INCORRECTO EJEMPLO:
(defmacro generar-macro ()
  (list 'defmacro 'mi-macro '(x y)
        (list 'list 'progn x y)))  ;;; ← (list progn x y) intenta llamar PROGN como función
                                    ;;  pero está siendo evaluado como símbolo sin definir

;;; ✓ CORRECTO:
(defmacro generar-macro ()
  `(defmacro mi-macro (x y)
     (list 'progn x y)))  ;;; ← (list 'progn ...) crea ("progn" x y) = forma válida


;;;; ============================================================================
;;;; ERROR 6: Comillas anidadas confusas en LIST
;;;; ============================================================================

;;; Regla: En LIST, cada comilla agrega UN nivel de protección

;;; 'x         → Símbolo x
;;; ''x        → Símbolo 'x (comilla literal)
;;; '''x       → Símbolo ''x (dos comillas literales)

;;; Ejemplo:
(list 'quote 'x)     ;;; → (quote x)
(list 'quote ''x)    ;;; → (quote 'x)


;;;; ============================================================================
;;;; ERROR 7: Anidamiento de backticks (unquoting anidado)
;;;; ============================================================================

;;; Cuando tienes backticks anidados, necesitas aumentar nivel de comillas:

;;; SIMPLE (1 nivel):
(defmacro simple (nombre)
  `(defmacro ,nombre (x) x))

;;; DOBLE (2 niveles: meta-macro genera macro que genera código):
(defmacro doble (nombre)
  `(defmacro ,nombre (x)
     `(list ',x)))  ;;; ← Nota: backtick interior, comilla en x

;;; TRIPLE (3 niveles: requiere `,,` y `,,@`):
(defmacro triple (nombre)
  `(defmacro ,nombre (&rest args)
     `(progn
        ,@args)))  ;;; ← ,,@args haría falta si fuera triple nivel


;;;; ============================================================================
;;;; TABLA DE REFERENCIA: SÍMBOLOS ESPECIALES
;;;; ============================================================================

;;; SÍMBOLO | EN LIST           | EN BACKTICK      | PROPÓSITO
;;; --------|-------------------|------------------|------------------
;;; '       | Protege símbolo   | Protege símbolo  | Evita evaluación
;;; ''      | Comilla literal   | (raro)           | Dos comillas
;;; ,       | (no existe)       | Interpola        | Desquotea valor
;;; ,@      | (no existe)       | Splice list      | Desparrama lista


;;;; ============================================================================
;;;; CHECKLIST DE DEBUG
;;;; ============================================================================

;;; Cuando tu meta-macro tiene error, verifica:

;;; 1. ¿La meta-macro tiene todos los 'defmacro' entre comillas?
;;;    (list 'defmacro ...)  ✓
;;;    (list defmacro ...)   ✗

;;; 2. ¿Los nombres de parámetros tienen comillas en LIST?
;;;    (list 'defmacro 'nombre '(x))  ✓
;;;    (list 'defmacro name (x))      ✗

;;; 3. ¿Usas coma (,) para interpolar en backticks?
;;;    `(defmacro ,nombre ...)  ✓
;;;    `(defmacro nombre ...)   ✗

;;; 4. ¿Usas coma-arroba (,@) para desparramar &rest?
;;;    `(progn ,@args)  ✓
;;;    `(progn ,args)   ✗

;;; 5. ¿Ejecutaste (macroexpand-1 '(tu-meta-macro)) para ver qué genera?
;;;    ✓ Hazlo SIEMPRE primero

;;; 6. ¿Ejecutaste tu meta-macro DESPUÉS de ver el resultado?
;;;    (tu-meta-macro)  ← Crea la macro
;;;    ✓ Necesario ANTES de poder usar la macro generada

;;; 7. ¿Hiciste (macroexpand-1 '(tu-macro-generada args)) para ver expansión?
;;;    ✓ Úsalo para debuggear la macro generada


;;;; ============================================================================
;;;; COMANDO RECOMENDADO: Función auxiliar para debuggear
;;;; ============================================================================

;;; Define esto en tu REPL para debuggear fácilmente:
(defun debug-macro (expr)
  "Expande una expresión macro y muestra todos los niveles"
  (format t "~%Original: ~S~%" expr)
  (format t "Expand-1: ~S~%" (macroexpand-1 expr))
  (format t "Expand-all: ~S~%" (macroexpand expr)))

;;; Úsalo así:
;;; (debug-macro '(mi-meta-macro))
