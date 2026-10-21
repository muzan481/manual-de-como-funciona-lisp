(defun funcion-auxiliar (lista-elementos) ;;paso 1:defino el nombre de mi funcion y le paso mi lista
 (mapcar (lambda (elemento) ;;paso 2: llamo a mapcar y lambda y le paso la lista "elemento" que funciona como "un contenedor"
   `(funcion ,elemento)) ;;páso 3: llamo a bakquote (`) para crear "mi plantilla"
             lista-elementos)) ;;paso 4: dentro de mi plantilla diseño su "estrctura" a la que le paso mi "contenedor" con una coma detras seguido de la "lista" de mi funcion para que tome su contenido y una con mi forma  
            
(defmacro mi-quinta-macro (bloque elementos &body cuerpo) ;;paso 5: defino mi macro le paso los parametros seguido de &body junto con la "forma" que este y ultimo espera
 `(,bloque  ;;paso 6: dentro de la plantilla defino las "formas" que mi macro espera lo desarmo poniendo coma (,) seguido de arroba (@) detras de el
  ,@(funcion-auxiliar elementos) ;;paso 7: llamo a mi funcion junto con "los elementos" que tranformara en una nueva "lista"
  ,@cuerpo)) ;;paso 8: llamo al cuerpo de mi macro y lo desarmo poniendo coma (,) seguido de arroba (@) detras de el asi se vuelcan todos los elentos en orden