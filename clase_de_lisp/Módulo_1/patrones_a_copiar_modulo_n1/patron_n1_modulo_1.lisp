;;esta terminologia se usa para entender visual y literalmente la construccion de listas que uno hace

(+ 10 ;;creo y abro la caja
 (* 2 5) ;;creo la caja del medio
  (* 3 ;;creo la ante ultima caja
     (+ 1 1))) ;;creo la ultima caja



(+ 10 ;; y por ultimo la caja hija del medio (el resultado es el dato que la "hermana menor" heredara)
 (* 2 5) ;;luego la caja hija mayor 
  (* 3 ;;luego la caja padre
     (+ 1 1))) ;abro la caja madre

     ;;luego se puede usar la metafora de la herencia familiar para explicar que la ultima expresion (la madre) pasa sus datos geneticos al padre ambos pasan sus datos a sus hijas a su ves estas ultimas heredan sus datos a la ultima hermana (que en este ejemplo representa el resultado obtenido al compilar) asi funciona lisp desde mi vision