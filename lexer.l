%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

   /* Comentarios: 6 espacios + asterisco o secuencia *> */
^[ ]{6}\*.* { /* ignorar */ }
"\*>".* { /* ignorar */ }

"PROGRAMA"  { return PROGRAMA; }
"INICIO"    { return INICIO; }
"FIN"       { return FIN; }
"MUESTRA"   { return MUESTRA; }

   /*  Mayúsculas y números, guiones en el medio */
[A-Z][A-Z0-9]*("-"[A-Z0-9]+)* { 
    yylval.string = strdup(yytext); 
    return ID; 
}

   /* Números positivos */
[0-9]+      { 
    yylval.num = atoi(yytext); 
    return NUM; 
}

   /* Cadenas con comillas simples o dobles */
(\"[^\"]*\")|(\'[^\']*\') { 
    yylval.string = strdup(yytext); 
    return CAD; 
}

[ \t\n\r]+  { /* ignorar espacios */ }
"."         { return PUNTO; }
","         { return COMA; }
.           { return yytext[0]; }

%%