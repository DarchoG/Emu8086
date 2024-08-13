# Funcionamiento

**1.-** Crea y cierra el archivo.

**2.-** Habilita un bucle finito de lectura de caracteres del teclado hasta detectar un enter o un máximo de 255 caracteres.

**3.-** Se abre el archivo para escribir el string guardado en el bucle previo.

**4.-** Es restablecido el puntero del archivo, a fin de leer desde el inicio todo el contenido escrito, en caso contrario no obtendremos ningún dato en el buffer de lectura, ya que al finalizar su escritura el puntero está posicionado en la parte final, por ende, es necesario moverlo al inicio con la interrupción deseada o cerrar el archivo.

**5.-** Se procede con el conteo de palabras del string donde es incrementado el contador de palabras siempre y cuando se detecte un espacio asociado al valor 32 en ASCII y este encendida una variable auxiliar que es activada al detectar un carácter diferente al espacio.

**6.-** Es iterado un algoritmo para transformar de variable numérica a string una variable con el siguiente procedimiento:
  
  - **6.1.-** Con divisiones sucesivas de 10 es extraído el valor menos significativo del dato numérico y almacenado en un string. 
  
  - **6.2.-** Haciendo uso de un string auxiliar es invertido los caracteres registrados después de la división euclidiana del paso previo, para más detalles consultar el siguiente repositorio: https://github.com/DarchoG/Emu8086/tree/main/operacionNumeros 

**7.-** Muestra el resultado del conteo y desplegado un menú para determinar si es deseado borrar el archivo creado.

> [!TIP]
> **Video Explicativo:** https://youtu.be/t4CxbLSmj4o
