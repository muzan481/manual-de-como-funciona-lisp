 ;;flujo de ejecucion:

 ;;la funcion recibe una clave que es mi-suma, ejecuta
;        |                                      | 
;        |                                      |
;        |                                      |
;        |                                      |
;        ⅴ                                      |        
;(defun despachador (clave)                    ;|
; (let* ((entrada                              ;|
;       (assoc clave;--- vale                  ;|
                         ;|                    ;|
                         ;ⅴ ___________________;ⅴ__________     
;                   '((mi-suma expansion-suma)            ;|
;                     (mi-resta expansion-resta)          ;|
;                     (mi-producto expansion-producto)    ;|
;                     (mi-imprimir expansion-imprimir)))));|
;                    ;_____________________________________| 


;           ________contiene -------> (mi-suma expansion-suma)
;          |                              ∧                ∧
;          |                              |                |
;(cadr entrada)))                         |                |
; |         ∧                             |                |
; |         |                             |                |   
; |         |                             | cadr-----toma--|-----> segundo elemento   
; |------- recibe                         |                                  |
;                                         |-->primer elemento                |
;                                                                            |
;                                                                            |                                                                           |
;                                                                            |
;                                                                            |
;  (despachador 'mi-suma) <--------------------------------------------------|
;           |
;           |
;           |
;           ⅴ
;        devuelve
;           |
;           |
;           |
;           ⅴ
;      expansion-suma


