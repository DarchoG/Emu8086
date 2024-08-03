.model small ; Proporciona la cantidad y longitud de segmentos de codigo y datos disponiles.

.stack 100h ; Longitud de la pila de datos, permite el respaldo de datos y el return de los procedimientos. 

.data ; Declaracion del segmento de datos.

    ; Las variables string necesitan disponer de un "$" al final para ser mostradas en pantalla con la interrupcion.
    
    instruccion db "Escribe un mensaje a ser almacenado ", 13, 10, 10, "- ", "$"
    bufferEscritura db 256 dup ("$") ; Reservamos un arreglo de 256 posiciones para la escritura, en todas sus posiciones reservara el simbolo "$".
 
    cantidadDatos dw 0h ; Variable de 16 bits (palabra), por la declaracion "dw".
        
    retroalimentacion db 13, 10, 10, "Se ha registrado ", 13, 10, 10, "- ", "$"
    resultado db 13, 10, 10, "La cantidad de caracteres es ", "$"
    par db "par", "$"
    impar db "impar", "$"
    
.code

     ; Indicamos al registro de datos el inicio del segmento de datos, fundamental para poder hacer uso de las variables declaradas.

    mov ax, @data
    mov ds, ax
    
    ; Llamada a los procedimientos realizados.
    
    call bucleLectura
    call mostrarResultados
                     
    mov ax, 04ch ; Termina la ejecucion.
    int 21h
    
    ; Definicion de los procedimientos y macros (funciones).
    
    bucleLectura proc
               
        ; Respaldo de los registros en la pila para no alterar su valor correspondiente en la llamada.       
               
        push ax
        push si
        
        xor si, si ; Establecer el registro Source Index a 0.
        
        ; Interrupcion para imprimir un arreglo de caracteres.
        
        mov ah, 09h
        lea dx, instruccion
        int 21h
        
        cicloLectura: ; Definicion de una etiqueta para iterar bucles. 
            
            ; Lectura de un caracter con echo (mostrarlo en pantalla).
            ; El resultado del caracter es almacenado en al.
            
            mov ah, 01h
            int 21h
            
            cmp al, 0Dh ; Finalizar el bucle si es detectado un enter ASCII = 13, Hexadecimal = D.
            je finalizarCiclo ; JE = Jump Equal, saltar si es igual.
            
            mov bufferEscritura[si], al ; Alojar en la posicion SI el dato almacenado en la ejecucion.
            inc si ; Incrementar SI
            
            cmp si, 0FFh ; Finalizar el bucle si es leido 255 caracteres, evitar desbordamiento.
            je finalizarCiclo
            
            jmp cicloLectura ; Salto incondiconal.
                
        finalizarCiclo: 
        
            mov cantidadDatos, si ; Guardar la cantidad de datos ingresados en una variable.
            
            ; Recuperar el valor almacenado en la pila de datos, hacerlo de manera inversa a su ingreso en la pila.
            
            pop si
            pop ax
            
            ret ; Retornar
  
    bucleLectura endp
    
    paridad macro Cantidad ; Declaracion de un macro, es necesario ser definido previo su uso.
        
        push ax
        push bx
        push dx
            
        mov ax, Cantidad ; Dividiendo (Variable admitidada como parametro).
        mov bx, 02h ; Divisor
        xor dx, dx ; Limpiar DX, para evitar error por overflow.
        div bx ; Ejecuta la division de BX por AX, el numerador es alojado en AX y el residuo en DX.
        
        cmp dx, 01h ; Comparamos si el residuo es impar.
        je numeroImpar 
        
        ; Mostrar resultado par.
        
        mov ah, 09h
        mov dx, offset(par)
        int 21h 
        
        jmp finParidad ; Salto Incondiconal.
          
        numeroImpar:
        
            ; Mostrar resultado impar.
        
            mov ah, 09h
            mov dx, offset(impar)
            int 21h
        
        finParidad:
        
            pop dx
            pop bx
            pop ax
                 
    endm
    
    mostrarResultados proc
        
        push ax
        push dx
        
        ; Mostrar mensaje almacenado.
        
        mov ah, 09h
        lea dx, retroalimentacion 
        int 21h 
        
        mov ah, 09h
        lea dx, bufferEscritura
        int 21h
        
        mov ah, 09h
        lea dx, resultado
        int 21h
        
        ; Uso del macro, cantidadDatos es pasado como argumento.
        
        paridad cantidadDatos
        
        pop dx
        pop ax
        
        ret
        
    mostrarResultados endp

end code
