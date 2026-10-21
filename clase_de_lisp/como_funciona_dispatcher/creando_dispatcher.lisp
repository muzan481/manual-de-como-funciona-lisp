(defun dispatch (clave)
 (let* ((entrada 
        (assoc clave 
                    '((mi-suma expansion-suma)
                      (mi-resta expansion-resta)
                      (mi-producto expansion-producto)
                      (mi-imprimir expansion-imprimir)))))
       (cadr entrada)))

    (dispatch 'mi-producto)

;FLUJO DE EJECUCION:

;(despachador 'mi-producto) devuelve  EXPANSION-PRODUCTO 
; por que assoc busca el par clave valor,
; mi-producto expansion-producto en la lista,
; cuando lo encuentra se lo pasa a entrada,
; ahora entrada contiene: mi-producto expansion-producto 
; y cadr toma el segundo elemento, 
; es decir: EXPANSION-PRODUCTO

;POST DATA: la misma logica aplica para cada par clave valor de la lista 

(defun dispatcher-2 (clave)
 (let* ((entrada 
              (assoc
                   clave
                       '((parametros mi-producto x y)
                         (parametros-2 mi-producto a b)))))
           (cdr entrada)))

  (dispatcher-2 'parametros) 







