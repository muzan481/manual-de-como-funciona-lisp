(defun dispatch (clave)
  (let* ((entrada
         (assoc clave '((mi-suma expansion-suma)
                        (mi-resta expansion-resta)
                        (mi-dividir expansion-dividir)
                        (mi-multiplicar expansion-multiplicar)
                        (mi-producto expansion-producto)
                        (mi-imprimir expansion-imprimir)))))
                (cadr entrada)))

(defun expansion-suma (forma)
  (cons '+ (cdr forma)))

(defun expandir-forma (forma)
  (cond
   ((listp forma)
    (let* ((operador (car forma))
           (nombre-expansor (dispatch operador)))
          (if nombre-expansor
              (funcall nombre-expansor forma)
              forma)))
   (t forma)))

(defun evaluar-mi-lisp (forma)
  (let* ((forma-expandida (expandir-forma forma)))
    (format t "~%[Inspección] Forma expandida: ~s" forma-expandida)
    (eval forma-expandida)))