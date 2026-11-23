#ifndef TABLA_DE_CUADRUPLAS_H
#define TABLA_DE_CUADRUPLAS_H

#define MAX_CUADRUPLAS 1000
#define MAX_OPERANDOS 3

typedef enum nombreDeOperadorT {
	SUMA,
	RESTA,
	MULTIPLICACION,
	DIVISION REAL,
    DIVISION ENTERA,
    MODULO,
    MENOS UNARIO,
    ASIGNACION,
} NombreDeOperadorT;

typedef struct {
    NombreDeOperadorT operador;
    int argumento1;
    int argumento2;
    int resultado;
} Cuadrupla;

void insertarCuadrupla(NombreDeOperadorT operador, int argumento1, int argumento2, int resultado);
void imprimirCuadruplas(void);

#endif // TABLA_DE_CUADRUPLAS_H

