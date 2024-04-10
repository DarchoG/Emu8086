.model small

.stack 100h
    
.data

    primerMensaje db "--- Graficar Circulo ---", 10, 10, 13, "$"
    segundoMensaje db "El circulo se graficara de manera indefinida hasta detectar cualquier tecla.", "$"
    
    mensajeControl db 10, 10, 13, "Pulse cualquier tecla para continuar.", "$"
    
    ejeX db 240, 240, 239, 237, 235, 233, 229, 226, 221, 217, 211, 206, 200, 194, 187, 181, 174, 167, 160, 153, 146, 139, 133, 126, 120, 114, 109, 103, 99, 94, 91, 87, 85, 83, 81, 80, 80, 80, 81, 83, 85, 87, 91, 94, 99, 103, 109, 114, 120, 126, 133, 139, 146, 153, 160, 167, 174, 181, 187, 194, 200, 206, 211, 217, 221, 226, 229, 233, 235, 237, 239, 240, 240, 255
    ejeY db 100, 107, 114, 121, 127, 134, 140, 146, 151, 157, 161, 166, 169, 173, 175, 177, 179, 180, 180, 180, 179, 177, 175, 173, 169, 166, 161, 157, 151, 146, 140, 134, 127, 121, 114, 107, 100, 93, 86, 79, 73, 66, 60, 54, 49, 43, 39, 34, 31, 27, 25, 23, 21, 20, 20, 20, 21, 23, 25, 27, 31, 34, 39, 43, 49, 54, 60, 66, 73, 79, 86, 93, 100, 255
      
    color EQU 0FH
    bandera db 0h
   
.code

    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, primerMensaje
    int 21h
    
    mov ah, 09h
    lea dx, segundoMensaje
    int 21h
    
    call continuar
    call graficarCirculo
    
    mov ah, 04ch
    int 21h
    
    continuar proc
        
        push ax
        
        mov ah, 09h
        lea dx, mensajeControl
        int 21h
   
        mov ah, 01h
        int 21h
       
        pop ax
                
        ret
        
        continuar endp
    
    activarModoVideo proc
        
        mov ah, 0h
        mov al, 13h
        int 10h
        
        mov ah, 0ch
        mov al, color
        
        ret
        
        activarModoVideo endp
    
    kbhit proc
        
        push ax
        
        mov ah, 01h
        int 16h
        
        jnz teclaPresionada
        
        mov Bandera, 0h
        
        pop ax
        
        ret
        
            teclaPresionada:
            
                mov bandera, 01h
                
                pop ax       
                
                ret
                
       kbhit endp
    
       borrarPantalla proc
            
            push ax 
            
            xor ax, ax
           
            mov ax, 13h
            int 10h
            
            pop ax
            
            ret
           
        borrarPantalla endp
    
    graficarCirculo proc
        
        push bx
        push cx
        push dx 
        push si
        push di
        
        call borrarPantalla
        call activarModoVideo
         
        xor cx, cx
        xor dx, cx 
        xor si, si
        xor di, di
        
        bucleCirculo:
               
            call kbhit
            
            mov cl, ejeX[si]
            mov dl, ejeY[di]
            int 10h
            
            inc si
            inc di
            
            cmp bandera, 01h
            je final 
            
            cmp ejeX[si + 1], 0FFh
            jne bucleCirculo
            
            call borrarPantalla
            call activarModoVideo
            
            xor si, si
            xor di, di
            
            jmp bucleCirculo
            
         final:    
         
         pop di
         pop si
         pop dx
         pop cx
         pop bx   
        
         ret
              
        graficarCirculo endp
  
end code
