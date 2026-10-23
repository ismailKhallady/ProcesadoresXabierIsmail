 //PARTE 1: ZONA DE DECLARACIONES
 //PARTE 1.1: Constantes manifiestas y codigo necesario para el .c que genera flex

%{
	// Headers standard necesarios
	#include <stdio.h> //Para poder escribir en el terminal
	#include <stdlib.h> //Para usar exit()
	#include <strings.h> //Para trabajar con cadenas de caracteres

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
eDR                 (?i:e)
yDR                 (?i:y)

literalBooleanoDR	{verdaderoDR}|{falsoDR}

literalCaracterDR	\".\"
literalCadenaDR		'([^']|\/')*'
comentarioDR		{llaveIzqDR}([^}]|\/{llaveDerDR})*{llaveDerDR}

signoDR 			[+-]
digitoDR 			[0-9]
literalEnteroDR		{signoDR}?{digitoDR}+([eE]{digitoDR}+)?
literalRealDR		{signoDR}?{digitoDR}+(.{digitoDR}+)?([eE]{digitoDR}+)?|{literalEnteroDR}[rR]
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
llaveIzqDR        \{
llaveDerDR        \}
comaDR            ,
puntoYComaDR      ;
puntoDR           \.
dosPuntosDR       :
igualDR           =
mayorDR           >
menorDR           <
potenciaDR        \^

%%

 /* PARTE 2: REGLAS LÉXICAS */

 /* 1. PALABRAS RESERVADAS */
{accionDR}          { printf("(accionTK, %s)\n", yytext); }
{algoritmoDR}       { printf("(algoritmoTK, %s)\n", yytext); }
{booleanoDR}        { printf("(booleanoTK, %s)\n", yytext); }
{cadenaDR}          { printf("(cadenaTK, %s)\n", yytext); }
{caracterDR}        { printf("(caracterTK, %s)\n", yytext); }
{constDR}           { printf("(constTK, %s)\n", yytext); }
{continuarDR}       { printf("(continuarTK, %s)\n", yytext); }
{deDR}              { printf("(deTK, %s)\n", yytext); }
{devDR}             { printf("(devTK, %s)\n", yytext); }
{divDR}             { printf("(divTK, %s)\n", yytext); }
{entDR}             { printf("(entTK, %s)\n", yytext); }
{enteroDR}          { printf("(enteroTK, %s)\n", yytext); }
{esDR}              { printf("(esTK, %s)\n", yytext); }
{faccionDR}         { printf("(faccionTK, %s)\n", yytext); }
{falgoritmoDR}      { printf("(falgoritmoTK, %s)\n", yytext); }
{fconstDR}          { printf("(fconstTK, %s)\n", yytext); }
{ffuncionDR}        { printf("(ffuncionTK, %s)\n", yytext); }
{fmientrasDR}       { printf("(fmientrasTK, %s)\n", yytext); }
{fparaDR}           { printf("(fparaTK, %s)\n", yytext); }
{fsiDR}             { printf("(fsiTK, %s)\n", yytext); }
{ftipoDR}           { printf("(ftipoTK, %s)\n", yytext); }
{ftuplaDR}          { printf("(ftuplaTK, %s)\n", yytext); }
{funcionDR}         { printf("(funcionTK, %s)\n", yytext); }
{fvarDR}            { printf("(fvarTK, %s)\n", yytext); }
{hacerDR}           { printf("(hacerTK, %s)\n", yytext); }
{hastaDR}           { printf("(hastaTK, %s)\n", yytext); }
{mientrasDR}        { printf("(mientrasTK, %s)\n", yytext); }
{modDR}             { printf("(modTK, %s)\n", yytext); }
{noDR}              { printf("(noTK, %s)\n", yytext); }
{oDR}               { printf("(oTK, %s)\n", yytext); }
{paraDR}            { printf("(paraTK, %s)\n", yytext); }
{realDR}            { printf("(realTK, %s)\n", yytext); }
{refDR}             { printf("(refTK, %s)\n", yytext); }
{salDR}             { printf("(salTK, %s)\n", yytext); }
{siDR}              { printf("(siTK, %s)\n", yytext); }
{tablaDR}           { printf("(tablaTK, %s)\n", yytext); }
{tipoDR}            { printf("(tipoTK, %s)\n", yytext); }
{tuplaDR}           { printf("(tuplaTK, %s)\n", yytext); }
{varDR}             { printf("(varTK, %s)\n", yytext); }
{eDR}               { printf("(eTK, %s)\n", yytext); }
{yDR}               { printf("(yTK, %s)\n", yytext); }


 /* 2. LITERALES BOOLEANOS Y OTROS LITERALES */
{literalEnteroDR}		{printf("(literalEnteroTK, %s)\n", yytext);}

