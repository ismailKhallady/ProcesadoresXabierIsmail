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

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
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
    accionTK = 258,                /* accionTK  */
    algoritmoTK = 259,             /* algoritmoTK  */
    booleanoTK = 260,              /* booleanoTK  */
    cadenaTK = 261,                /* cadenaTK  */
    caracterTK = 262,              /* caracterTK  */
    constTK = 263,                 /* constTK  */
    continuarTK = 264,             /* continuarTK  */
    deTK = 265,                    /* deTK  */
    devTK = 266,                   /* devTK  */
    divTK = 267,                   /* divTK  */
    entTK = 268,                   /* entTK  */
    enteroTK = 269,                /* enteroTK  */
    esTK = 270,                    /* esTK  */
    faccionTK = 271,               /* faccionTK  */
    falgoritmoTK = 272,            /* falgoritmoTK  */
    falsoTK = 273,                 /* falsoTK  */
    fconstTK = 274,                /* fconstTK  */
    ffuncionTK = 275,              /* ffuncionTK  */
    fmientrasTK = 276,             /* fmientrasTK  */
    fparaTK = 277,                 /* fparaTK  */
    fsiTK = 278,                   /* fsiTK  */
    ftipoTK = 279,                 /* ftipoTK  */
    ftuplaTK = 280,                /* ftuplaTK  */
    funcionTK = 281,               /* funcionTK  */
    fvarTK = 282,                  /* fvarTK  */
    hacerTK = 283,                 /* hacerTK  */
    hastaTK = 284,                 /* hastaTK  */
    mientrasTK = 285,              /* mientrasTK  */
    modTK = 286,                   /* modTK  */
    noTK = 287,                    /* noTK  */
    oTK = 288,                     /* oTK  */
    paraTK = 289,                  /* paraTK  */
    realTK = 290,                  /* realTK  */
    refTK = 291,                   /* refTK  */
    salTK = 292,                   /* salTK  */
    siTK = 293,                    /* siTK  */
    tablaTK = 294,                 /* tablaTK  */
    tipoTK = 295,                  /* tipoTK  */
    tuplaTK = 296,                 /* tuplaTK  */
    varTK = 297,                   /* varTK  */
    verdaderoTK = 298,             /* verdaderoTK  */
    yTK = 299,                     /* yTK  */
    comentarioTK = 300,            /* comentarioTK  */
    identificadorTK = 301,         /* identificadorTK  */
    literalEnteroTK = 302,         /* literalEnteroTK  */
    literalRealTK = 303,           /* literalRealTK  */
    literalCaracterTK = 304,       /* literalCaracterTK  */
    literalCadenaTK = 305,         /* literalCadenaTK  */
    asignacionTK = 306,            /* asignacionTK  */
    subrangoTK = 307,              /* subrangoTK  */
    entoncesTK = 308,              /* entoncesTK  */
    sinoSiTK = 309,                /* sinoSiTK  */
    menorTK = 310,                 /* menorTK  */
    mayorTK = 311,                 /* mayorTK  */
    igualTK = 312,                 /* igualTK  */
    menorIgualTK = 313,            /* menorIgualTK  */
    mayorIgualTK = 314,            /* mayorIgualTK  */
    distintoTK = 315,              /* distintoTK  */
    masTK = 316,                   /* masTK  */
    menosTK = 317,                 /* menosTK  */
    porTK = 318,                   /* porTK  */
    divRealTK = 319,               /* divRealTK  */
    potenciaTK = 320,              /* potenciaTK  */
    parIzqTK = 321,                /* parIzqTK  */
    parDerTK = 322,                /* parDerTK  */
    corchIzqTK = 323,              /* corchIzqTK  */
    corchDerTK = 324,              /* corchDerTK  */
    comaTK = 325,                  /* comaTK  */
    puntoYComaTK = 326,            /* puntoYComaTK  */
    puntoTK = 327,                 /* puntoTK  */
    dosPuntosTK = 328,             /* dosPuntosTK  */
    UNARIO = 329                   /* UNARIO  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 22 "parser.y"

	char * cadena;    // identificadores y literales cadena
	int entero;       // literales enteros
	float real;       // literales reales
	char caracter;    // literales caracter

#line 145 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
