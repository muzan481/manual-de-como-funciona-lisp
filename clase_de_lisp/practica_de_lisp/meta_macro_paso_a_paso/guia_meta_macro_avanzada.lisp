;;; Guía avanzada para crear una meta-macro con tu estilo de construir macros.
;;; Aquí vamos a construir una meta-macro que genera una macro con argumentos variables.

;;; ------------------------------------------------------------------
;;; 1. Recordemos la idea básica
;;; ------------------------------------------------------------------
;;; Una macro recibe una forma y la transforma en otra forma.
;;; Una meta-macro recibe una descripción y construye una macro nueva.

;;; ------------------------------------------------------------------
;;; 2. Macro simple de ejemplo
;;; ------------------------------------------------------------------
(defmacro mi-suma (a b)
  (list 'progn
        (list 'print (list '+ a b))
        (list '+ a b)))

;;; Esto ya funciona como una macro sencilla.

;;; ------------------------------------------------------------------
;;; 3. Una meta-macro que construye una macro con dos argumentos
;;; ------------------------------------------------------------------
(defun mi-meta-macro-basica (nombre operador)
  (list 'defmacro
        nombre
        '(a b)
        (list 'list operador 'a 'b)))

;;; Ejemplo:
;;; (eval (mi-meta-macro-basica 'mi-multiplicacion '*))

(eval (mi-meta-macro-basica 'mi-multiplicacion '*))

;;; Ahora ya existe la macro mi-multiplicacion.
;;; Prueba:
;;; (mi-multiplicacion 3 4)

;;; ------------------------------------------------------------------
;;; 4. Ahora vamos a hacerlo con argumentos variables
;;; ------------------------------------------------------------------
;;; La idea es que la macro nueva acepte varios argumentos, no solo dos.

(defun mi-meta-macro-variable (nombre operador)
  (list 'defmacro
        nombre
        '(args)
        (cons operador 'args)))

;;; Ejemplo:
;;; (eval (mi-meta-macro-variable 'mi-suma-variable '+))

(eval (mi-meta-macro-variable 'mi-suma-variable '+))

;;; Ahora la macro mi-suma-variable puede recibir varios argumentos.
;;; Prueba:
;;; (mi-suma-variable 1 2 3 4)

;;; ------------------------------------------------------------------
;;; 5. Qué está pasando realmente
;;; ------------------------------------------------------------------
;;; - mi-meta-macro-variable recibe un nombre y un operador.
;;; - construye una forma que representa una definición de macro.
;;; - la forma final usa cons para poner el operador al frente de los argumentos.
;;;
;;; En otras palabras, la meta-macro está construyendo una nueva macro
;;; a partir de una plantilla muy simple.

;;; ------------------------------------------------------------------
;;; 6. Una versión más visible, usando list y append
;;; ------------------------------------------------------------------
(defun mi-meta-macro-visible (nombre operador)
  (let* ((parametros '(args))
         (cuerpo (cons operador 'args)))
    (list 'defmacro
          nombre
          parametros
          cuerpo)))

;;; Aquí se ve todavía más claro el patrón:
;;; - primero se construye la lista de parámetros,
;;; - luego se construye el cuerpo de la macro,
;;; - y finalmente se arma la definición completa.

;;; ------------------------------------------------------------------
;;; 7. Ejercicio para practicar
;;; ------------------------------------------------------------------
;;; Intenta crear una meta-macro que construya una macro llamada mi-promedio
;;; y que haga una suma con division entre la cantidad de elementos.
;;;
;;; La idea es que la macro nueva acepte varios números y devuelva su promedio.

;;; Ejemplo de pensamiento:
;;; (mi-promedio 2 4 6)
;;; debería dar 4
