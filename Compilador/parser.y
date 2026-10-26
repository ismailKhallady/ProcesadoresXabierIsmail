 //Archivo: parser.y
 // Parser de ProAlg (Practica 2). PASO 1: solo la gramatica.
 // De momento comprueba la sintaxis de un programa y dice si es correcto o en
 // que linea esta el primer error. En los pasos siguientes se anadiran la tabla
 // de simbolos, la tabla de cuadruplas y las rutinas semanticas.
 // Autores: Ismail Khallady Echarte, Xabier Villegas Remirez

 //PARTE 1: ZONA DE DECLARACIONES
 //PARTE 1.1: Cosas que necesitamos que esten en el .c
%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex(void);             // La crea flex a partir de scanner.l
	void yyerror(const char *);  // Bison la llama cuando ve un error
	extern FILE* yyin;           // Fichero del que lee el scanner
	extern int yylineno;         // Linea actual (opcion yylineno de flex)
%}

 // Mensajes de error que dicen que token se esperaba
%define parse.error verbose

 //PARTE 1.2: Tipos de los valores que el scanner deja en yylval
%union{
	char * cadena;    // identificadores y literales cadena
	int entero;       // literales enteros
	float real;       // literales reales
	char caracter;    // literales caracter
}

 //PARTE 1.3: Tokens. Los multivaluados llevan entre <> el campo del %union
 // Palabras reservadas
%token accionTK algoritmoTK booleanoTK cadenaTK caracterTK constTK continuarTK
%token deTK devTK divTK entTK enteroTK esTK faccionTK falgoritmoTK falsoTK
%token fconstTK ffuncionTK fmientrasTK fparaTK fsiTK ftipoTK ftuplaTK funcionTK
%token fvarTK hacerTK hastaTK mientrasTK modTK noTK oTK paraTK realTK refTK
%token salTK siTK tablaTK tipoTK tuplaTK varTK verdaderoTK yTK
 // Comentarios con significado sintactico
%token precondicionTK postcondicionTK
 // Identificadores y literales
%token <cadena>   identificadorTK
%token <entero>   literalEnteroTK
%token <real>     literalRealTK
%token <caracter> literalCaracterTK
%token <cadena>   literalCadenaTK
 // Operadores y simbolos
%token asignacionTK subrangoTK entoncesTK sinoSiTK
%token menorTK mayorTK igualTK menorIgualTK mayorIgualTK distintoTK
%token masTK menosTK porTK divRealTK
%token parIzqTK parDerTK corchIzqTK corchDerTK
%token comaTK puntoYComaTK puntoTK dosPuntosTK

 //PARTE 1.4: Prioridades y asociatividades (de menos a mas prioritario).
 // Resuelven los conflictos de la gramatica de expresiones, que es ambigua.
%left oTK
%left yTK
%right noTK
%nonassoc igualTK distintoTK menorTK mayorTK menorIgualTK mayorIgualTK
%left masTK menosTK
%left porTK divRealTK divTK modTK
%right UNARIO                       // - y + unarios (se usa con %prec)
%left puntoTK corchIzqTK refTK      // acceso a campo, a tabla y desreferencia

%start descAlgoritmo

%%

 /* ===================== 4.1 PROGRAMA ===================== */

descAlgoritmo
	: algoritmoTK identificadorTK puntoYComaTK cabeceraAlg bloqueAlg falgoritmoTK puntoTK
	;
cabeceraAlg
	: declGlobales declAF declEntSal precondicionTK
	;
bloqueAlg
	: bloque postcondicionTK
	;
declGlobales
	: declaracionTipo declGlobales
	| declaracionConst declGlobales
	| /* vacio */
	;
declAF
	: accionD declAF
	| funcionD declAF
	| /* vacio */
	;
bloque
	: declaraciones instrucciones
	;
declaraciones
	: declaracionTipo declaraciones
	| declaracionConst declaraciones
	| declaracionVar declaraciones
	| /* vacio */
	;

 /* ===================== 4.1.1 DECLARACIONES ===================== */

/* El enunciado pone un ; despues de ftipo, fconst y fvar, pero sus ejemplos no
 * lo ponen. Lo dejamos opcional (finDecl). */
declaracionTipo
	: tipoTK listaDTipo ftipoTK finDecl
	;
declaracionConst
	: constTK listaDCte fconstTK finDecl
	;
declaracionVar
	: varTK listaDVar fvarTK finDecl
	;
finDecl
	: puntoYComaTK
	| /* vacio */
	;

 /* 4.1.2 Tipos */
listaDTipo
	: identificadorTK igualTK dTipo puntoYComaTK listaDTipo
	| /* vacio */
	;
dTipo
	: tuplaTK listaCampos ftuplaTK
	| tablaTK corchIzqTK expresion subrangoTK expresion corchDerTK deTK dTipo
	| identificadorTK
	| expresion subrangoTK expresion
	| refTK dTipo
	| tipoBase
	;
