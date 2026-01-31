%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

   /* 1. Comentarios (Prioridad) */
^[ ]{6}\*.* { /* ignorar línea completa */ }
"\*>".* { /* ignorar comentario de línea */ }

   /*  Palabras Reservadas (van antes que el ID) */
"PROGRAMA"    { return PROGRAMA; }
"INICIO"      { return INICIO; }
"FIN"         { return FIN; }
"MUESTRA"     { return MUESTRA; }

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

   /* Identificadores */
[A-Z][A-Z0-9]*("-"[A-Z0-9]+)* { 
    yylval.string = strdup(yytext); 
    return ID; 
}

   /* Literales */
[0-9]+ { 
    yylval.num = atoi(yytext); 
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

[ \t\n\r]+ { /* ignora espacios */ }

. { return yytext[0]; }

%%