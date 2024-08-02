.model small

.stack 100h

.data
    
    instruccion db "Escribe un mensaje a ser almacenado ", 13, 10, 10, "- ", "$"
    bufferEscritura db 256 dup ("$")
 
    cantidadDatos dw 0h
        
    retroalimentacion db 13, 10, 10, "Se ha registrado ", 13, 10, 10, "- ", "$"
    resultado db 13, 10, 10, "La cantidad de caracteres es ", "$"
    par db "par", "$"
    impar db "impar", "$"
    
.code

    mov ax, @data
    mov ds, ax
    
    call bucleLectura
    call mostrarResultados
                     
    mov ax, 04ch
    int 21h
    
    bucleLectura proc
        
        push ax
        push si
        
        xor si, si
        
        mov ah, 09h
        lea dx, instruccion
        int 21h
        
        cicloLectura:
        
            mov ah, 01h
            int 21h
            
            cmp al, 0Dh
            je finalizarCiclo
            
            mov bufferEscritura[si], al
            inc si 
            
            cmp si, 0FFh
            je finalizarCiclo
            
            jmp cicloLectura
                
        finalizarCiclo: 
        
            mov cantidadDatos, si
        
            pop si
            pop ax
            
            ret
  
    bucleLectura endp
    
    paridad macro Cantidad
        
        push ax
        push bx
        push dx
        
        xor dx, dx
            
        mov ax, Cantidad
        mov bx, 02h
        div bx
        
        cmp dx, 01h
        je numeroImpar
        
        mov ah, 09h
        mov dx, offset(par)
        int 21h 
        
        jmp finParidad
          
        numeroImpar:
        
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
        
        mov ah, 09h
        lea dx, retroalimentacion 
        int 21h 
        
        mov ah, 09h
        lea dx, bufferEscritura
        int 21h
        
        mov ah, 09h
        lea dx, resultado
        int 21h
        
        paridad cantidadDatos
        
        pop dx
        pop ax
        
        ret
        
    mostrarResultados endp

end code
