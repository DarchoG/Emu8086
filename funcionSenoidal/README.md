**Funcionamiento**

**1°.** Es activado el modo video.

**2°.** El array de datosSenoidal es recorrido como eje y, en cada iteración es incrementado en un valor el eje x.

**3°.** Al recorrerse por completo el array se restablece el puntero al inicio del arreglo y es reseteado por consiguiente toda la función para ciclarse infinitamente.

**4°.** En caso de excederse los 320x200 pixeles (300 horizontales) se restablece la pantalla.

**5°.** Si es detecta algún input del teclado el programa finaliza.

**Interrupciones**

**Int 10h:** Permite el modo video, en **al** se aloja las propiedades del mismo, al 13h brinda de una pantalla de 320x200 pixeles.
**Int 10h (0ch ah, Color al):** Emplea los registros CX y DX como ejes X y Y respectivamente a fin de imprimir un píxel del color alojado como valor numérico en AL.
**Int 10h (06h ah):** Restablece la pantalla.
**Int 16h (01 ah):** Solicita la lectura del teclado sin espera (Usada para romper el bucle).

**Funciones**

**jnz:** Jump if Not Zero, brinca si no es 0, comprueba el valor de la bandera ZF (Zero Flag).
**13:** En ASCII permite retornar el cursor al inicio, usado para imprimir el primer mensaje.
