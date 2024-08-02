.model small ; Proporciona la cantidad y longitud de segmentos de codigo y datos disponiles.

.stack 100h ; Pila de datos, permite el respaldo de datos y el return de los procedimientos. 

.data ; Declaracion del segmento de datos.

    string db "Hello World", "$" ; Las variables necesitan disponer de un "$" al final para ser mostradas en pantalla con la interrupcion.

.code
    
    ; Indicamos al registro de datos el inicio del segmento de datos, fundamental para poder hacer uso de las variables declaradas
    
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    mov dx, offset(string) ; Carga la direccion en memoria de la variable string ubicada en el segmento de datos
    int 21h
    
    mov ah, 04ch ; Terminar ejecucion
    int 21h
   
end code
