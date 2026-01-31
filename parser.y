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
%token MUEVE A SUMA RESTA DE MULTIPLICA POR DIVIDE ENTRE DANDO CALCULA FIN_CALCULA 
%token SI ENTONCES SINO FIN_SI ES NO MAYOR MENOR QUE IGUAL
%token EJECUTA VECES HASTA FIN_EJECUTA LEE
%token <num> NUM
%token <string> ID CAD

/* He usado directivas de asociatividad para evitar
 que la gramática sea demasiado profunda y facilitar la concatenación de las instrucciones
 de la máquina de pila en una sola regla */
 
%left '+' '-'
%left '*' '/'

/* Tipos de los no terminales */
%type <string> axioma sentencias sentencia lista_literales literal expr asignar comparar condicion bucle leer

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
		 | comparar PUNTO { $$ = $1; }
		 | bucle PUNTO { $$ = $1; }
		 | leer PUNTO { $$ = $1; }
         ;
		 
		 
/* Solicitar un valor y asignarlo a la variable */
leer: LEE ID {
    secure(asprintf(&$$, "\tlee\n\tvalori %s\n\tswap\n\tasigna\n", $2));
    free($2);
}
;
		 
/* Estructura IF-THEN-ELSE */
comparar: SI condicion ENTONCES sentencias FIN_SI {
            char *l1 = new_label();
            secure(asprintf(&$$, "%s\tsifalsovea %s\n%s%s:\n", $2, l1, $4, l1));
            free($2); free($4); free(l1);
         }
         | SI condicion ENTONCES sentencias SINO sentencias FIN_SI {
            char *l1 = new_label();
            char *l2 = new_label();
            secure(asprintf(&$$, "%s\tsifalsovea %s\n%s\tvea %s\n%s:\n%s%s:\n", 
                            $2, l1, $4, l2, l1, $6, l2));
            free($2); free($4); free($6); free(l1); free(l2);
         }
         ;
		 
		 /* Lógica de bucles con etiquetas y saltos */
bucle: 
    EJECUTA sentencias HASTA QUE condicion FIN_EJECUTA {
        /* Bucle de post-condición, se ejecuta y luego comprueba si repite */
        char *l_inicio = new_label();
        secure(asprintf(&$$, "%s:\n%s%s\tsifalsovea %s\n", l_inicio, $2, $5, l_inicio));
        free($2); free($5); free(l_inicio);
    }
    | EJECUTA expr VECES sentencias FIN_EJECUTA {
        /* Bucle de conteo simple para la pila */
        char *l_inicio = new_label();
        char *l_fin = new_label();
        secure(asprintf(&$$, "%s\n%s:\n%s\tvea %s\n%s:\n", $2, l_inicio, $4, l_inicio, l_fin));
        free($2); free($4); free(l_inicio); free(l_fin);
    }
    ;
		 
		 /* Lógica de comparación */
condicion: expr ES MAYOR QUE expr {
            /* A > B es true si (A - B) > 0 */
            secure(asprintf(&$$, "%s%s\tsub\n", $1, $5));
            free($1); free($5);
         }
         | expr ES MENOR QUE expr {
            /* A < B es true si (B - A) > 0 */
            secure(asprintf(&$$, "%s%s\tswap\n\tsub\n", $1, $5));
            free($1); free($5);
         }
         | expr ES IGUAL A expr {
            /* A == B es true si NOT(A XOR B) */
            secure(asprintf(&$$, "%s%s\txor\n\tnot\n", $1, $5));
            free($1); free($5);
         }
		| expr ES NO IGUAL A expr {
			/* expr(1) ES(2) NO(3) IGUAL(4) A(5) expr(6) */
			secure(asprintf(&$$, "%s%s\txor\n", $1, $6));
			free($1); free($6);
		 }
         ;
		 
/* Cambios de valor */
asignar: 
    MUEVE expr A ID {
        /* valori ID, expr, swap, asigna */
        secure(asprintf(&$$, "\tvalori %s\n%s\tswap\n\tasigna\n", $4, $2));
        free($2); free($4);
    }
    | CALCULA ID '=' expr FIN_CALCULA {
        /* Lógica idéntica a MUEVE: ID ($2) y expr ($4) */
        secure(asprintf(&$$, "\tvalori %s\n%s\tswap\n\tasigna\n", $2, $4));
        free($2); free($4);
    }
    | SUMA expr A ID {
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