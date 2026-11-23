 //PARTE 1: ZONA DE DECLARACIONES
 //PARTE 1.1: Constantes manifiestas y codigo necesario para el .c que genera flex

%{
	// Headers standard necesarios
	#include <stdio.h> //Para poder escribir en el terminal
	#include <stdlib.h> //Para usar exit()
	#include <string.h>

	#include "tablaDeSimbolos.h"
	#include "parser.tab.h"

	void errorEnScanner(char*, char*); //prototipo necesario para compilar

%}


 // PARTE 1.2: Zona de definiciones regulares

 /* PALABRAS RESERVADAS (Insensibles a mayúsculas/minúsculas) */
accionDR            (?i:accion)
algoritmoDR         (?i:algoritmo)
booleanoDR          (?i:booleano)
cadenaDR            (?i:cadena)
caracterDR          (?i:caracter)
constDR             (?i:const)
continuarDR         (?i:continuar)
deDR                (?i:de)
devDR               (?i:dev)
divDR               (?i:div)
entDR               (?i:ent)
enteroDR            (?i:entero)
esDR                (?i:e\/s)
faccionDR           (?i:faccion)
falgoritmoDR        (?i:falgoritmo)
falsoDR             (?i:falso)
fconstDR            (?i:fconst)
ffuncionDR          (?i:ffuncion)
fmientrasDR         (?i:fmientras)
fparaDR             (?i:fpara)
fsiDR               (?i:fsi)
ftipoDR             (?i:ftipo)
ftuplaDR            (?i:ftupla)
funcionDR           (?i:funcion)
fvarDR              (?i:fvar)
hacerDR             (?i:hacer)
hastaDR             (?i:hasta)
mientrasDR          (?i:mientras)
modDR               (?i:mod)
noDR                (?i:no)
oDR                 (?i:o)
paraDR              (?i:para)
realDR              (?i:real)
refDR               (?i:ref)
salDR               (?i:sal)
siDR                (?i:si)
tablaDR             (?i:tabla)
tipoDR              (?i:tipo)
tuplaDR             (?i:tupla)
varDR               (?i:var)
verdaderoDR         (?i:verdadero)
yDR                 (?i:y)


llaveIzqDR        \{
llaveDerDR        \}
literalCaracterDR	\".\"
literalCadenaDR		'([^']|\/')*'
comentarioDR		{llaveIzqDR}([^}]|\/{llaveDerDR})*{llaveDerDR}

signoDR 			[+-]
digitoDR 			[0-9]
literalEnteroDR		{digitoDR}+([eE]{digitoDR}+)?
literalRealDR		{digitoDR}+(\.{digitoDR}+)([eE]{digitoDR}+)?|{literalEnteroDR}[rR]
literalMayusculaDR	[A-Z]
literalMinusculaDR	[a-z]
letraDR				{literalMayusculaDR}|{literalMinusculaDR}
letraOcifraDR		{letraDR}|{digitoDR}
identificadorDR		{letraDR}{letraOcifraDR}*

/* OPERADORES */
asignacionDR        :=
subrangoDR          \.\.
entoncesDR          ->
sinoSiDR            \[\]
masDR             \+
menosDR           \-
porDR             \*
divRealDR         \/
parIzqDR          \(
parDerDR          \)
corchIzqDR        \[
corchDerDR        \]
comaDR            ,
puntoYComaDR      ;
puntoDR           \.
dosPuntosDR       :
igualDR           =
mayorDR           >
menorDR           <
potenciaDR        \^
menorIgualDR      <=
mayorIgualDR      >=
distintoDR        <>

