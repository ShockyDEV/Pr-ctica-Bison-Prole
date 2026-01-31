/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    PROGRAMA = 258,                /* PROGRAMA  */
    INICIO = 259,                  /* INICIO  */
    FIN = 260,                     /* FIN  */
    PUNTO = 261,                   /* PUNTO  */
    COMA = 262,                    /* COMA  */
    MUESTRA = 263,                 /* MUESTRA  */
    MUEVE = 264,                   /* MUEVE  */
    A = 265,                       /* A  */
    SUMA = 266,                    /* SUMA  */
    RESTA = 267,                   /* RESTA  */
    DE = 268,                      /* DE  */
    MULTIPLICA = 269,              /* MULTIPLICA  */
    POR = 270,                     /* POR  */
    DIVIDE = 271,                  /* DIVIDE  */
    ENTRE = 272,                   /* ENTRE  */
    DANDO = 273,                   /* DANDO  */
    CALCULA = 274,                 /* CALCULA  */
    FIN_CALCULA = 275,             /* FIN_CALCULA  */
    SI = 276,                      /* SI  */
    ENTONCES = 277,                /* ENTONCES  */
    SINO = 278,                    /* SINO  */
    FIN_SI = 279,                  /* FIN_SI  */
    ES = 280,                      /* ES  */
    NO = 281,                      /* NO  */
    MAYOR = 282,                   /* MAYOR  */
    MENOR = 283,                   /* MENOR  */
    QUE = 284,                     /* QUE  */
    IGUAL = 285,                   /* IGUAL  */
    EJECUTA = 286,                 /* EJECUTA  */
    VECES = 287,                   /* VECES  */
    HASTA = 288,                   /* HASTA  */
    FIN_EJECUTA = 289,             /* FIN_EJECUTA  */
    LEE = 290,                     /* LEE  */
    NUM = 291,                     /* NUM  */
    ID = 292,                      /* ID  */
    CAD = 293                      /* CAD  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define PROGRAMA 258
#define INICIO 259
#define FIN 260
#define PUNTO 261
#define COMA 262
#define MUESTRA 263
#define MUEVE 264
#define A 265
#define SUMA 266
#define RESTA 267
#define DE 268
#define MULTIPLICA 269
#define POR 270
#define DIVIDE 271
#define ENTRE 272
#define DANDO 273
#define CALCULA 274
#define FIN_CALCULA 275
#define SI 276
#define ENTONCES 277
#define SINO 278
#define FIN_SI 279
#define ES 280
#define NO 281
#define MAYOR 282
#define MENOR 283
#define QUE 284
#define IGUAL 285
#define EJECUTA 286
#define VECES 287
#define HASTA 288
#define FIN_EJECUTA 289
#define LEE 290
#define NUM 291
#define ID 292
#define CAD 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 19 "parser.y"

    int num;
    char *string;

#line 148 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
