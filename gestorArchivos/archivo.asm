.model small

.stack 100h

.data

    direccion db "C:\emu8086\MyBuild\prueba.txt", 0
    manejador dw 0
    
    primerMensaje db "Se ha creado el archivo satisfactoriamente.", 13, 10, 10, "$"
    segundoMensaje db "Se ha abrierto el archivo exitosamente, AL contiene el handle o identificador unico del archivo", 13, 10, 10, "$"
    
    pausa db "Pulse cualquier tecla para continuar.", 13, 10, 10, "$" 
     
    inicioLectura db "Digite el mensaje deseado a almacenar en un archivo: ", 13, 10, 10, 9, "- ", "$"
    finalLectura db 13, 10, 10, "Se ha registrado el siguiente mensaje: ", 13, 10, 10, 9, "- ", "$"
    texto db 255 dup("$")
    longitudTexto dw 0h
     
    textoLeido db 255 dup ("$")
    numeroPalabras db 0h
    stringPalabras 3 dup("$")
       
.code
    
    mov ax, @data
    mov ds, ax
     
    call crearArchivo
    call lecturaString
    call abrirArchivo
    call escribirArchivo
    call lecturaArchivo
    ;call menu
   
    mov ax, 04ch
    int 21h
    
    crearArchivo proc
        
        push ax
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 3Ch 
        mov cx, 0h
        lea dx, direccion
        
        int 21h
        
        mov manejador, ax
        
        pop dx
        pop cx
        pop ax
        
        ret    
                  
    crearArchivo endp
    
    lecturaString proc
        
        push ax
        push si
                  
        xor ax, ax          
        xor si, si
        
        mov ah, 09h
        lea dx, inicioLectura
        int 21h
        
        xor ax, ax    
        
        leerCaracter:
        
            mov ah,01h
            int 21h
            
            cmp al, 0Dh
            je terminarLectura
            
            cmp si, 0FFh
            je terminarLectura
            
            mov texto[si], al
            inc si
            
            jmp leerCaracter
            
         terminarLectura:
         
            mov ah, 09h
            lea dx, finalLectura
            int 21h
            
            mov ah, 09h
            lea dx, texto
            int 21h
            
            mov longitudTexto, si
                
            pop si
            pop ax
            
            ret
            
    lecturaString endp
    
    abrirArchivo proc 
        
        push ax
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 3Dh
        mov al, 02h
        lea dx, direccion
        
        int 21h
        
        pop dx
        pop cx
        pop ax
        
        ret
          
    abrirArchivo endp
    
    escribirArchivo proc
     
        push ax
        push bx
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 040h
        mov bx, manejador
        mov cx, longitudTexto
        lea dx, texto
        
        int 21h
        
        pop dx
        pop cx
        pop bx
        pop ax  
        
        ret       
              
    escribirArchivo endp
    
    leerArchivo proc 
        
        push ax
        push bx
        push cx
        push dx
        
        
        pop dx
        pop cx
        pop bx
        pop ax
       
    leerArchivo endp
    
end code
