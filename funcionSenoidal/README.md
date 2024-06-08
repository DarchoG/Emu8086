# **Funcionamiento**

**1°.** Es activado el modo video.

**2°.** El array de datosSenoidal es recorrido como eje y, en cada iteración es incrementado en un valor el eje x.

**3°.** Al recorrerse por completo el array se restablece el puntero al inicio del arreglo y es reseteado por consiguiente toda la función para ciclarse infinitamente.

**4°.** En caso de excederse los 320x200 pixeles (300 horizontales) se restablece la pantalla.

**5°.** Si se detecta algún input del teclado el programa finaliza.

# **Interrupciones**

**Int 10h:** Permite el modo video, en **al** se aloja las propiedades del mismo, al 13h brinda de una pantalla de 320x200 pixeles.

**Int 10h (0ch ah, Color al):** Emplea los registros CX y DX como ejes X y Y respectivamente a fin de imprimir un píxel del color alojado como valor numérico en AL.

**Int 10h (06h ah):** Restablece la pantalla.

**Int 16h (01 ah):** Solicita la lectura del teclado sin espera (Usada para romper el bucle).

# **Funciones**

**jnz:** Jump if Not Zero, brinca si no es 0, comprueba el valor de la bandera ZF (Zero Flag).
**13:** En ASCII permite retornar el cursor al inicio, usado para imprimir el primer mensaje.

La función graficada corresponde a la senoidal obtenida por la subsecuente fórmula Y=100+100*SENO(2*PI()*(B2/C2)*A2), donde B2 = 200 y C2 = 10,000, retorna valores que oscilan entre 0 y 200. 

No obstante los pixeles son contados de la parte superior izquierda, por lo tanto es necesario en primera instancia calcular el **complemento a 200**, es decir la cantidad faltante para llegar a 200, el cual es límite de pantalla, obteniendo de tal manera mi **límite superior** y el **límite inferior** siendo conformados por los valores estándar retornados respecto a mi **eje central 100** por tener 200 píxeles verticales, el array datosSenoidal dispone los primeros 25 elementos de ambos límites (Disponibles en el Excel).