tipoBase
	: enteroTK
	| booleanoTK
	| caracterTK
	| realTK
	| cadenaTK
	;
listaCampos
	: identificadorTK dosPuntosTK dTipo puntoYComaTK listaCampos
	| /* vacio */
	;

 /* 4.1.3 Constantes y variables */
listaDCte
	: identificadorTK igualTK literal puntoYComaTK listaDCte
	| /* vacio */
	;
literal
	: literalEnteroTK
	| literalRealTK
	| literalCaracterTK
	| literalCadenaTK
	| verdaderoTK
	| falsoTK
	;
listaDVar
	: listaId dosPuntosTK dTipo puntoYComaTK listaDVar
	| /* vacio */
	;
listaId
	: identificadorTK comaTK listaId
	| identificadorTK
	;
declEntSal
	: declEnt
	| declEnt declSal
	| declSal
	;
declEnt
	: entTK listaDVar
	;
declSal
	: salTK listaDVar
	;

 /* ===================== 4.1.4 EXPRESIONES =====================
  * El enunciado separa exp_a (aritmeticas) y exp_b (booleanas), pero las dos
  * pueden ser un "operando", asi que al ver una variable el parser no sabria
  * si reducir a exp_a o a exp_b (conflicto reduce/reduce). Las unimos en una
  * sola "expresion" y dejamos que la comprobacion de tipos (paso 2) decida si
  * una expresion es numerica o booleana. */
expresion
	: expresion masTK expresion
	| expresion menosTK expresion
	| expresion porTK expresion
	| expresion divRealTK expresion
	| expresion divTK expresion
	| expresion modTK expresion
	| menosTK expresion %prec UNARIO
	| masTK expresion %prec UNARIO
	| expresion yTK expresion
	| expresion oTK expresion
	| noTK expresion
	| expresion oprel expresion %prec igualTK
	| parIzqTK expresion parDerTK
	| operando
	| literal
	| funcionLl
	;
oprel
	: menorTK | mayorTK | igualTK | menorIgualTK | mayorIgualTK | distintoTK
	;
operando
	: identificadorTK
	| operando puntoTK identificadorTK
	| operando corchIzqTK expresion corchDerTK
	| operando refTK
	;

 /* ===================== 4.1.5 INSTRUCCIONES ===================== */

 /* El ; separa instrucciones. Aceptamos ademas un ; final opcional, porque el
  * Ejemplo 3 del enunciado pone "fmientras;" justo antes de la postcondicion. */
instrucciones
	: listaInstrucciones
	| listaInstrucciones puntoYComaTK
	;
listaInstrucciones
	: listaInstrucciones puntoYComaTK instruccion
	| instruccion
	;
instruccion
	: continuarTK
	| asignacion
	| alternativa
	| iteracion
	| accionLl
	;
asignacion
	: operando asignacionTK expresion
	;
alternativa
	: siTK expresion entoncesTK instrucciones listaOpciones fsiTK
	;
listaOpciones
	: sinoSiTK expresion entoncesTK instrucciones listaOpciones
	| /* vacio */
	;
iteracion
	: itCotaFija
	| itCotaExp
	;
itCotaExp
	: mientrasTK expresion hacerTK instrucciones fmientrasTK
	;
itCotaFija
	: paraTK identificadorTK asignacionTK expresion hastaTK expresion hacerTK instrucciones fparaTK
	;

 /* ===================== 4.1.6 ACCIONES Y FUNCIONES ===================== */

accionD
	: accionTK aCabecera bloque faccionTK
	;
funcionD
	: funcionTK fCabecera bloque devTK expresion ffuncionTK
	;
aCabecera
	: identificadorTK parIzqTK dParForm parDerTK puntoYComaTK
	;
fCabecera
	: identificadorTK parIzqTK listaDVar parDerTK devTK dTipo puntoYComaTK
	;
dParForm
	: dPForm puntoYComaTK dParForm
	| /* vacio */
	;
dPForm
	: entTK listaId dosPuntosTK dTipo
	| salTK listaId dosPuntosTK dTipo
	| esTK listaId dosPuntosTK dTipo
	;
accionLl
	: identificadorTK parIzqTK lLl parDerTK
	;
funcionLl
	: identificadorTK parIzqTK lLl parDerTK
	;
lLl
	: expresion comaTK lLl
	| expresion
	;

%%

int main(int argc, char **argv){
	if (argc > 1) {
		if ((yyin = fopen(argv[1], "r")) == NULL) {
			printf("No se puede abrir el fichero %s\n", argv[1]);
			return EXIT_FAILURE;
		}
	} else
		yyin = stdin;
	if (yyparse() == 0) {
		printf("COMPILADOR: el programa es sintacticamente correcto\n");
		return EXIT_SUCCESS;
	}
	return EXIT_FAILURE;
}

void yyerror(const char * s){
	printf("\tPARSER: ERROR en la linea %d: %s\n", yylineno, s);
}
