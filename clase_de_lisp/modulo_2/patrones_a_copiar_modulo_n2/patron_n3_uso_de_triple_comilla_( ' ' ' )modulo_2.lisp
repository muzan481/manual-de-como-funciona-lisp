;;USO DE LA TRIPLE COMILLA ( ' ' ') LA "MATRIOSKA"
  
            ;        ------------------------------------------------------                                                                                                                                                    
            ;        |                                                    |                   
            ;        |                     |------------------------------|-----------------------------------------|                                                               
            ;        |                     |                              |                                         |         
            ;        |                     ⅴ   |--(usamos tres o mas comillas dependiendo de por cuanto tiempo queremos que un simbolo se mantenga transformado en simblo es decir la coma hace que el simbolo no se evalue durante "un par de vueltas")                                                  |
            ;        |            |------------|                                                                    |
            ;        |            |                                       |                                         |
            ;        |            |                                       |                                         |
            ;        ⅴ            ⅴ                                       |                                         |          
(defparameter *bloque-congelado* '''muñeca-rusa) ;;paso 1:definimos el nombre de nuestro parametro y creamos el simbolo que contiene el parametro
;   
;  |---------------------------------------------|
;  |                                             |
;  ⅴ                                             |
;                                                |
;                         ;;paso 2: llamamos a eval y le pasamos el nombre de nuestro parametro para que ejecute el simbolo que contiene
;                                                                                                                       |    
;               --------------------------------------------------------------------------------------------------------|                        
;               |
;               ⅴ
(eval *bloque-congelado*) ;;paso 3: en "la primera vuelta" se abre la primer muñeca (matrioska madre)
 (eval (eval *bloque-congelado*)) ;;paso 4: en "la segunda vuelta" se abre la segunda muñeca (matrioska hija)
  (eval (eval (eval *bloque-congelado*))) ;;paso 5 en "la tercer vuelta" ultima muñeca (matrioska hija menor) ahora el simmbolo es un dato 


  ;  (SIMPLIFICACION)
  ;         |
  ;         |
  ;         ⅴ
  ; ('''bloque-congelado) <---SIMBOLO ORIGINAL
  ; (''bloque-congelado) <--- AQUI SE QUITA LA TERCER COMA 
  ; ('bloque-congelado) <--- AQUI SE QUITA LA SEGUNDA COMA
  ; (bloque-congelado) <--- AQUI SE QUITA LA PRIMER Y ULTIMA COMA
  ;         |
  ;         |
  ;         ⅴ
  ;     RESULTADO
  ;         |
  ;         |
  ;         |
  ;         ⅴ
  ;   *BLOQUE-CONGELADO* <--- AHORA *BLOQUE-CONGELADO* ES UN DATO      