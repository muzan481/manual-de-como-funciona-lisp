;; 1. Usamos eval-when para que la función esté disponible al compilar
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun transformar-datos (datos)
    (if (null datos)
        nil ; Caso base
        (let ((cabezal (first datos))
              (cola (rest datos)))
          ;; Construimos la lista de formas (forms)
          (cons `(tomar-primer-elemento ,cabezal)
                (transformar-datos cola))))))

;; 2. La macro ahora puede llamar a la función sin problemas
(defmacro mi-macro (&rest datos)
  `(progn
     ,@(transformar-datos datos)))