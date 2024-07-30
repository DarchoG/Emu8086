# Funcionamiento

**1.-** Itera un bucle de lectura de datos numéricos, realiza una comprobación para verificar que el dato digitado sea un carácter numérico comprendido entre 0 y 9, consecuentemente es guardado en un array de datos, en caso de detectar un dato invalido es mostrado en pantalla, no obstante, no es guardado, consecuentemente es separado el output con una coma y espacio para enlistar de mejor manera. El bucle es detenido al detectar un enter o capturar 255 dígitos.

**2.-** Es ordenado el array de datos ingresados, necesario para obtener la mediana optando por el método de ordenamiento counting sort, debiado a los siguientes pasos y subsecuentes motivos.

## Counting Sort
Emplea arreglos temporales de datos, cuenta la frecuencia de los datos y relaciona su índice con su valor para acomodarlos sin necesidad de realizar operaciones.

### Procedimiento

 - **2.1.-** Utiliza un array con la dimensión máxima del elemento con mayor valor y es asignado un valor predefinido de 0 a todas las posiciones del array, en el ejemplo es declarado un arreglo de 10 espacios en memoria, ya que los datos ingresados comprenden entre 0 al 9.

  - **2.2.-** Son contado todos los elementos del arreglo a ordenar, al usar el valor numérico como índice e incrementado por uno, ejemplificando al leer el número 8 se accede a la posición 8 del array y es sumado un 1.

  - **2.3.-** Al concluir el conteo obtenemos la frecuencia de cada uno de los datos, el cual posteriormente se usará para calcular la moda, por tal motivo es creado un array auxiliar inicializado en 0, donde serán sumadas o acumuladas las frecuencias absolutas del paso previo, suponiendo tener un array de 3 elementos con una frecuencia absoluta de [1, 5, 3], el resultado esperado seria [1, 6, 9].

  - **2.4.-** Es ordenado el array, para esto se emplea otro array contenedor de los resultados y es leído nuevamente el arreglo original, recuperamos el valor y lo usaremos como índice en la tabla de frecuencias absolutas acumuladas para rescatar su valor, donde es vuelto a usar como índice, pero como lugar para posicionar el valor leído, restándole 1 previo a su asignación, a fin de tomar en consideración el 0, el proceso es repetido hasta iterar todos los elementos.

### Motivos

  - **1.-** Al aplicar conteo para determinar la posición de los elementos en el array ordenado, los datos recabados son empleados posteriormente para obtener la moda del set de datos.

  - **2.-** El ejercicio sitúa el uso de números enteros positivos con un rango mínimo conocido.

  - **3.- Complejidad:** O(N * M), N = Cantidad Elementos, M = Valor Máximo.

> [!WARNING]
>	Solo es aplicable para números naturales (enteros positivos), en caso de desear incorporar números negativos es necesario modificar la lógica, se torna demasiado ineficiente con números decimales debido a la enorme cantidad de datos representables en cada unidad.

**3.-** Obtiene el promedio al hacer la sumatoria de los datos y dividirlo por la cantidad ingresada, para obtener los números decimales de la división se adecua la siguiente macro, con el objetivo de reiterar su uso con la mediana.

  - **3.1.-** Es colocado en ax el número a dividir y en bx alojado la cantidad, al disponer un rango de número comprendidos entre 0 a 9, sabemos que en la primera división siempre obtendremos el número más significativo, alojándolo en la primera parte del string contenedor del resultado.

  - **3.2.-** Para obtener los decimales es asemejado al proceso normal de realizar una división con residuo, es multiplicado por 10 y vuelto a dividir hasta disponer 0 de residuo o tener 3 decimales extras de precisión, antes de la primera iteración es necesario direccionar dos unidades, para ubicarnos después del símbolo “.”  del array.

**4.-** Calcula la mediana del set de datos haciendo uso del arreglo ordenado en caso de ser impar es usado directamente el valor obtenido como numerador almacenado en ax de la división de paridad, para posteriormente brincar al final.

  - **4.1.-** Al ser una cantidad par es iterado el mismo proceso, aunque se suma el siguiente valor, para posteriormente llamar la macro explicada en el punto 3.

**5.-** Calcula la moda, para ello itera la lista de frecuencia y almacena el valor más alto no equivalente a 0 en la tabla de frecuencias obtenida en el método de ordenamiento, al identificar un valor más alto de moda es registrado en una variable y limpia todo el array que almacena los datos con moda común, en caso de presentar una frecuencia duplicada el digito es almacenado en la siguiente posición.

**6.-** Muestra en pantalla los resultados obtenidos y registra en un archivo con un nombre personalizado.

  - **6.1-** Itera un bucle de lectura de caracteres admitiendo solamente letras, al finalizar agrega la extensión y mediante un string adicional concatena el string contendor de la carpeta y el nombre personalizado digitado.

**7.-** Escribe en el archivo, la interrupción de escritura requiere disponer en cx la cantidad de bytes a leer y en dx el string, por ende el bucle es repetido por cada elemento donde es cargado en un array auxiliar el carácter deseado a almacenar hasta detectar el fin, es ciclado el mismo proceso con todos los resultados transferidos al archivo, excepto con la moda y los valores digitados, donde se incorporan una coma y espacio por elemento.

**8.-** Ejecuta un menú, determina si borra el archivo y carpeta creada.

> [!IMPORTANT]
> **Video Explicativo:** PENDIENTE
