# Contenido

Encontraras los siguientes dos ejercicios que hacen uso de las interrupciones mostradas posteriormente:

**1.- contarPlabras:** Recopila la información digitada para almacenarla en un archivo, recuperarla del archivo creado para leer y contar el número de palabras ingresadas.

**2.- obtenerPromedio:** Admite ingresar números de 1 cifra para calcular media aritmética, moda y mediana junto con la creación de una carpeta y nombre de archivo personalizado donde son plasmados todos los resultados.

# Interrupciones

**Int 21h (39h ah):** Crea un directorio (carpeta) en DX es indicada la dirección terminada con un carácter nulo.

**Int 21h (3Ah ah):** Elimina un directorio (carpeta) en DX es indicada a dirección terminada con un carácter no, es indispensable erradicar todos los archivos contenidos.

**Int 21h (3Ch ah):** Crea un archivo en la cadena de caracteres alojada en DX, dicha cadena debe terminar con un carácter nulo, para indicar el fin de la dirección, CX permite especificar propiedades del archivo, al llamarse la interrupción retorna en AX el handle (manejador), identificador único que permite administrar archivos.

**Int 21h (3Dh ah):** Abre un documento, en AL se especifica el modo de lectura, escritura o ambos, DX es empleado para cargar la dirección en memoria del string contenedor de la ruta terminado en un carácter nulo, AX retornara el handle (manejador).

**Int 21h (3Eh ah):** Cierra el archivo y sus punteros de lectura o escritura de un archivo (necesario para eliminarlo) en BX es necesario alojar el handle (manejador) brindado por el archivo al crearse o ser abierto.

**Int 21h (3Fh ah):** Lectura de fichero, BX es alojado el handle (manejador), CX la cantidad de bytes de lectura y en DX el destino para almacenar los bytes leídos.)

**Int 21h (40h ah):** Escritura de fichero, BX es alojado el handle (manejador), CX la cantidad de bytes a escribir y en DX el origen de los bytes a transferir.

**Int 21h (41h ah):** Borra un documento, DX es especificada la dirección, es indispensable cerrar todos los punteros de lectura o escritura asociados al manejador del archivo.

**Int 21h (42h ah):** Especifica el redireccionamiento del puntero de escritura o lectura, BX requiere el handle (manejador) y mediante CX y DX la posición deseada en CX la parte más significativa y en DX la menor. 

> [!IMPORTANT]
> **Video Explicativo:** PENDIENTE
