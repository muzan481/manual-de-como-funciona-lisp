2. **Los Huecos Simples (La Coma `,`):** Son las variables o "huecos" individuales dentro de la plantilla. Le dicen a Lisp: *"Detén un momento la copia literal, evalúa lo que viene aquí, e inyéctalo en este lugar"*.
3. **El Volcado Extensible (La Coma-Arroba `,@`):** Es el hueco especial para listas (generalmente el `&body` o `&rest`). Le dice a Lisp: *"Toma esta lista, quítale los paréntesis exteriores y desparrama/vuelca su contenido aquí dentro"*.

---

### Un ejemplo comparativo para entender el patrón

Para notar realmente el "patrón de plantilla", ayuda mucho ver cómo se hacía antes de que existiera este estilo. Imaginemos una macro simple que rodea un código con un inicio y un fin.

#### ❌ El estilo antiguo (Procedural / Constructor de listas)
Antes se tenía que construir el código pieza por pieza usando funciones de listas (`list`, `append`). Era confuso y difícil de leer:

```lisp
;; ESTO NO ES UNA PLANTILLA (Estilo antiguo y engorroso)
(defmacro con-bienvenida-antiguo (&body cuerpo)
  (list 'progn
        (list 'print "--- Inicio ---")
        (append cuerpo (list (list 'print "--- Fin ---")))))
```

####   El patrón Template-based (Tu estilo)
Con el patrón basado en plantillas, el código final **se ve idéntico** a cómo va a quedar al final. Es un mapa visual exacto:

```lisp
;; ESTO SÍ ES EL PATRÓN TEMPLATE-BASED
(defmacro con-bienvenida-moderno (&body cuerpo)
  `(progn
     (print "--- Inicio ---")
     ,@cuerpo
     (print "--- Fin ---")))