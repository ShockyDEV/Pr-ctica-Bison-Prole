PROGRAMA EXAMPLE1.
      * Comentario COBOL de asterisco en columna 7
INICIO  *> otro comentario
  MUEVE 5 * 25 A VAR.
  LEE V.
  MUESTRA 2.34e-10.
  EJECUTA
    RESTA 2 * V DE VAR.
  HASTA QUE VAR ES MENOR QUE 1
  FIN-EJECUTA.
  SI 5 - VAR ES MAYOR QUE 0 ENTONCES
      * Rama ENTONCES
        RESTA 1 DE V.
        MULTIPLICA 3 POR V DANDO Z.
        MUESTRA "3*(V-1) es: ", Z.
  SINO
      * Rama SINO
        MUEVE VAR + 10 A Z.
        MUESTRA 'VAR + 10 es: ', Z.
  FIN-SI.
FIN.