{literalRealDR}	{
	char * cadena;
	if ((cadena = strndup(yytext, strlen(yytext))) == NULL)
		errorEnScanner("No hay memoria para strndup() al leer %s\n", yytext);
	else {
		printf("(literalRealTK, %s)\n", cadena);
		free(cadena); //Para no sobrecargar la memoria
	}
}

{literalBooleanoDR}		{printf("(literalBooleanoTK, %s)\n", yytext);}

{literalCaracterDR}		{printf("(literalCaracterTK, %c)\n", yytext[1]);}

{literalCadenaDR}		{printf("(literalCadenaTK, %s)\n", yytext);}

{comentarioDR}			{printf("(comentarioTK, %s)\n", yytext);}
{literalMayusculaDR}	{printf("(literalMayusculaTK, %s)\n", yytext);}

{literalMinusculaDR}	{printf("(literalMinusculaTK, %s)\n", yytext);}

 /* 3. IDENTIFICADORES (Reconoce cualquier palabra que no sea reservada) */
{identificadorDR}		{printf("(identificadorTK, %s)\n", yytext);}

 /* 4. OPERADORES Y SIMBOLOS */

{asignacionDR}    { printf("(asignacionTK, %s)\n", yytext); }
{subrangoDR}      { printf("(subrangoTK, %s)\n", yytext); }
{entoncesDR}      { printf("(entoncesTK, %s)\n", yytext); }
{sinoSiDR}        { printf("(sinoSiTK, %s)\n", yytext); }
{masDR}			  { printf("(sumaTK, %s)\n", yytext);}
{menosDR}         { printf("(restaTK, %s)\n", yytext); }
{porDR}           { printf("(multTK, %s)\n", yytext); }
{divRealDR}       { printf("(divRealTK, %s)\n", yytext); }
{parIzqDR}        { printf("(parIzqTK, %s)\n", yytext); }
{parDerDR}        { printf("(parDerTK, %s)\n", yytext); }
{corchIzqDR}      { printf("(corchIzqTK, %s)\n", yytext); }
{corchDerDR}      { printf("(corchDerTK, %s)\n", yytext); }
{llaveIzqDR}      { printf("(llaveIzqTK, %s)\n", yytext); }
{llaveDerDR}      { printf("(llaveDerTK, %s)\n", yytext); }
{comaDR}          { printf("(comaTK, %s)\n", yytext); }
{puntoYComaDR}    { printf("(puntoYComaTK, %s)\n", yytext); }
{puntoDR}         { printf("(puntoTK, %s)\n", yytext); }
{dosPuntosDR}     { printf("(dosPuntosTK, %s)\n", yytext); }
{igualDR}         { printf("(igualTK, %s)\n", yytext); }
{mayorDR}         { printf("(mayorTK, %s)\n", yytext); }
{menorDR}         { printf("(menorTK, %s)\n", yytext); }
{potenciaDR}      { printf("(potenciaTK, %s)\n", yytext); }

[ \t\r\n]+    { /* Ignorar espacios en blanco, tabuladores, retornos de carro y saltos de linea */ }

.	{ //Permite que el resto de caracteres no hagan echo
}

%%

 //PARTE 3: CODIGO ADICIONAL

void errorEnScanner(char* definicionDelError, char * variable){
	printf("\n\n\n\t%s %s \n", definicionDelError, variable);
	exit(EXIT_FAILURE);
}
