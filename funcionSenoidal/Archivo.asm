.model small

.stack 100h

.data
   
   Mensaje db "!Bienvenido! A continuacion se representara la funcion senoidal.", 10, 10, 13, "Presione cualquier tecla para salir del bucle: ", "$"  
   datosSenoidal db 100, 87, 75, 63, 52, 41, 32, 23, 16, 10, 5, 2, 0, 0, 2, 5, 10, 16, 23, 32, 41, 52, 63, 75, 87, 100, 113, 125, 137, 148, 159, 168, 177, 184, 190, 195, 198, 200, 200, 198, 195, 190, 184, 177, 168, 159, 148, 137, 125, 113 ; Datos Senoidal
   Longitud EQU $ - datosSenoidal ; Obtener la dimension del array.  
   Color EQU 0fh ; EQU = Equal to, declaracion de una constante, en esa circunstancai es un blanco brillante en IRGB.
   Bandera db ? ; Valida si presiona alguna tecla para terminar el bucle. 
    
.code

    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, Mensaje
    int 21h   
    
    mov ah, 01h
    int 21h
      
    mov ah, 0h  
    mov al, 13h ; 320 x 200 Pixeles a Color.
    int 10h ; Activar el modo video. 
    
    mov bx, 0h 
    mov cx, 0h
    dec cx 
    mov si, 0h
    
    Bucle:
    
        call Kbhit  ; Validar si es deseado terminar el bucle   
        cmp Bandera, 01h
        je terminarPrograma
        
        inc cx ; Posion en X  
        mov dl, datosSenoidal[si] ; Posicion en Y.  
        mov ah, 0ch
        mov al, Color
        int 10h
        
        inc si
                    
        cmp cx,140h
        je restablecerPantalla      
              
        cmp si, Longitud
        jl Bucle
    
    mov si, 0h
    
    jmp Bucle
    
    restablecerPantalla:
        
        xor cx, cx
        xor si, si
        
        mov ah, 06h
        mov al, 0h
        mov bh, 0h
        int 10h
        
        jmp Bucle
          
          
    Kbhit proc ; Validar si se ha presionado una tecla, para finalizar el programa

    mov ah, 01h 
    int 16h     ; Leer teclado

    jnz teclaPresionada ; Si ZF=0, una tecla ha sido presionada

    mov Bandera, 0h ; No se ha presionado ninguna tecla  
    
    ret

        teclaPresionada:
        
        mov Bandera, 01h ; Tecla presionada
        ret

        Kbhit endp
    
   terminarPrograma:
                                                    
    mov ah, 04ch ; Terminar Programa
    int 21h
    
end code                        
