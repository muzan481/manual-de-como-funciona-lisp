;;;; EJEMPLOS DE META-MACROS CORRECTAS
;;;; Comparación: Construcción manual (list) vs Quasiquoting (backtick)

;;;; ============================================================================
;;;; EJEMPLO 1: Meta-macro simple que genera una macro "dobladora"
;;;; ============================================================================

;;; --- ESTILO 1: Construcción manual con LIST
(defmacro generar-dobladora-list ()
  (list
   'defmacro
   'dobladora
   '(x)
   (list 'list x x)))

;;; Resultado cuando ejecutas (macroexpand-1 '(generar-dobladora-list)):
;;; (DEFMACRO DOBLADORA (X) (LIST X X))

;;; Luego: (generar-dobladora-list)
;;; Ahora (dobladora 5) expande a (LIST 5 5) → (5 5)


;;; --- ESTILO 2: Construcción con QUASIQUOTING (más legible)
(defmacro generar-dobladora-backtick ()
  `(defmacro dobladora (x)
     (list x x)))

;;; Más fácil de leer porque VES la estructura tal como quedará


;;;; ============================================================================
;;;; EJEMPLO 2: Meta-macro que genera una macro "constructora de pares"
;;;; ============================================================================

;;; --- ESTILO 1: LIST (necesita cuidado con las comillas)
(defmacro generar-par-list (nombre)
  (list
   'defmacro
   nombre
   '(a b)
   (list 'list ''cons 'a 'b)))

;;; Resultado: genera (defmacro nombre (a b) (list 'cons a b))
;;; Luego: (generar-par-list mi-par)
;;; Ahora: (mi-par 1 2) expande a (CONS 1 2)

;;; Nota: ''cons = comilla doble = símbolo literal 'cons


;;; --- ESTILO 2: QUASIQUOTING (más claro)
(defmacro generar-par-backtick (nombre)
  `(defmacro ,nombre (a b)
     (list 'cons a b)))

;;; Más legible: ves que a y b son variables (sin comilla), 
;;; y 'cons es literal (con comilla)


;;;; ============================================================================
;;;; EJEMPLO 3: Meta-macro que acepta parámetros
;;;; ============================================================================

;;; --- ESTILO 1: LIST (complicado)
(defmacro generar-envolvedor-list (nombre inicio fin)
  (list
   'defmacro
   nombre
   '(&rest cuerpo)
   (list 'list
         ''progn
         (list 'list ''print inicio)
         (list 'cons ''progn 'cuerpo)
         (list 'list ''print fin))))

;;; Problema: es difícil ver qué se genera


;;; --- ESTILO 2: QUASIQUOTING (mucho más claro)
(defmacro generar-envolvedor-backtick (nombre inicio fin)
  `(defmacro ,nombre (&rest cuerpo)
     `(progn
        (print ,inicio)
        ,@cuerpo
        (print ,fin))))

;;; ¡MUCHO mejor! Ves exactamente qué forma tendrá la macro generada


;;;; ============================================================================
;;;; EJEMPLO 4: Meta-macro que genera una macro con lógica condicional
;;;; ============================================================================

;;; --- ESTILO 2 PURO: Solo QUASIQUOTING (recomendado)
(defmacro generar-validador-backtick (nombre condicion)
  `(defmacro ,nombre (valor)
     `(if ,',condicion
          (print "✓ Válido")
          (print "✗ Inválido"))))

;;; Nota: ,',condicion = unquote(quote(condicion)) 
;;; Protege la condición para que se interpole en la macro generada


;;;; ============================================================================
;;;; REGLAS CLAVE PARA EVITAR ERRORES
;;;; ============================================================================

;;; REGLA 1: En LIST, necesitas comillas EXPLÍCITAS
;;; -------------------------------------------------
;;; ✓ Correcto:  (list 'defmacro 'nombre ...)
;;; ✗ Incorrecto: (list 'defmacro nombre ...)  → intenta evaluar nombre como código

;;; REGLA 2: En LIST, símbolo literal = una comilla (')
;;; -------------------------------------------------
;;; ✓ (list 'cons ...)    → crea símbolo 'cons
;;; ✗ (list ''cons ...)   → crea símbolo ''cons (dos comillas = doble comilla literal)

;;; REGLA 3: En QUASIQUOTING, símbolo literal = una comilla (')
;;; -------------------------------------------------
;;; `(cons ,a ,b)  → cons es literal, a y b se interpolan

;;; REGLA 4: En QUASIQUOTING, parámetro de la meta-macro = coma (,)
;;; -------------------------------------------------
;;; `(defmacro ,nombre ...)  → nombre se interpola
;;; `(defmacro 'nombre ...)  → nombre literal (¡error!)

;;; REGLA 5: En QUASIQUOTING, lista de parámetros = coma-arroba (,@)
;;; -------------------------------------------------
;;; `(progn ,@cuerpo)  → desparrama cuerpo como elementos individuales
;;; ✗ `(progn ,cuerpo)   → cuerpo se anida como lista única (¡incorrecto!)


;;;; ============================================================================
;;;; RESUMEN: CUÁNDO USAR CADA ESTILO
;;;; ============================================================================

;;; LIST (Construcción manual):
;;; + Funciona siempre, sin errores de sintaxis
;;; - Es verboso y confuso (muchas comillas)
;;; - Difícil de leer qué se genera
;;; → Úsalo si necesitas MÁXIMO control o tienes situaciones muy complejas

;;; QUASIQUOTING (Backtick):
;;; + Código generado es VISUALMENTE idéntico al resultado final
;;; + Mucho más legible
;;; + Menos comillas = menos confusión
;;; - Un poco más abstracto de aprender al principio
;;; → RECOMENDADO: úsalo en casi todos los casos

;;; HÍBRIDO:
;;; + Puedes mezclar: backtick donde sea legible, list donde sea necesario
;;; - Requiere experiencia para saber cuándo es cada uno
;;; → Úsalo una vez domines ambos estilos
