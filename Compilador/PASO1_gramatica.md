# Paso 1: la gramática de ProAlg en bison

En este paso el compilador **solo comprueba la sintaxis**: lee un `.alg` y dice si es correcto o en qué línea está el primer error. Todavía no hay tabla de símbolos ni cuádruplas (eso son los pasos 2 y 3).

## Cómo probarlo (Linux)

```
make            # bison + flex + gcc  ->  ./compilador
make pruebas    # pasa todos los programaX.alg
./compilador error1.alg   # ejemplo con un error a propósito
```

Resultado actual: programa1–4 correctos, `error1.alg` da `ERROR en la linea 4: syntax error, unexpected puntoYComaTK`. Bison informa de **0 conflictos** (se puede comprobar en `parser.output`, que lo genera la opción `-v`).

## Cómo cooperan scanner y parser

1. `bison -d parser.y` genera `parser.tab.c` (el parser) y `parser.tab.h`, que tiene un número para cada `%token` y el tipo de `yylval` (el `%union`).
2. `scanner.l` incluye `parser.tab.h`. Cada regla ya no hace `printf`, sino `return identificadorTK;` etc.
3. Para los tokens multivaluados el scanner deja el valor en `yylval` antes del `return` (por ejemplo, `yylval.entero = ...` para un literal entero). Los tipos están en el `%union` de `parser.y`, y cada token dice qué campo usa: `%token <entero> literalEnteroTK`.
4. El parser llama a `yylex()` cada vez que necesita un token.

## Cómo se ha pasado la gramática del enunciado a bison

El enunciado usa abreviaturas de expresiones regulares. Se reescriben como reglas BNF:

- `(A | B) X` se distribuye: `X : A X | B X | /* vacio */`.
- `ε` es una alternativa vacía, que en el fichero se marca con el comentario `/* vacio */`.
- Convención de nombres: las variables de la gramática están en *camelCase* (`declGlobales`) y los tokens acaban en `TK`.

## Decisiones que hemos tomado (y por qué)

Son cambios respecto al enunciado. El enunciado dice que el grupo debe decidir estas cosas, así que hay que anotarlas en el LEEME de la entrega.

1. **`exp_a` y `exp_b` se unen en una sola `expresion`.** Las dos pueden ser un `operando`. Al ver una variable, el parser no sabe si reducir a `exp_a` o a `exp_b` (conflicto reduce/reduce). Se unen y, en el paso 2, la comprobación de tipos decide si una expresión es numérica o booleana.
2. **La gramática de expresiones es ambigua** (`a + b * c` tiene dos árboles). No se reescribe con niveles (`termino`, `factor`…), sino que se usan prioridades de bison (de menos a más): `o` < `y` < `no` < relacionales < `+ -` < `* / div mod` < `-` y `+` unarios < `.`, `[ ]` y `ref`.
   - El `-` unario usa `%prec UNARIO` para tener más prioridad que el binario.
   - Los relacionales son `%nonassoc`, así que `a < b < c` es error.
3. **Los literales numéricos no llevan signo en el scanner.** Con signo, `m - i -1` se lee como `m`, `-`, `i`, `-1`, y el parser ve dos operandos seguidos. El signo lo trata la gramática como operador unario.
4. **Comentarios.** Los que empiezan por `{Prec` o `{Post` son tokens (`precondicionTK`, `postcondicionTK`), porque la sintaxis los exige. El resto son informativos y el scanner los ignora, así que pueden ir en cualquier parte.
5. **El `;` tras `ftipo`/`fconst`/`fvar` es opcional.** El enunciado lo pone en la gramática, pero sus ejemplos no.
6. **Se admite un `;` al final de las instrucciones**, como el `fmientras;` del Ejemplo 3 del enunciado.
7. **`operando.operando` se escribe `operando . identificador`.** Tras el punto siempre va el nombre de un campo.
8. **`expresion_t` es simplemente `expresion`**, porque el literal carácter ya es una expresión.

## Cambios en el scanner respecto a la Práctica 1

- Hace `return` de tokens en lugar de imprimir.
- Ya no existen `literalMayusculaTK`/`literalMinusculaTK`: `a` y `b` son identificadores.
- Se han añadido `<=`, `>=` y `<>`, y se ha escapado el `.` de los literales reales.
- Los números se pasan ya convertidos con `atof` (el enunciado pide números, no cadenas).
- `%option yylineno` sirve para dar la línea de los errores.
- Un carácter desconocido es un error (antes se ignoraba).

## Qué mirar para entenderlo

- `parser.output`: estados del autómata LALR. Busca un estado y verás los ítems con el punto (`•`), como en clase.
- Prueba a quitar la línea `%left porTK ...` y vuelve a hacer `make`: bison avisará de conflictos desplaza/reduce. Así se ve para qué sirven las prioridades.
- `bison -t` junto con `yydebug = 1` en el `main` muestra paso a paso los desplazamientos y reducciones.
