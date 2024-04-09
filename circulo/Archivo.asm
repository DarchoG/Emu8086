.model small

.stack 100h
    
.data

    primerMensaje db "--- Graficar Circulo ---", 10, 10, 13, "$"
    segundoMensaje db "El circulo se graficara de manera indefinida hasta detectar cualquier tecla.", "$"
    
    mensajeControl db 10, 10, 13, "Pulse cualquier tecla para continuar.", "$"
    
    ejeX db "$$$$$$"
    ejeY db "$$$$$$"
    
    longitudCirculo EQU $- ejeX
    
    color EQU db 0FH
    bandera db 0h
   
.code

    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, primerMensaje
    int 21h
    
    mov ah, 09h
    lea dx, segundoMensaje
    
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
        
        mov ah, 0ch
        mov al, color
        
        ret
        
        activarModoVideo endp
    
    kbhit proc
        
        mov ah, 01h
        int 16h
        
        jnz teclaPresionada
        
        mov Bandera, 0h
        
        ret
        
            teclaPresionada:
            
                mov bandera, 01h
                
                ret
                
       kbhit endp
    
       borrarPantalla proc
            
            push ax
            
            mov ax, 03h
            int 10h
            
            pop ax
            
            ret
           
        borrarPantalla endp
    
    graficarCirculo proc
       
        push cx
        push dx 
        push si
        push di
        
        call borrarPantalla
        call activarModoVideo
        
        bucleCirculo:
               
            call kbhit
            
            mov
            
            cmp 
         
         pop di
         pop si
         pop dx
         pop cx   
        
         ret
              
        graficarCirculo endp
  
end code
