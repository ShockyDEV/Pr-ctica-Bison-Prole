PROGRAMA EXAMPLE0.
INICIO
      *> Pruebas de expresiones y notación científica
      MUEVE 2 * (1 + 4) A V1.
      SUMA 1 A V1.
      RESTA 2 * (1 + 4) DE V1.
      
      LEE V1.
      MUESTRA V1.
      MUESTRA 2.34e-10.
      MUESTRA "Mi edad es ", 45, ", y mi peso es ", 63.5, " Kgs".

      *> Prueba de condicionales
      SI VAR1 ES MAYOR QUE 0 ENTONCES 
          MUESTRA VTHEN. 
      SINO 
          MUESTRA VELSE. 
      FIN-SI.

      *> Prueba de bucles (usando regla HASTA QUE)
      MUEVE 1 A VAR.
      EJECUTA 
          MUESTRA VAR.
          SUMA 2 A VAR.
      HASTA QUE VAR ES MAYOR QUE 20
      FIN-EJECUTA.
FIN.