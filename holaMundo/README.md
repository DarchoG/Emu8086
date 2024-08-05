# Funcionamiento

## Primer Ejemplo

Realiza un salto incondicional para omitir ejecutar las variables declaradas y generar errores, hace uso de la Int 21h 09h para mostrar el string.

## Segundo Ejemplo

**1.-** Indica el inicio del segmento de datos al registro de datos (DS).

**2.-** Ejecuta la Int 21h 09h para mostrar el mensaje.

**3.-** Emplea la Int 21h 04Ch finalizando el programa.

## Tercer Ejemplo

**1.-** Indica el inicio del segmento de datos al registro de datos (DS).

**2.-** Ejecuta el procedimiento bucleLectura para iterar, mostrar y almacenar datos ingresados por el teclado hasta detectar un enter o agotar el espacio en memoria.

**3.-** Define una macro donde es ejecutado una división entre 2 para verificar si la cantidad de letras ingresadas es par, checando el residuo y mostrando el resultado.

**4.-** Muestra los datos almacenados y hace uso de la macro.

**5.-** Finaliza el programa con la Int 21h 04Ch.

# Interrupciones

**Int 21h (01h AH):** Admite la lectura de un input del teclado, alojando el carácter en AL.

**Int 21h (09h AH):** Muestra una cadena de caracteres finalizada con “$”, necesita en DX tener alojada al dirección en memoria de la variable.

**Int 21h (04Ch AH):** Finaliza programa. 

> [!TIP]
> **Video Explicativo:** https://youtu.be/NA2v71g0Gwg
