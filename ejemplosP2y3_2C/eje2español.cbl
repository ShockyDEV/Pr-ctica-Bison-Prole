PROGRAMA NESTED-CONTROL-STRUCTURES.
INICIO
      * Ejemplo de condicional anidada en un bucle
       MUEVE 10 A VAR-A.
       MUEVE 0 A B.
       EJECUTA
          SI B ES MENOR QUE VAR-A ENTONCES
            MUESTRA B.
          FIN-SI.
          SUMA 1 A B.
       HASTA QUE VAR-A ES IGUAL A B
       FIN-EJECUTA.

      * Ejemplo de bucles anidados
       MUEVE 5 A VAR-A.
       MUEVE 0 A C.
       EJECUTA
           RESTA 1 DE VAR-A.
           EJECUTA
             SUMA 2 A C.
             MUESTRA VAR-A, B, C.
           HASTA QUE C ES MAYOR QUE 9
           FIN-EJECUTA.
       HASTA QUE VAR-A ES IGUAL A 0
       FIN-EJECUTA.
FIN.