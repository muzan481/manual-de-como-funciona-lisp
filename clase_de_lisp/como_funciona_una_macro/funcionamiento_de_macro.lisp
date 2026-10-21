El evaluador recibe una forma.

↓

Obtiene el primer símbolo.

↓

Si es una macro:

    llama al expansor.

↓

El expansor devuelve una nueva forma.

↓

El evaluador vuelve a recibir esa nueva forma.

↓

Si ahora esa nueva forma corresponde a una función,
evalúa sus argumentos y la ejecuta.