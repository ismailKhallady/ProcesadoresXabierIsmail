#include <stdio.h>
#include <string.h>
#include "tablaDeSimbolos.h"

static Simbolo tabla[MAX_SIMBOLOS];
static int numSimbolos = 0;

void insertar(char *nombre, NombreDeTipoT tipo) {
    for(int i = 0; i < numSimbolos; i++) {
        if(strcmp(tabla[i].nombre, nombre) == 0) {
            printf("AVISO: El símbolo '%s' ya existe en la tabla de símbolos.\n", nombre);
            return;
        }
    }
    tabla[numSimbolos].tipo = tipo;
    tabla[numSimbolos].nombre = nombre;
    numSimbolos++;
}

void imprimir(void) {
    const char *nombreTipo[] = {"BOOLEANO", "CADENA", "CARACTER", "ENTERO", "REAL"};
    
    printf("Tabla de Símbolos:\n");
    for(int i = 0; i < numSimbolos; i++) {
        printf("Nombre: %s, Tipo: %s\n", tabla[i].nombre, nombreTipo[tabla[i].tipo]);
    }
}