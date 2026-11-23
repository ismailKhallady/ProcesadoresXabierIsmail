#ifndef TABLA_DE_SIMBOLOS_H
#define TABLA_DE_SIMBOLOS_H

#define MAX_SIMBOLOS 1000
#define MAX_NOMBRE 100
#define MAX_IDS 100

typedef enum nombreDeTipoT {
	BOOLEANO,
	CADENA,
	CARACTER,
	ENTERO,
	REAL
} NombreDeTipoT;

typedef struct {
    char *nombres[MAX_IDS];
    int   n;
} listaNombres;

typedef struct {
    char *nombre;
    NombreDeTipoT tipo;
} Simbolo;

int buscar(char *nombre);
void insertar(char *nombre, NombreDeTipoT tipo);
void imprimir(void);

#endif