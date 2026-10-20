;;las celdas cons o `cons cells` son como "eslabones" de una cadena

;;EJEMPLO:
;                                                         ___________________
;(cons "hola"  (cons "mi" (cons "amigo" nil))) <---------|fin dela "cadena" |       
;   ∧             ∧                     ∧              | |__________________|
;   |             |                     |              |
;   |             |                     |              |
; __|_______      |__________         __|________      |
;|primer   |------|segundo  |        |"eslabon" |      |
;|"eslabon"|      |"eslabon"|--------| final    |------|
;|_________|      |_________|        |__________|
;                                   