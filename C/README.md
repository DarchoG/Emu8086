# **Funcionamiento**

Determina si el número ingresado es primo.

**1.-** El número es leído por las funciones estándares de C, posteriormente se declara la función contenedora de la implementación en assembly.

**2.-** El algoritmo empleado en ensamblador divide todos los números inferiores al ingresado empezando por el 2, si es detectado residuo 0 significa que el número es divisible por otro, por lo tanto, se cancela el bucle y es indicado que el número no es primo, en caso contrario al llegar a su mismo valor connota que solo es divisible por el mismo y 1, satisfaciendo la definición de número primo.

- **2.1.-** Es cargado en memoria el parámetro que contiene nuestro número en eax e inicializamos ebx en 2 para dividir subsecuentemente sobre este mismo y los casos bases.

- **2.2.-** Guardamos un respaldo del valor en eax o cargado, ya que la operación div altera los registros ax y dx.

  - **2.2.1.-** La operación div espera como divisor el registro donde se llama la operación y el dividendo el registro ax, actualiza ax con el respectivo numerador y dx con residuo.

- **2.3.-** Comparamos si el residuo es igual a 0, en dado caso el dato es divisible y no es un número primo, en caso contrario volvemos a restaurar el dividendo e incrementamos para iterar el siguiente criterio de divisibilidad, es importante limpiar el registro dx contenedor del residuo de la división anterior ya que podría suscitarnos resultados inesperados al tenerlo contemplado en la siguiendo división.

- **2.4.-** En caso de arribar al número retornar como primo.

**3.-** En orden para almacenar el output de la función en ensamblador es requerido indicar al final las variables de entrada y salida, así como los registros afectados.

Es susceptible de mejorar la complejidad del algoritmo al realizar una criba de Eratóstenes e iterar en los primos hasta superar el rango deseado.

# **Sintaxis**

Respecto al microprocesador Intel 8086 disponemos de acceso a registros de una cantidad ascendente de bits denotados con la letra e, y r en 64 bits, la lectura se realiza de izquierda a derecha al igual que su asignación, por lo tanto, debemos de escribirlas de manera inversa.

Los movimientos y operaciones generales tienen una l adicional y doble %% para acceder a los registros, además de incluir “;” al finalizar la escritura de cada una de las líneas, la línea volatile antes del ensamblador indica que las variables cambian respecto a la ejecución del programa, lo cual nos podría servir para evitar errores.

Para indicar las variables de salida es colocado un =r donde considera que el resultado debe estar presente en un registro y m de salida al considerarlo como una referencia a memoria.
