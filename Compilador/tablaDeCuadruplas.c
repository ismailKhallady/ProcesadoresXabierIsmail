#include <stdio.h>
#include "tablaDeCuadruplas.h"

static Cuadrupla tabla[MAX_CUADRUPLAS];
static int nextquad = 0;

void gen(NombreDeOperadorT operador, int argumento1, int argumento2, int resultado) {
    if (nextquad < MAX_CUADRUPLAS) {
        tabla[nextquad].operador = operador;
        tabla[nextquad].argumento1 = argumento1;
        tabla[nextquad].argumento2 = argumento2;
        tabla[nextquad].resultado = resultado;
        nextquad++;
    } else {
        printf("Error: Se ha alcanzado el límite máximo de cuadruplas.\n");
    }
}

void imprimirCuadruplas(void) {
    const char *nombreOperador[] = {
        "+int", "+real", "-int", "-real", "*int", "*real", "div", "/", "-int", "-real", "intToReal", "mod", ":="
    };

    printf("Tabla de Cuádruplas:\n");
    for (int i = 0; i < nextquad; i++) {
        Cuadrupla c = tabla[i];
        switch (c.operador) {
            case ASIGNACION:
            printf("%d %d := %d\n", i + 1, c.resultado, c.argumento1);
                break;
            case INTTOREAL:
            case MENOS_ENTERO:
            case MENOS_REAL:
                printf("%d %d := %s %d\n", i + 1, c.resultado, nombreOperador[c.operador], c.argumento1);
                break;
            
            default:
                printf("%d %d := %d %s %d\n", i + 1, c.resultado, c.argumento1, nombreOperador[c.operador], c.argumento2);
                break;
        }
    }
}