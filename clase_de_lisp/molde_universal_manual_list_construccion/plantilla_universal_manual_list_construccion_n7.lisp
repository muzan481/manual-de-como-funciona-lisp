(defmacro plantilla-inyectora (condicion &body cuerpo)
  "Une líneas dinámicas del programador y del usuario en un solo bloque."
  `(if ,condicion
       (progn
         ;; 1. Inyectamos tus múltiples líneas (Van envueltas en (list ...))
         ,@(list '(print "--- Inicio de log ---")
                 '(print "--- Procesando datos ---"))
         
         ;; 2. Inyectamos las líneas del usuario
         ,@cuerpo)))

;; === EJEMPLO DE USO ===
;; (plantilla-inyectora (= x 10)
;;   (print "El usuario hace algo")
;;   (setq x 0))



(defmacro plantilla-condicional-debug (modo-debug &body cuerpo)
  "Inyecta líneas extras de código SOLO si modo-debug es verdadero."
  `(progn
     ,@(if modo-debug
           (list '(print "[DEBUG] Entrando a la función")
                 '(incrementar-contador-debug)))
     ,@cuerpo))

;; === EJEMPLO DE USO ===
;; (plantilla-condicional-debug t
;;   (print "Código normal"))


;; consejo

,@(list '(linea 1) '(linea 2))
;; 👆  👆    👆
;; │   │    └─ Ponle comilla a cada línea para que no se ejecute antes de tiempo.
;; │   └─ La función LIST junta tus líneas en un paquete.
;; └─ El ,@ rompe el paquete de LIST y suelta las líneas limpias dentro del progn.