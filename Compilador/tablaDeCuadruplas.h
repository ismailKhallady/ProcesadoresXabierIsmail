#ifndef TABLA_DE_CUADRUPLAS_H
#define TABLA_DE_CUADRUPLAS_H

#include "tablaDeSimbolos.h"
#define MAX_CUADRUPLAS 1000

typedef enum nombreDeOperadorT {
	SUMA_ENTERA,
    SUMA_REAL,
	RESTA_ENTERA,
    RESTA_REAL,
	MULT_ENTERA,
    MULT_REAL,
    DIVISION_ENTERA,
    DIVISION_REAL,
    MENOS_ENTERO,
    MENOS_REAL,
    INTTOREAL,
    MODULO,
    ASIGNACION,
} NombreDeOperadorT;

typedef struct {
    NombreDeOperadorT operador;
    int argumento1;
    int argumento2;
    int resultado;
} Cuadrupla;

typedef struct {
    int place; //E.place
    NombreDeTipoT type; //E.type
    void *verdadero;
    void *falso;
} atributoExpresion;

void gen(NombreDeOperadorT operador, int argumento1, int argumento2, int resultado);
void imprimirCuadruplas(void);

#endif // TABLA_DE_CUADRUPLAS_H

