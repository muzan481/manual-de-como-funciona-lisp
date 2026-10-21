;;; Guía paso a paso para crear una meta-macro con la forma de construir macros
;;; que ya dominas: usando list, cons, append y progn.

;;; ------------------------------------------------------------------
;;; 1. Primero, recuerda la idea básica
;;; ------------------------------------------------------------------
;;; Una macro toma una forma de código, la transforma en otra forma de
;;; código y esa nueva forma se evalúa después.
;;;
;;; Una meta-macro hace algo más alto: toma una descripción o plantilla
;;; y construye otra macro a partir de esa plantilla.

;;; ------------------------------------------------------------------
;;; 2. Una macro simple que ya conocemos
;;; ------------------------------------------------------------------
(defmacro mi-suma (a b)
  (list 'progn
        (list 'print (list '+ a b))
        (list '+ a b)))

;;; Esta macro recibe una forma como (mi-suma 2 3) y la transforma en
;;; una forma nueva hecha con list y progn.

;;; ------------------------------------------------------------------
;;; 3. Ahora vamos a construir una meta-macro
;;; ------------------------------------------------------------------
;;; La idea es: en vez de escribir manualmente una macro, vamos a crear
;;; una herramienta que construya una macro a partir de una plantilla.

(defun mi-meta-macro (nombre operador)
  (list 'defmacro
        nombre
        '(a b)
        (list 'list operador 'a 'b)))

;;; Ejemplo de uso:
;;; (mi-meta-macro 'mi-multiplicacion '*)
;;;
;;; Esto construye una forma parecida a esta:
;;; (defmacro mi-multiplicacion (a b)
;;;   (list * a b))

;;; ------------------------------------------------------------------
;;; 4. Cómo probarla
;;; ------------------------------------------------------------------
;;; Si evaluamos esta forma:
;;; (mi-meta-macro 'mi-multiplicacion '*)
;;;
;;; el resultado será una lista que representa una definición de macro.
;;;
;;; Para que realmente quede registrada como macro, hay que evaluarla.

(eval (mi-meta-macro 'mi-multiplicacion '*))

;;; Ahora ya puedes usar la macro nueva:
;;; (mi-multiplicacion 3 4)

;;; ------------------------------------------------------------------
;;; 5. Qué está pasando aquí
;;; ------------------------------------------------------------------
;;; - mi-meta-macro recibe un nombre y un operador.
;;; - construye una lista que representa una definición de macro.
;;; - eval toma esa lista y la interpreta como código real.
;;;
;;; En otras palabras: la meta-macro construye otra macro.

;;; ------------------------------------------------------------------
;;; 6. La idea clave
;;; ------------------------------------------------------------------
;;; Tu forma de hacer macros funciona muy bien para esto porque ya estás
;;; construyendo código con listas. Eso es justo lo que necesita una
;;; meta-macro: construir una forma nueva que luego se evalúa.

;;; ------------------------------------------------------------------
;;; 7. Ejercicio simple para practicar
;;; ------------------------------------------------------------------
;;; Intenta cambiar la meta-macro para que construya una macro que haga:
;;; - suma
;;; - resta
;;; - division
;;; - o una combinación con print

;;; Por ejemplo:
;;; (eval (mi-meta-macro 'mi-resta '-))

;;; Luego prueba:
;;; (mi-resta 10 3)
