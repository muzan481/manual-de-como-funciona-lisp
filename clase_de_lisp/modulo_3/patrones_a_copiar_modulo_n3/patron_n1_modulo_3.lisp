(cons 'manzana '(platano naranja)) ;;aqui creamos nuestra lista luego fuera de la expresion creamos un nuavo elemento y llamamos a cons para que lo construya y lo añada a la lista

(list 'espada 'escudo 'pocion) ;;aqui creamos los elementos de nuestra lista y llamamos a list para generar la lista correspondiente
      
      (cons (car '(fuego hielo))
            '(trueno agua)) ;;aqui creamos los elementos de ambas listas llamamos a car que tomara el cabezal de cada lista y se lo pasara a cons para construir la nueva lista pero car solo toma el primer elemento de las listas previas por lo tanto este es el resultado final --> (FUEGO TRUENO AGUA)



