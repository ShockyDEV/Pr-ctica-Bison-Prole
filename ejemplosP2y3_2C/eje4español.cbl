PROGRAMA NESTED-STRUCTURES.
INICIO
   MUEVE 5 A A.
   MUEVE 10 A B.
   EJECUTA
     RESTA 1 DE A.
     EJECUTA
       RESTA 1 DE B.
       EJECUTA
            MUEVE A * B A C.
            MULTIPLICA 10 POR C DANDO D.
            SI C ES MAYOR QUE D ENTONCES
                MUESTRA C.
            SINO
                MUEVE 2 * C A V.
                MUEVE V A VAR2.
                EJECUTA
                   SI VAR2 ES MAYOR QUE 0 ENTONCES 
                       MUESTRA VAR2.
                   SINO
                       MUEVE V A VAR.
                       EJECUTA
                          MUEVE 2 + VAR * 3 A Z.
                          MUESTRA Z.
                          SUMA 3 A VAR.
                       HASTA QUE VAR ES MAYOR QUE 50
                       FIN-EJECUTA.
                   FIN-SI.
                   SUMA 1 A VAR2.
                HASTA QUE VAR2 ES MAYOR QUE 100
                FIN-EJECUTA.
            FIN-SI.
       HASTA QUE A ES MAYOR QUE B
       FIN-EJECUTA.
     HASTA QUE B ES IGUAL A 0
     FIN-EJECUTA.
   HASTA QUE A ES IGUAL A 0
   FIN-EJECUTA.
FIN.