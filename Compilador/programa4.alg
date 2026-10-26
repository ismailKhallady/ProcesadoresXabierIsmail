algoritmo completo;
  tipo
    vector = tabla[1..10] de entero;
    punto = tupla cx: real; cy: real; ftupla;
    letra = "a".."z";
    pentero = ref entero;
  ftipo;
  const MAX = 10; NOMBRE = 'hola'; BANDERA = verdadero; fconst;
  accion incr(e/s v: entero; ent d: entero;);
    v := v + d
  faccion
  funcion doble(n: entero;) dev entero;
    var r: entero; fvar;
    r := n * 2
  dev r ffuncion
  ent n: entero;
  sal s: entero;
{Prec: n >= 0}
  var v: vector; p: punto; q: pentero; i: entero; b: booleano; fvar;
  { comentario informativo }
  s := 0;
  para i := 1 hasta n hacer
    v[i] := doble(i);
    s := s + v[i] mod MAX
  fpara;
  p.cx := -3.5 * 2r;
  q ref := s;
  b := no (s < 3) y n <> 0 o falso;
  incr(s, 1);
  si b -> continuar [] no b -> s := -s fsi
{Post: s = algo}
falgoritmo.
