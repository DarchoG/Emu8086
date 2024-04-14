**--- Funcionamiento ---**

**1°-** Lee los caracteres ingresados en ASCII y los almacena en las variables primer y segundo número, permite únicamente el ingreso de datos validos comprendidos entre 0 y 9 con excepción del signo "-" para indicar resta exclusivamente en el primer ingreso, el string seguirá leyendo hasta detectar un carácter invalido.

**2°-** Imprime los valores ingresados a fin de validar el correcto almacenamiento de los mismos.

**3°-** Convierte los números ASCII a valores numéricos y los almacena en las mismas variables primer y segundo número.
   
**3.1°-** Aloja en memoria el carácter más significativo en cada iteración, lo multiplica por 10 y es sumado el siguiente valor.
   
**4°-** Carga en registros ambos números los suma y el resultado es colocado en la variable operacion.

**5°-** Los números son extraídos a cadenas de caracteres en ASCII en las mismas variables de primer y segundo número.

**5.1°-** La división euclídea permite extraer en cada iteración el último número o la unidad, para ello divide entre 10 el residuo es almacenada en la variable valor auxiliar en un arreglo, no obstante, el array generado se encuentra invertido.

**5.2°-** Se lee con dos punteros, uno al **final** de valor auxiliar (contenedor de mi división Euclidiana) y otro al **inicio** en operación que será el contenedor de mi resultado nuevo, en cada iteración se recorren ambos punteros hasta terminar su lectura en donde colocara el signo "$" para indicar el término del string al momento de imprimirlo a pantalla.

**--- Aprendizaje ---**

**Registros**

**• AX:** Acumulador, mediante este registro se ejecutan todas las operaciones básicas aritméticas, algunas requieren de carácter exclusivo realizarse mediante este registro multipropósito.

**- Mul:** Toma como parámetro un solo elemento y lo multiplica por el **contenido de ax**, el **excedente lo coloca en dx**, (Fue uno de los problemas iniciales, ya que usaba dx para guardar datos sin darme cuenta que era actualizado a 0h por no contener residuo).

**- Div:** Toma como parámetro un solo elemento y divide por el **contenido de ax**, el **cociente** permanece en **ax** y el **residuo** en **dx**, (Es importante no manipular el registro dx, ya que es susceptible de dar error a un error de overflow).

**• Di y Si:** Son los únicos que me permiten calcular y acceder por dirección mis variables, fueron empleados para iterar los strings, hacer uso de otros registros retornara error.

**• DS:** Data Segment, al declarar mi sección de variables necesito hacer uso de un registro para mover todas mis variables a memoria disponible a ser usada en mi programa.

**Interrupciones**

**Int 21h (01h Ah):** Lee un carácter, lo almacena en al.

**Int 21h (09h Ah):** Imprime string almacenado en dx.

**Int 21h (04ch Ah):** Termina el programa.

**Funciones**

**LEA:** Load Effective Address, carga la dirección en memoria de una variable.

**cmp:** Realiza una comparación, empleada para hacer uno de los siguientes saltos condicionales (Simulan IF)

**je:** Jump Equal, brincar si es igual.

**jne:** Jump Not Equal, brincar si no es igual.

**jl:** Jump If Less Than, brincar si es menor.

**jg:** Jump if Greater Than, brincar si es mayor.

**push:** Permite crear un duplicado de los valores de mis registros haciendo uso de mi stack (pila), es equivalente a un paso por valor en funciones parametrizadas en C.

**pop:** Retorna el valor almacenado con push.

**Video Explicativo:** https://youtu.be/FvSI5vadMdA
