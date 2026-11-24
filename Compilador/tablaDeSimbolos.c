#include <stdio.h>
#include <string.h>
#include "tablaDeSimbolos.h"

static Simbolo tabla[MAX_SIMBOLOS];
static int numSimbolos = 0;

int insertar(char *nombre, NombreDeTipoT tipo) {
    if(buscar(nombre) == -1) { // Verifica si el símbolo ya existe
        tabla[numSimbolos].tipo = tipo;
        tabla[numSimbolos].nombre = nombre;
        numSimbolos++;
    } else {
        printf("AVISO: El símbolo '%s' ya existe en la tabla de símbolos.\n", nombre);
    }
    return numSimbolos - 1; // Retorna el índice del símbolo insertado o existente
}

void imprimir(void) {
    const char *nombreTipo[] = {"BOOLEANO", "CADENA", "CARACTER", "ENTERO", "REAL"};
    
    printf("Tabla de Símbolos:\n");
    for(int i = 0; i < numSimbolos; i++) {
        printf("Nombre: %s, Tipo: %s\n", tabla[i].nombre, nombreTipo[tabla[i].tipo]);
    }
}

int buscar(char *nombre) {
    for(int i = 0; i < numSimbolos; i++) {
        if(strcmp(tabla[i].nombre, nombre) == 0) {
            return i; // Retorna el índice del símbolo encontrado
        }
    }
    return -1; // Retorna -1 si no se encuentra el símbolo
}