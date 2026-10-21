La respuesta corta es: **no es técnicamente obligatorio para el evaluador de Lisp, pero es una convención casi sagrada y de uso universal**.

---

### **1. ¿Por qué se usan los asteriscos (`*...*`)?**

A esta convención de nombrado se le conoce popularmente como ***earmuffs*** ("orejeras"). Se utiliza por dos razones principales:

1. **Advertencia visual de Ámbito Dinámico:** Al definir una variable con `defparameter` o `defvar`, Lisp la declara internamente como una **variable especial o dinámica** (de alcance global). Los asteriscos le avisan visualmente al programador: *"¡Cuidado! Esta variable es global y dinámica; cambiar su valor puede afectar a otras partes del programa"*.
2. **Evitar sombreado accidental de variables (*variable shadowing*):** Si defines una variable global llamada `lista` (sin asteriscos) y luego defines una función cuyo parámetro o variable local también se llame `lista`, la naturaleza especial de la variable global alterará el comportamiento de tu variable local en toda la pila de ejecución. Al nombrarla `*lista*`, es casi imposible que choque accidentalmente con un argumento local como `lista`.

---

### **2. ¿Qué ocurre si no los usas?**

Si ejecutas en tu REPL:
```lisp
(defparameter mi-lista '(a b c d))
```
El entorno **lo aceptará perfectamente** y funcionará sin dar error. Sin embargo, viola la convención estándar del lenguaje y puede provocar errores difíciles de rastrear más adelante cuando trabajes con funciones y ámbito dinámico.

---

### **3. Otras convenciones de nombrado comunes en Lisp**

En Lisp es muy común usar caracteres especiales como prefijos o sufijos para identificar el tipo de identificador:

* **Variables especiales/globales:** Rodeadas de asteriscos (`*mi-variable*`).
* **Constantes:** Rodeadas de signos más (`+dias-semana+` o `+pi+`).
* **Predicados (funciones que devuelven verdadero/falso):** Terminan en `-p` o `p` (ej. `listp`, `numberp`, `equalp`).
* **Funciones de bajo nivel/internas:** Empiezan con signo de porcentaje (`%memory-barrier`).

---

