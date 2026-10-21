;;FORMA INCORRECTA:

(cdr (cdr '(bici coche muñeca))) ;; aqui cdr "corta" la cola de la lista para crear una lista nueva --> (coche muñeca)
                                 ;; si cdr recorre  esta nueva lista como ahora el primer elemento de lo que antes era una cola se convierte en el cabezal 
                                                                                                                                                    ;;|
                                                                                                                                                    ;;|  
                                                                                                                                                    ;;ⅴ
                                                                                                                                                    ;;cabezal       
                                                                                                                                                    ;;(coche muñeca) <-- toma 
                                                                                                                                                                           
                                                                                                                                                                         ;;|
                                                                                                                                                                         ;;|  
                                                                                                                                                                         ;;ⅴ
                                                                                                                                                                         ;; resultado --> (MUÑECA)

;;FORMA CORRECTA

(car (cdr '(bici coche muñeca))) ;;aqui cdr "corta" la cola de la lista para crear una lista nueva --> (coche muñeca)
                                 ;; cdr le pasa esa lista a car y car toma el cabezal para crear una nueva lista --> (COCHE) e imprimir su elemento en consola
                                                                                                                                                        ;;|
                                                                                                                                                        ;;|  
                                                                                                                                                        ;;ⅴ
                                                                                                                                                        ;; RESULTADO --> COCHE
                                                                                                                                                            