(and (listp '(foo 1 2)) (eq (car '(foo 1 2)) 'foo));;listp avalua el primer simbolo, eq compara el primer elemento que car toma de la lista con foo, si es igual al simbolo foo, devuelve T (TRUE), pero como el elemento que evaluo listp, no es una lista, and corta la evaluacion y devuelve nil (FALSO) 
Entrada ──► [ Puesto 1 ] ──(si es verdadero)──► [ Puesto 2 ] ──(si es verdadero)──► [ Resultado Final ]
                     │                                   │
                (si falla)                          (si falla)
                     ▼                                   ▼
                 ¡Se detiene!                        ¡Se detiene!