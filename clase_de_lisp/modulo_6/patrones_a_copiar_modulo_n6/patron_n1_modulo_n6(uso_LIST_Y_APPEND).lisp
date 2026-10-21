;;USO DE list Y append


(list '(naranja manzana) '(pera banana)) ;;aqui creamos 2 listas poniendo los elemenntos en expresiones individuales para que list las genere

;; pero si queremos crear ambas listas por separado y unirlas despues podemos hacer lo siguiente:

;;ACLARACION:LIST se usa aproposito para indicar explicitamente que las expresiones que append toma son listas esto es por una cuestion didactica no se debe usar list con append y esto lo explicarenos en el ejemplo 2

(append  ;;paso 3: llamamos a append que recibira ambas listas y pegara sus elementos a una nueva lista  
 '(naranja manzana) ;;paso 2: realizamos el mismo proceso del paso uno para cada lista nueva 
   '(pera banana)) ;;paso 1: creamos nuestra primer lista con una comilla para que se devuelva la lista como texto literal y se la pasamo a append para que "pegue" sus elementos en una nueva lista


(append 
 (list '(naranja manzana)  
  (list '(pera banana))))

  ;;se debe usar append para unir listas sin usar la funcion LIST ya que append tomara tanto a las listas individuales como a la funcion LIST texto literal devolviendo lo siguiente --> ((NARANJA MANZANA) (PERA BANANA))por eso solo se necesita la comilla ( ' )




;;USO DE cons:

;;METAFORA: "RECLUSO A SU CELDA"
;    ----------------------------------------------------------
;    |                                                        |
;    ⅴ                                                        |
; (cons '+ '(1 1))<--------|                                  |
;        ^                 |                                  |
;        |-----------------|--------                          |
;                          |       |                          |
;;paso 1: creamos nuestra celda    |                          |
;                        ----------|                          |
;                        |                                    |
  ;;paso 2:creamos el elemento que recibira nuestra celda     | 
;                                                             |                              
;                             ---------------------------------
;                             |
       ;;paso 3: llamamos a cons para que meta el elemento en la celda


       ;;en sintesis nuestra expresion es la celda, el elemento es el recluso y cons es el guardia que lo mete dentro
    ;                             |                        |                      |
    ;      (cons +'  (1 1))<------|                        |                      |
    ;        ^   ^                                         |                      |
    ;        |   |-----------------------------------------|                      |
    ;        |                                                                    |
    ;        |                                                                    |  
    ;        |--------------------------------------------------------------------|





;;TAREA REALIZADA:

;;PATRON HECHO CON cons

(cons 'progn '((print "alerta")10 20))

;;PATRON HECHO CON append

(append '(progn)
 '((print "alerta")10 20))






