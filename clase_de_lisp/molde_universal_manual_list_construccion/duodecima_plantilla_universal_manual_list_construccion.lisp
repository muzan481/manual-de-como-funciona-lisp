;; =========================================================================
;; REVOLUCIONARIO DE MACROS MANUALES: MI ACORDÓN DE REFERENCIA
;; =========================================================================

;; -------------------------------------------------------------------------
;; PATRÓN 1: EL ENVOLTORIO SIMPLE (Estructura Básica)
;; Objetivo: Envolver un código que da el usuario dentro de un bloque 'progn.
;; Ideal para: Ejecutar varias líneas juntas.
;; -------------------------------------------------------------------------

(defmacro patron-envoltorio (&rest el-codigo)
  ;; LINEA 1: Capturamos todo lo que meta el usuario en una lista llamada 'el-codigo'.
  (destructuring-bind (&rest lineas) el-codigo
    ;; LINEA 2: Desempaquetamos 'el-codigo' y guardamos todas sus líneas en 'lineas'.
    (cons 'progn lineas)))
    ;; LINEA 3: Con 'cons', creamos una lista nueva metiendo el símbolo 'progn 
    ;; al principio de la lista de líneas del usuario. 
    ;; Resultado: (progn linea1 linea2 ...)

;; EJEMPLO DE USO:
;; (patron-envoltorio (print "A") (print "B"))
;; SE EXPANDE A:
;; (PROGN (PRINT "A") (PRINT "B"))


;; -------------------------------------------------------------------------
;; PATRÓN 2: EL INYECTOR DE LÍNEAS PROPIAS (Uso de 'list' para el cuerpo)
;; Objetivo: Crear una estructura (un 'let') e inyectar líneas fijas creadas 
;; por nosotros al mismo nivel que las del usuario.
;; Ideal para: Inicializar estados o variables estilo bloques de configuración.
;; -------------------------------------------------------------------------

(defmacro patron-inyector (nombre-bloque &rest configuraciones)
  ;; LINEA 1: Pedimos un nombre obligatorio y atrapamos las configuraciones en una lista.
  (destructuring-bind (&rest propiedades) configuraciones
    ;; LINEA 2: Guardamos la lista de configuraciones (ej: sublistas como (tipo 1)) en 'propiedades'.
    (list 'let propiedades
          ;; LINEA 3: Iniciamos una lista con el símbolo 'let y le pegamos las propiedades del usuario.
          (list 'print (list 'format nil "Entrando al bloque: ~A" nombre-bloque))
          ;; LINEA 4: ¡LÍNEA PROPIA 1! Creamos manualmente un print dinámico usando el nombre del bloque.
          '(print "Ejecutando lógica interna fijada por la macro...")
          ;; LINEA 5: ¡LÍNEA PROPIA 2! Una línea fija literal (usamos ' para que pase tal cual).
          '(format t "Fin del bloque.~%"))))
          ;; LINEA 6: ¡LÍNEA PROPIA 3! Cerramos el bloque 'let' con un formato de salida.

;; EJEMPLO DE USO:
;; (patron-inyector "BloqueMugen" (vida 100) (fuerza 50))
;; SE EXPANDE A:
;; (LET ((VIDA 100) (FUERZA 50))
;;   (PRINT (FORMAT NIL "Entrando al bloque: ~A" "BloqueMugen"))
;;   (PRINT "Ejecutando lógica interna fijada por la macro...")
;;   (FORMAT T "Fin del bloque.~%"))


;; -------------------------------------------------------------------------
;; PATRÓN 3: EL FUSIONADOR DE CÓDIGO (Uso de 'append' para pegar listas)
;; Objetivo: Tomar dos grupos de líneas que ya existen y pegarlas al mismo 
;; nivel sin que se creen paréntesis extra estorbosos.
;; Ideal para: Inyectar plantillas de código antes de las líneas del usuario.
;; -------------------------------------------------------------------------

(defmacro patron-fusionador (&rest codigo-usuario)
  ;; LINEA 1: Atrapamos todo el código que escriba el usuario.
  (destructuring-bind (&rest lineas-usuario) codigo-usuario
    ;; LINEA 2: Guardamos esas líneas limpias en 'lineas-usuario'.
    (append (list 'progn '(print "--- ALERTA: Iniciando Código Seguro ---") '(init-sistema))
            ;; LINEA 3: Creamos una lista inicial que tiene el 'progn y dos líneas de setup nuestras.
            lineas-usuario)))
            ;; LINEA 4: Con 'append', fusionamos la lista de arriba con la lista del usuario.
            ;; Al usar append, las líneas del usuario se pegan como hermanas, sin nidos.

;; EJEMPLO DE USO:
;; (patron-fusionador (hacer-algo) (cerrar-sistema))
;; SE EXPANDE A:
;; (PROGN
;;   (PRINT "--- ALERTA: Iniciando Código Seguro ---")
;;   (INIT-SISTEMA)
;;   (HACER-ALGO)
;;   (CERRAR-SISTEMA))


;; =========================================================================
;; REGLAS DE ORO PARA RECUERDO RÁPIDO:
;; 1. Si quieres meter una palabra literal en el código generado, ponle una comilla: 'if, 'progn, 'let.
;; 2. Si quieres meter el CONTENIDO de una variable que tiene el código del usuario, ponla limpia.
;; 3. LIST mete cosas en cajitas individuales (crea nidos). 
;; 4. APPEND rompe las cajitas de los extremos y junta todo en una sola línea continua.
;; =========================================================================