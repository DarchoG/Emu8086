**Funcionamiento**

**1°-** Es activado el modo video.

**2°-** Se alojan como puntos a graficar en CX y DX, las coordenadas correspondientes al eje X y Y respectivamente.

**2.1°-** Los datos almacenados en los arreglos fueron obtenidos por la formula paramétrica de la circunferencia, donde intervienen las funciones trigonométricas coseno y seno.

**3°-** Al detectar el final del arreglo borra la pantalla y es graficado nuevamente el circulo.

**3.1°-** El final del arreglo es detectado al ser agregado el número 255 en hexadecimal a uno de los arreglos, ya que es un valor que no se emplea para graficar.

**4°-** Se detiene el bucle al detectar cualquier tecla ingresada por el usuario mediante la interrupción 16h.

**Nota:** El archivo de Excel contiene los cálculos referentes las coordenadas empleadas para la representación de la circunferencia.
