 //Archivo: scanner.l
 // Scanner de ProAlg para la Practica 2. Parte del scanner de la Practica 1, pero
 // en lugar de imprimir los tokens se los devuelve al parser (parser.y) con
 // "return", y deja el valor de los tokens multivaluados en yylval.
 // Autores: Ismail Khallady Echarte, Xabier Villegas Remirez

 //PARTE 1: ZONA DE DECLARACIONES
 //PARTE 1.1: Codigo necesario para el .c que genera flex

%{
	// Headers standard necesarios
	#include <stdio.h>  //Para poder escribir en el terminal
	#include <stdlib.h> //Para atoi(), atof() y exit()
	#include <string.h> //Para strdup()

	// Lo crea bison con la opcion -d. Contiene los codigos de los tokens y el
	// tipo de yylval (el %union de parser.y)
	#include "parser.tab.h"

	void errorEnScanner(char*, char*); //prototipo necesario para compilar
%}

 // Contamos lineas para poder decir en que linea esta un error
%option yylineno
 // Solo hay un fichero de entrada, no necesitamos yywrap()
%option noyywrap

 // PARTE 1.2: Zona de definiciones regulares

digitoDR			[0-9]
letraDR				[A-Za-z]
identificadorDR		{letraDR}({letraDR}|{digitoDR})*

 // Los literales numericos NO llevan signo: en "i -1" el scanner veria el
 // literal -1 y el parser recibiria "i" seguido de un literal, que es un error
 // sintactico. El signo lo trata la gramatica como operador unario.
literalEnteroDR		{digitoDR}+([eE]{digitoDR}+)?
literalRealDR		{digitoDR}+\.{digitoDR}+([eE]{digitoDR}+)?|{literalEnteroDR}[rR]
literalCaracterDR	\".\"
literalCadenaDR		'([^']|\/')*'

 // Comentarios: lo que hay entre llaves. Una } solo puede aparecer precedida de /
comentarioDR		\{([^}]|\/\})*\}

%%

 /* PARTE 2: REGLAS LEXICAS */

 /* 1. COMENTARIOS
  * La sintaxis exige dos comentarios (precondicion y postcondicion), pero los
  * comentarios informativos pueden ir en cualquier sitio. Decision del grupo:
  * los que empiezan por "{Prec" o "{Post" son tokens para el parser; el resto
  * se ignoran como si fueran espacios. */
\{[ \t\n]*(?i:prec)([^}]|\/\})*\}	{ return precondicionTK; }
\{[ \t\n]*(?i:post)([^}]|\/\})*\}	{ return postcondicionTK; }
{comentarioDR}						{ /* comentario informativo: se ignora */ }

 /* 2. PALABRAS RESERVADAS (insensibles a mayusculas/minusculas) */
(?i:accion)			{ return accionTK; }
(?i:algoritmo)		{ return algoritmoTK; }
(?i:booleano)		{ return booleanoTK; }
(?i:cadena)			{ return cadenaTK; }
(?i:caracter)		{ return caracterTK; }
(?i:const)			{ return constTK; }
(?i:continuar)		{ return continuarTK; }
(?i:de)				{ return deTK; }
(?i:dev)			{ return devTK; }
(?i:div)			{ return divTK; }
(?i:ent)			{ return entTK; }
(?i:entero)			{ return enteroTK; }
(?i:e\/s)			{ return esTK; }
(?i:faccion)		{ return faccionTK; }
(?i:falgoritmo)		{ return falgoritmoTK; }
(?i:falso)			{ return falsoTK; }
(?i:fconst)			{ return fconstTK; }
(?i:ffuncion)		{ return ffuncionTK; }
(?i:fmientras)		{ return fmientrasTK; }
(?i:fpara)			{ return fparaTK; }
(?i:fsi)			{ return fsiTK; }
(?i:ftipo)			{ return ftipoTK; }
(?i:ftupla)			{ return ftuplaTK; }
(?i:funcion)		{ return funcionTK; }
(?i:fvar)			{ return fvarTK; }
(?i:hacer)			{ return hacerTK; }
(?i:hasta)			{ return hastaTK; }
(?i:mientras)		{ return mientrasTK; }
(?i:mod)			{ return modTK; }
(?i:no)				{ return noTK; }
(?i:o)				{ return oTK; }
(?i:para)			{ return paraTK; }
(?i:real)			{ return realTK; }
(?i:ref)			{ return refTK; }
(?i:sal)			{ return salTK; }
(?i:si)				{ return siTK; }
(?i:tabla)			{ return tablaTK; }
(?i:tipo)			{ return tipoTK; }
(?i:tupla)			{ return tuplaTK; }
(?i:var)			{ return varTK; }
(?i:verdadero)		{ return verdaderoTK; }
(?i:y)				{ return yTK; }

 /* 3. LITERALES (multivaluados: su valor va en yylval, ya convertido a numero) */
{literalEnteroDR}	{ yylval.entero = (int) atof(yytext); return literalEnteroTK; }
{literalRealDR}		{ yylval.real = (float) atof(yytext); return literalRealTK; }
	/* atof() se para en la r de "3r", asi que no hace falta quitarla */
{literalCaracterDR}	{ yylval.caracter = yytext[1]; return literalCaracterTK; }
{literalCadenaDR}	{
	if ((yylval.cadena = strdup(yytext)) == NULL)
		errorEnScanner("No hay memoria para strdup() al leer", yytext);
	return literalCadenaTK;
}

 /* 4. IDENTIFICADORES (despues de las palabras reservadas: a igual longitud
  *    gana la regla que aparece antes) */
{identificadorDR}	{
	if ((yylval.cadena = strdup(yytext)) == NULL)
		errorEnScanner("No hay memoria para strdup() al leer", yytext);
	return identificadorTK;
}

 /* 5. OPERADORES Y SIMBOLOS */
":="		{ return asignacionTK; }
".."		{ return subrangoTK; }
"->"		{ return entoncesTK; }
"[]"		{ return sinoSiTK; }
"<="		{ return menorIgualTK; }
">="		{ return mayorIgualTK; }
"<>"		{ return distintoTK; }
"<"			{ return menorTK; }
">"			{ return mayorTK; }
"="			{ return igualTK; }
"+"			{ return masTK; }
"-"			{ return menosTK; }
"*"			{ return porTK; }
"/"			{ return divRealTK; }
"("			{ return parIzqTK; }
")"			{ return parDerTK; }
"["			{ return corchIzqTK; }
"]"			{ return corchDerTK; }
","			{ return comaTK; }
";"			{ return puntoYComaTK; }
"."			{ return puntoTK; }
":"			{ return dosPuntosTK; }

[ \t\r\n]+	{ /* Los espacios solo separan tokens */ }

.			{ errorEnScanner("Caracter no reconocido:", yytext); }

%%

 //PARTE 3: CODIGO ADICIONAL

void errorEnScanner(char* definicionDelError, char * variable){
	printf("\tSCANNER: ERROR en la linea %d. %s %s\n", yylineno, definicionDelError, variable);
	exit(EXIT_FAILURE);
}
