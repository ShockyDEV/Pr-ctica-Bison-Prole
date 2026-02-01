%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

   /*  Comentarios siempre son prioridad */
\*>[^\n]*        { /* ignorar */ }
^[ \t]*\*[^\n]*  { /* ignorar */ }


   /*  Palabras Reservadas (van antes que el ID) */
"PROGRAMA"    { return PROGRAMA; }
"INICIO"      { return INICIO; }
"FIN"         { return FIN; }
"MUESTRA"     { return MUESTRA; }

	/* Tokens condicion */
"SI"          { return SI; }
"ENTONCES"    { return ENTONCES; }
"SINO"        { return SINO; }
"FIN-SI"      { return FIN_SI; }
"ES"          { return ES; }
"NO"          { return NO; }
"MAYOR"       { return MAYOR; }
"MENOR"       { return MENOR; }
"QUE"         { return QUE; }
"IGUAL"       { return IGUAL; }


 /* Tokens de bucle */
 
"EJECUTA"     { return EJECUTA; }
"VECES"       { return VECES; }
"HASTA"       { return HASTA; }
"FIN-EJECUTA" { return FIN_EJECUTA; }

"LEE"         { return LEE; }

"MUEVE"       { return MUEVE; }
"A"           { return A; }
"SUMA"        { return SUMA; }
"RESTA"       { return RESTA; }
"DE"          { return DE; }
"MULTIPLICA"  { return MULTIPLICA; }
"POR"         { return POR; }
"DIVIDE"      { return DIVIDE; }
"ENTRE"       { return ENTRE; }
"DANDO"       { return DANDO; }
"CALCULA"     { return CALCULA; }
"FIN-CALCULA" { return FIN_CALCULA; }

   /* Identificadores */
[A-Z][A-Z0-9]*("-"[A-Z0-9]+)* { 
    yylval.string = strdup(yytext); 
    return ID; 
}

   /* Literales */
[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)? { 
    yylval.string = strdup(yytext); 
    return NUM; 
}

(\"[^\"]*\")|(\'[^\']*\') { 
    yylval.string = strdup(yytext); 
    return CAD; 
}

   /* Operadores y puntuación */
"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
"("     { return '('; }
")"     { return ')'; }
"."     { return PUNTO; }
","     { return COMA; }

[ \t\r]+                { /* ignora espacios */ }
\n                      { /* ignora saltos de línea */ }

. { return yytext[0]; }

%%