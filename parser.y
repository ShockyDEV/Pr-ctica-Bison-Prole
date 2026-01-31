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

/* Tokens de estructura y E/S */
%token PROGRAMA INICIO FIN PUNTO COMA MUESTRA
/* Tokens de verbos y preposiciones */
%token MUEVE A SUMA RESTA DE MULTIPLICA POR DIVIDE ENTRE DANDO
%token <num> NUM
%token <string> ID CAD

/* He usado directivas de asociatividad para evitar
 que la gramática sea demasiado profunda y facilitar la concatenación de las instrucciones
 de la máquina de pila en una sola regla */
 
%left '+' '-'
%left '*' '/'

/* Tipos de los no terminales */
%type <string> axioma sentencias sentencia lista_literales literal expr asignar aritmetica

%%

/* Estructura basica */
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

sentencia: MUESTRA lista_literales PUNTO { $$ = $2; }
         | asignar PUNTO { $$ = $1; }
         | aritmetica PUNTO { $$ = $1; }
         ;

/* valori ID, evaluar expresión, swap, asigna */
asignar: MUEVE expr A ID {
            secure(asprintf(&$$, "\tvalori %s\n%s\tswap\n\tasigna\n", $4, $2));
            free($2); free($4);
         }
       ;

/* aritmetica */
aritmetica: 
    SUMA expr A ID {
        /* valord ID, expr, add, valori ID, swap, asigna */
        secure(asprintf(&$$, "\tvalord %s\n%s\tadd\n\tvalori %s\n\tswap\n\tasigna\n", $4, $2, $4));
        free($2); free($4);
    }
    | RESTA expr DE ID {
        /* valord ID, expr, swap, sub, valori ID, swap, asigna */
        secure(asprintf(&$$, "\tvalord %s\n%s\tswap\n\tsub\n\tvalori %s\n\tswap\n\tasigna\n", $4, $2, $4));
        free($2); free($4);
    }
    | MULTIPLICA expr POR expr DANDO ID {
        /* expr1, expr2, mul, valori ID, swap, asigna */
        secure(asprintf(&$$, "%s%s\tmul\n\tvalori %s\n\tswap\n\tasigna\n", $2, $4, $6));
        free($2); free($4); free($6);
    }
    | DIVIDE expr ENTRE expr DANDO ID {
        /* expr1, expr2, div, valori ID, swap, asigna */
        secure(asprintf(&$$, "%s%s\tdiv\n\tvalori %s\n\tswap\n\tasigna\n", $2, $4, $6));
        free($2); free($4); free($6);
    }
    ;

/* Expresiones matemáticas  */
expr: expr '+' expr { secure(asprintf(&$$, "%s%s\tadd\n", $1, $3)); free($1); free($3); }
    | expr '-' expr { secure(asprintf(&$$, "%s%s\tsub\n", $1, $3)); free($1); free($3); }
    | expr '*' expr { secure(asprintf(&$$, "%s%s\tmul\n", $1, $3)); free($1); free($3); }
    | expr '/' expr { secure(asprintf(&$$, "%s%s\tdiv\n", $1, $3)); free($1); free($3); }
    | '(' expr ')'  { $$ = $2; }
    | NUM           { secure(asprintf(&$$, "\tmete %d\n", $1)); }
    | ID            { secure(asprintf(&$$, "\tvalord %s\n", $1)); free($1); }
    ;

/* Lógica de E/S */
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