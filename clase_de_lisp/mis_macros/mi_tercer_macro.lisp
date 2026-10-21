(defmacro MI_TERCER_MACRO (bloque primer-elemento segundo-elemento tercer-elemento &body cuerpo) ;paso 1.llamo a defmacro y defino el nombre de mi macro en sus parametreos le paso la primer "plantilla" que recibe que es la condicion luego le paso &body seguido de la "plantilla" cuerpo para que capture el cuerpo de la mocro
 `(let ,bloque ;paso 2: llamo a backquote para crear la "plantilla" que genera mi macro  dentro de la expresion llamo a let seguido de la "plantilla" condicion con una coma detras para capturar el dato de esa "plantilla" 
     (progn ;paso 3:llamo a progn
           (print ,primer-elemento)
           (print ,segundo-elemento)
           (print ,tercer-elemento)
            ,@cuerpo))) ;paso 4: le paso la "plantilla" cuerpo con una coma seguido de un "@" detras para "desarmar y pegar" todo el cuerpo de la macro dentro de progn 