%%

 /* PARTE 2: REGLAS LÉXICAS */

 /* 1. PALABRAS RESERVADAS */
{accionDR}          { return accionTK; }
{algoritmoDR}       { return algoritmoTK; }
{booleanoDR}        { return booleanoTK; }
{cadenaDR}          { return cadenaTK; }
{caracterDR}        { return caracterTK; }
{constDR}           { return constTK; }
{continuarDR}       { return continuarTK; }
{deDR}              { return deTK; }
{devDR}             { return devTK; }
{divDR}             { return divTK; }
{entDR}             { return entTK; }
{enteroDR}          { return enteroTK; }
{esDR}              { return esTK; }
{faccionDR}         { return faccionTK; }
{falgoritmoDR}      { return falgoritmoTK; }
{fconstDR}          { return fconstTK; }
{ffuncionDR}        { return ffuncionTK; }
{fmientrasDR}       { return fmientrasTK; }
{fparaDR}           { return fparaTK; }
{fsiDR}             { return fsiTK; }
{ftipoDR}           { return ftipoTK; }
{ftuplaDR}          { return ftuplaTK; }
{funcionDR}         { return funcionTK; }
{fvarDR}            { return fvarTK; }
{hacerDR}           { return hacerTK; }
{hastaDR}           { return hastaTK; }
{mientrasDR}        { return mientrasTK; }
{modDR}             { return modTK; }
{noDR}              { return noTK; }
{oDR}               { return oTK; }
{paraDR}            { return paraTK; }
{realDR}            { return realTK; }
{refDR}             { return refTK; }
{salDR}             { return salTK; }
{siDR}              { return siTK; }
{tablaDR}           { return tablaTK; }
{tipoDR}            { return tipoTK; }
{tuplaDR}           { return tuplaTK; }
{varDR}             { return varTK; }
{yDR}               { return yTK; }

 /* 2. LITERALES BOOLEANOS Y OTROS LITERALES */
{literalEnteroDR}		{ 
	yylval.entero = atof(yytext);
	return literalEnteroTK;
}

{literalRealDR}    {
    yylval.real = atof(yytext);
    return literalRealTK;
}

{verdaderoDR}		{ return verdaderoTK; }
{falsoDR}		{ return falsoTK; }

{literalCaracterDR}		{ return literalCaracterTK;}

{literalCadenaDR}		{ return literalCadenaTK;}

{comentarioDR}			{ return comentarioTK;}

 /* 3. IDENTIFICADORES (Reconoce cualquier palabra que no sea reservada) */
{identificadorDR}	{
	yylval.cadena = strdup(yytext);   
	if (yylval.cadena == NULL)
		errorEnScanner("No hay memoria para copiar el identificador", yytext);
	return identificadorTK;
}

 /* 4. OPERADORES Y SIMBOLOS */

{asignacionDR}    { return asignacionTK; }
{subrangoDR}      { return subrangoTK; }
{entoncesDR}      { return entoncesTK; }
{sinoSiDR}        { return sinoSiTK; }
{masDR}			  { return masTK;}
{menosDR}         { return menosTK; }
{porDR}           { return porTK; }
{divRealDR}       { return divRealTK; }
{parIzqDR}        { return parIzqTK; }
{parDerDR}        { return parDerTK; }
{corchIzqDR}      { return corchIzqTK; }
{corchDerDR}      { return corchDerTK; }
{comaDR}          { return comaTK; }
{puntoYComaDR}    { return puntoYComaTK; }
{puntoDR}         { return puntoTK; }
{dosPuntosDR}     { return dosPuntosTK; }
{igualDR}         { return igualTK; }
{mayorDR}         { return mayorTK; }
{menorDR}         { return menorTK; }
{menorIgualDR}         { return menorIgualTK; }
{mayorIgualDR}         { return mayorIgualTK; }
{distintoDR}         { return distintoTK; }
{potenciaDR}      { return potenciaTK; }

[ \t\r\n]+    { /* Ignorar espacios en blanco, tabuladores, retornos de carro y saltos de linea */ }

.	{ //Permite que el resto de caracteres no hagan echo
}

%%

 //PARTE 3: CODIGO ADICIONAL

void errorEnScanner(char* definicionDelError, char * variable){
	printf("\n\n\n\t%s %s \n", definicionDelError, variable);
	exit(EXIT_FAILURE);
}

int yywrap(){
    return 1;
}
