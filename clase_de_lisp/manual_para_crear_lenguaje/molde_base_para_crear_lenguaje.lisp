;; =============================================================================
;; SECCIÓN 1: DEFINICIÓN DE LA FIRMA Y ENTRADA DEL LENGUAJE
;; =============================================================================

(defmacro DEFINIR-ROBOT (nombre-robot x-inicial y-inicial &body instrucciones) 
  ; Paso 1: Llamo a defmacro, defino el nombre de mi lenguaje y sus parámetros. Recibe el nombre del robot, su posición inicial y un bloque &body con las órdenes.



;; =============================================================================
;; SECCIÓN 2: CREACIÓN DEL ENTORNO Y MEMORIA (VARIABLES LOCALES)
;; =============================================================================

  `(let ((x ,x-inicial) 
         ; Paso 2: Abro backquote para la plantilla. Uso un 'let' para crear la variable 'x' e inyecto su valor inicial con una coma.

         (y ,y-inicial)) 
         ; Paso 3: Creo la variable 'y' de la misma manera, inyectando su valor inicial con una coma.



;; =============================================================================
;; SECCIÓN 3: DICCIONARIO DE COMANDOS (FUNCIONES EXCLUSIVAS DEL LENGUAJE)
;; =============================================================================

     (labels ((avanzar (pasos) (setf y (+ y pasos))) 
              ; Paso 4: Abro 'labels' para definir las palabras clave. Aquí 'avanzar' modifica la variable 'y' sumando pasos.

              (retroceder (pasos) (setf y (- y pasos))) 
              ; Paso 5: Defino el comando 'retroceder', que resta pasos a la variable 'y'.

              (derecha (pasos) (setf x (+ x pasos))) 
              ; Paso 6: Defino el comando 'derecha', que suma pasos a la variable 'x'.

              (izquierda (pasos) (setf x (- x pasos)))) 
              ; Paso 7: Defino el comando 'izquierda', que resta pasos a la variable 'x'.



;; =============================================================================
;; SECCIÓN 4: EJECUCIÓN DEL SCRIPT Y DESEMPAQUETADO DEL CUERPO
;; =============================================================================

       (progn 
         ; Paso 8: Llamo a 'progn' para asegurar la ejecución secuencial de todo el bloque interno.

         (format t "--- Inicializando Robot ~A en (~A, ~A) ---~%" ',nombre-robot x y) 
         ; Paso 9: Imprimo el estado inicial. Uso ',nombre-robot (comilla antes de la coma) para tratar el nombre como un símbolo y no como una variable.

         ,@instrucciones 
         ; Paso 10: Uso coma y arroba (,@) para desarmar la lista de instrucciones del usuario e inyectarlas limpiamente aquí dentro.

         (format t "--- Posición Final de ~A: (~A, ~A) ---~%" ',nombre-robot x y) 
         ; Paso 11: Imprimo el estado final en la consola una vez que el usuario terminó de ejecutar sus comandos.

         (list x y))))) 
         ; Paso 12: Cierro devolviendo una lista con las coordenadas finales (x y) y coloco todos los paréntesis de cierre correspondientes.