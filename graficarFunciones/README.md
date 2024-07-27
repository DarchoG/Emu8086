# Funcionamiento

**1.-** Es mostrado un mensaje de navegación al leer un digito del teclado con echo (mostrado en pantalla) comprendido en los valores validos ejecuta la opción establecida brincando a la correspondiente etiqueta.

**2.-** Al ejecutar la opción correspondiente se mostrará en pantalla un mensaje único que indica el fin para detener el bucle necesario para graficar todos los puntos consecutivamente con el objetivo de retornar al menú principal.

**3.-** En cada uno de los bucles son cargados usando los registros source index (si), destination index (di), las coordenadas alojadas en unidades de memoria, es necesario hacer un desplazamiento en memoria por cada byte, siendo dos al tener arreglos de palabras (16 bits) presente en las coordenadas de la raíz cuadrada.

  - **3.1.-** Se emplea una variable que aloja la dimensión de los arrays haciendo uso de la palabra reservada EQU, es indispensable ser declarada en seguida del arreglo a medir, ya que contara los espacios de memoria empleados para denotar la equivalencia.

  - **3.2.-** En la interrupción para ejecutar el modo video es empleado una resolución de 320x200 pixeles además de un color blanco brillante, para limpiar la pantalla es empleada la misma interrupción.

4.- Las coordenadas son obtenidas en el Excel adjuntado, siguiendo las siguientes reglas:

- **Lineal:** Es agregado una pendiente equivalente a la división de 200/320 para adecuar la pendiente y tener una diagonal perfecta.
  
- **Cuadrática:** Es adicionado como pendiente arbitraria 5, con el objetivo de disponer una parábola más expendida, para obtener más coordenadas es empleada se calcularon las coordenadas haciendo uso de su función inversa.
  
- **Raíz:** Procedimiento equivalente con la cuadrática, es extendido hasta los 320 pixeles.
  
- **Senoidal:** Es evaluada la función con un valor constante que dictamina la frecuencia, posteriormente es multiplicado por 100 al retornar un valor que oscila entre 0 y 1 y sumado 100.
  
- **Circular:** Emplea las funciones coseno y seno asociadas a cada eje para obtener las coordenadas x, y, en seguida es multiplicado por el radio deseado y sumado valores absolutas para posicionar la circunferencia.

# Interrupciones

- **Int 10h (0h ah, 13 al):** Establece las características del display el digito almacenado en al, es decir colores y resolución.
- **Int 10h (0ch ah, 0Fh al):** Al encontrarse el display activo muestra un píxel con el color aojado en al.
- **Int 16h (01h ah):** Permite la lectura de un carácter del teclado sin interrumpir la ejecución del programa como la int 21h (01h ah).

**Video Explicativo:** https://youtu.be/bvrbGdGxBqU
