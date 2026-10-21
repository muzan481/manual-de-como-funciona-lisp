;; =====================================================================
;; PATRÓN DE REFERENCIA PARA MACROS EN COMMON LISP (CON BACKQUOTE)
;; =====================================================================
;; REGLA DE ORO:
;; ` (Backquote) -> Significa: "Todo lo que sigue es CÓDIGO LITERAL"
;; , (Coma)      -> Significa: "¡ALTO! Evalúa esto y pon su VALOR aquí"
;; ,@ (Coma-At)  -> Significa: "Evalúa esta LISTA y sácale los paréntesis"
;; =====================================================================

(defmacro NOMBRE-DE-LA-MACRO (parametro-1 parametro-2 &body cuerpo)
  "Documentación opcional de qué hace la macro."
  `(
    ;; 1. Aquí escribes el código Lisp TAL Y COMO quieres que se vea al final.
    
    ;; 2. Si necesitas meter un parámetro simple, le pones una coma:
    (funcion-lisp ,parametro-1 ,parametro-2)
    
    ;; 3. Si recibiste un '&body' (una lista de varias líneas de código)
    ;;    y quieres que se ejecuten una tras otra, usas ,@ dentro de un 'progn':
    (progn
      ,@cuerpo)
    ))