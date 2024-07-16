.model small

.stack 100h

.data

    direccion db "C:\emu8086\MyBuild\prueba.txt", 0
    manejador dw 0
    
    primerMensaje db "1.- Se ha creado el archivo satisfactoriamente.", 13, 10, 10, "$"
    segundoMensaje db 13, 10, 10, "2.- Se ha abierto el archivo exitosamente.", 13, 10, 10, "$"
    tercerMensaje db "3.- Se ha escrito en el archivo adecuadamente.", 13, 10, 10, "$"
    cuartoMensaje db "4.- Se ha leido el archivo apropiadamente.", 13, 10, 10, "$"
    quintoMensaje db "5.- El numero de palabras del contenido es: ", "$"
     
    inicioLectura db "Digite el mensaje deseado a almacenar en un archivo: ", 13, 10, 10, 9, "- ", "$"
    finalLectura db 13, 10, 10, "Se ha registrado el siguiente mensaje: ", 13, 10, 10, 9, "- ", "$"
    texto db 255 dup("$")
    longitudTexto dw 0h
     
    textoLeido db 255 dup ("$")
    
    numeroPalabras db 0h
    stringPalabrasInvertidas 4 dup("$")
    stringPalabras 4 dup("$")
    
    bandera db 0h
       
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
             
    mov ah, 04ch
    int 21h
    
    pausa proc
        
        push ax
        
        mov ah, 01h
        int 21h
            
        pop ax
        
        ret
     
    pausa endp
    
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
        
        mov ah, 09h
        lea dx, primerMensaje
        int 21h
        
        call pausa
               
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
        
        mov ah, 09h
        lea dx, segundoMensaje
        int 21h
        
        call pausa
        
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
        
        mov ah, 09h
        lea dx, tercerMensaje
        int 21h
        
        call pausa
        
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
        
        call restablecerPuntero
        
        mov ax, 0h
        mov ah, 3Fh
        mov bx, manejador
        mov cx, longitudTexto
        lea dx, textoLeido
        
        int 21h
        
        mov ah, 09h
        lea dx, cuartoMensaje
        int 21h
        
        call pausa
         
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
       
    leerArchivo endp
    
    restablecerPuntero proc
        
        push ax
        push bx
        push cx
        push dx
        
        mov ax, 0h 
        mov ah, 42h
        mov bx, manejador
        mov cx, 0h
        mov dx, 0h
        
        int 21h
        
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
              
    restablecerPuntero endp
    
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
           je incrementarContador
           
           mov bandera, 01h
           jmp leerLetra
            
           incrementarContador: 
              
               cmp bandera, 01h
               jne leerLetra
               
               mov bandera, 0h
               inc numeroPalabras
               jmp leerLetra
           
       finContar:
       
           cmp bandera, 0h
           je retornar
           
           inc numeroPalabras
           
           retornar:
                
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
        mov bl, 0Ah 
        
        division:
        
            div bl
            add ah, 30h
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
        
        mov ah, 09h
        lea dx, quintoMensaje
        int 21h
        
        mov ah, 09h
        lea dx, stringPalabras
        int 21h
        
        pop ax
        
        ret 
          
    mostrarPalabras endp
    
end code
