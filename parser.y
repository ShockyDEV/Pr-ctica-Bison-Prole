%{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
void secure(int ifOk);

int label_count = 0;
char* new_label() {
    char* s;
    secure(asprintf(&s, "LBL%d", label_count++));
    return s;
}
%}

%union {
    int num;
    char *string;
}

%token PROGRAMA INICIO FIN PUNTO COMA MUESTRA
%token <num> NUM
%token <string> ID CAD
%type <string> axioma sentencias sentencia lista_literales literal

%%

/* Estructura: PROGRAMA ID. INICIO sentencias FIN. */
axioma: PROGRAMA ID PUNTO INICIO sentencias FIN PUNTO {
            printf("%s", $5);
            free($2); free($5);
        }
      ;

sentencias: sentencia { $$ = $1; }
          | sentencias sentencia { 
              secure(asprintf(&$$, "%s%s", $1, $2)); 
              free($1); free($2); 
            }
          ;

sentencia: MUESTRA lista_literales PUNTO {
            $$ = $2; 
          }
         ;

/* Lógica de máquina de pila para mostrar valores */
lista_literales: literal { 
                    secure(asprintf(&$$, "%s\tprint 1\n", $1));
                    free($1);
                 }
               | lista_literales COMA literal {
                    secure(asprintf(&$$, "%s%s\tprint 1\n", $1, $3));
                    free($1); free($3);
                 }
               ;

literal: ID  { secure(asprintf(&$$, "\tvalord %s\n", $1)); free($1); }
       | NUM { secure(asprintf(&$$, "\tmete %d\n", $1)); }
       | CAD { secure(asprintf(&$$, "\tmetecad %s\n", $1)); free($1); }
       ;

%%

void secure(int ifOk) {
    if (ifOk <= 0) { exit(-1); }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}