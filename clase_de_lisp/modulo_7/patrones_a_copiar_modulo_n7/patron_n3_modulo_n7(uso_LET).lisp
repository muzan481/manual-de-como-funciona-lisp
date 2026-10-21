;;el codigo let siempre funciona como una cadena de transformaciones en el que cada "celula" usa el dato anterior


(let* ((args '(mi-suma a b)) ;;celula padre toma los datos de hija-mayor para "reconstruirse" asi misma
        (extraer (cdr args)) ;;celula segunda-hija hereda los datos de celula hija para "construir los datos" de "hija-mayor"
         (simbolo (cons '+ extraer))) ;;celula primer hija toma simbolo y usa su dato para construir " + "
    simbolo) 
        
                 
 ;; a esto lo llamo Cadena de Reconstrucción o "Sistema de Reconstrucción por Etapas " o, para abreviar (S.R.E.) ya que hacemos una "reconstruccion imaginaria" sobre "la construccion que ocurre" al ejectar el codigo   

 ;;aclaracion:
 
 ;; para entender esta forma de entender el codigo
 
 ;; primero se debe leer todo de arriba a abajo como lo haria cualquier persona para entender que se escribio,
 
 ;; si se quiere entender "que hace el codigo"
 
 ;; todo debe leerse de abajo hacia arrriba
 
 ;; ese es el flujo de ejecucion del codigo 
 