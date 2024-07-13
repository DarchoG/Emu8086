.model small

.stack 100h

.data

    direccion db "C:\emu8086\MyBuild\prueba.txt", 0
    manejador dw 0
    
    primerMensaje db "Se ha creado el archivo satisfactoriamente.", 13, 10, 10, "$"
    segundoMensaje db "Se ha abierto el archivo exitosamente, AL contiene el handle o identificador unico del archivo", 13, 10, 10, "$"
    tercerMensaje db "Se ha escrito en el archivo adecuadamente.", 13, 10, 10, "$"
    cuartoMensaje db "Se ha leido el archivo apropiadamente.", 13, 10, 10, "$"
    quintoMensaje db "El numero de palabras del contenido es: ", "$"
    
    pausa db "Pulse cualquier tecla para continuar.", 13, 10, 10, "$" 
     
    inicioLectura db "Digite el mensaje deseado a almacenar en un archivo: ", 13, 10, 10, 9, "- ", "$"
    finalLectura db 13, 10, 10, "Se ha registrado el siguiente mensaje: ", 13, 10, 10, 9, "- ", "$"
    texto db 255 dup("$")
    longitudTexto dw 0h
     
    textoLeido db 255 dup ("$")
    
    numeroPalabras db 0h
    stringPalabrasInvertidas 3 dup("$")
    stringPalabras 3 dup("$")
    
    bandera db 01h
       
.code
    
    mov ax, @data
    mov ds, ax
     
    call crearArchivo
    call leerString
    call abrirArchivo
    call escribirArchivo
    call leerArchivo
    call contarString
    call transformarNumero
    call mostrarPalabras
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
    
    leerString proc
        
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
            
    leerString endp
    
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
        
        mov ax, 0h
        mov ah, 3Fh
        mov bx, manejador
        mov cx, longitudTexto
        lea dx, textoLeido
        
        int 21h
         
        pop dx
        pop cx
        pop bx
        pop ax
       
    leerArchivo endp 
    
    contarString proc
        
       push ax
       push bx
       push si
       
       xor ax, ax
       xor bx, bx 
       xor si, si
       
       leerLetra:
           
           mov al, textoLeido[si]
           
           cmp si, longitudTexto
           je finContar
           
           inc si
           
           cmp al, 20h
           jne leerLetra
           
           cmp bandera, 01h
           jne leerLetra
           
           mov bandera, 0h
           inc bl
           
       finContar:
       
           mov numeroPalabras, bl
           
           pop si
           pop bx
           pop ax
       
           ret     
        
    contarString endp
    
    transformarNumero proc 
        
        push ax
        push bx
        push dx
        push si
        push di
          
        xor ax, ax
        xor si, si
        xor di, di
        
        mov al, numeroPalabras
        mov bx, 0Ah 
        
        division:
        
            div bx
            add dx, 30h
            mov stringPalabrasInvertidas[si], ah
            xor ah, ah
            inc si
            
            cmp al, 0h
            jne division
        
        invertirString:
            
            xor di, di
            mov ax, si
            
            invertir:
            
                mov al, stringPalabrasInvertidas[si]
                mov stringPalabras[di], al
                inc di
                dec si
                
                cmp di, ax
                jne invertir
                
                pop di
                pop si
                pop dx
                pop bx
                pop ax
                
                ret
             
    transformarNumero endp
    
    mostrarPalabras proc
        
        push ax
        
        mov ax, 09h
        lea dx, quintoMensaje
        int 21h
        
        mov ax, 09h
        lea dx, stringPalabras
        int 21h
        
        pop ax
        
        ret 
          
    mostrarPalabras endp
    
end code
