.model small

.stack 100h

.data
    
    ; Dictaminada para controlar la navegacion por el menu
    
    bandera db 0h
    teclado db 0h 
    
    ; Mensajes Menu     
    
    bienvenida db "--- Bienvenido ---", 10, 10, 13, "El programa actual grafica cuatro de la siguientes funciones matematicas ", 10 , 10, 13, "$"
    operaciones db "1.- Lineal ", 10, 13, "2.- Cuadratica", 10, 13, "3.- Raiz Cuadrada", 10, 13, "4.- Senoidal", 10, 13, "5.- Circular", 10, 13, "6.- Salir", 10, 10, 13, "$"
    operar db "Como desea operar ? ", 9, "$"
    
    ; Mensajes Control
    
    error db 13, "El dato ingresado no comprende ninguna opcion valida, favor de introducir un dato valido.", 10 ,10, 13, "$"
    continuar db "Presione cualquier tecla para continuar . . . ", "$"
    explicacion db "La funcion se graficara indefindamente hasta detectar cualquier tecla (Este mensaje solo se mostrara una vez)", 10, 13, "$"
    
    ; Valores  
     
    funcionLineal db 200, 197, 195, 192, 190, 187, 185, 182, 180, 177, 175, 172, 170, 167, 165, 162, 160, 157, 155, 152, 150, 147, 145, 142, 140, 137, 135, 132, 130, 127, 125, 122, 120, 117, 115, 112, 110, 107, 105, 102, 100, 97, 95, 92, 90, 87, 85, 82, 80, 77, 75, 72, 70, 67, 65, 62, 60, 57, 55, 52, 50, 47, 45, 42, 40, 37, 35, 32, 30, 27, 25, 22, 20, 17, 15, 12, 10, 7, 5, 2, 0
    
    funcionCuadraticaEjeX db 5, 10, 14, 17, 20, 22, 24, 26, 28, 30, 32, 33, 35, 36, 37, 39, 40, 41, 42, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 57, 58, 59, 60, 61, 62, 62, 63, 64, 65, 66, 66, 67, 68, 69, 69, 70, 71    
    funcionCuadraticaEjeY db 199, 196, 192, 188, 184, 180, 176, 172, 168, 164, 160, 156, 152, 148, 144, 140, 136, 132, 128, 124, 120, 116, 112, 108, 104, 100, 96, 92, 88, 84, 80, 76, 72, 68, 64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 12, 8, 4, 0
    longitudCuadratica EQU $- funcionCuadraticaEjeY
    
    funcionRaizEjeX dw 1, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 144, 148, 152, 156, 160, 164, 168, 172, 176, 180, 184, 188, 192, 196, 200, 204, 208, 212, 216, 220, 224, 228, 232, 236, 240, 244, 248, 252, 256, 260, 264, 268, 272, 276, 280, 284, 288, 292, 296, 300, 304, 308, 312, 316, 320
    funcionRaizEjeY db 195, 190, 186, 183, 180, 178, 176, 174, 172, 170, 168, 167, 165, 164, 163, 161, 160, 159, 158, 156, 155, 154, 153, 152, 151, 150, 149, 148, 147, 146, 145, 144, 143, 143, 142, 141, 140, 139, 138, 138, 137, 136, 135, 134, 134, 133, 132, 131, 131, 130, 129, 129, 128, 127, 127, 126, 125, 125, 124, 123, 123, 122, 121, 121, 120, 119, 119, 118, 118, 117, 116, 116, 115, 115, 114, 113, 113, 112, 112, 111, 111
    longitudRaiz EQU $- funcionRaizEjeY
    
    funcionSenoidal db 100, 87, 75, 63, 52, 41, 32, 23, 16, 10, 5, 2, 0, 0, 2, 5, 10, 16, 23, 32, 41, 52, 63, 75, 87, 100, 113, 125, 137, 148, 159, 168, 177, 184, 190, 195, 198, 200, 200, 198, 195, 190, 184, 177, 168, 159, 148, 137, 125, 113 
    longitudSenoidal EQU $- funcionSenoidal
    
    funcionCircularEjeX db 240, 240, 239, 237, 235, 233, 229, 226, 221, 217, 211, 206, 200, 194, 187, 181, 174, 167, 160, 153, 146, 139, 133, 126, 120, 114, 109, 103, 99, 94, 91, 87, 85, 83, 81, 80, 80, 80, 81, 83, 85, 87, 91, 94, 99, 103, 109, 114, 120, 126, 133, 139, 146, 153, 160, 167, 174, 181, 187, 194, 200, 206, 211, 217, 221, 226, 229, 233, 235, 237, 239, 240, 240, 255
    funcionCircularEjeY  db 100, 107, 114, 121, 127, 134, 140, 146, 151, 157, 161, 166, 169, 173, 175, 177, 179, 180, 180, 180, 179, 177, 175, 173, 169, 166, 161, 157, 151, 146, 140, 134, 127, 121, 114, 107, 100, 93, 86, 79, 73, 66, 60, 54, 49, 43, 39, 34, 31, 27, 25, 23, 21, 20, 20, 20, 21, 23, 25, 27, 31, 34, 39, 43, 49, 54, 60, 66, 73, 79, 86, 93, 100, 255
      
    Color EQU 0fh ;
    
.code

    mov ax, @data
    mov ds, ax
    
    call menu
        
    mov ah, 04ch
    int 21h 
    
   proc menu
    
        bucle:
        
            call borrarPantalla
            
            mov ah, 09h
            lea dx, bienvenida
            int 21h
            
            mov ah, 09h
            lea dx, operaciones
            int 21h
            
            mov ah, 09h
            lea dx, operar
            int 21h
            
            ; Leer caracter
            
            mov ah, 01h
            int 21h
            
            sub al, 30h ; Transformar a ASCII
            
            cmp al, 01h
                je lineal
            
            cmp al, 02h
                je cuadratica
             
            cmp al, 03h
                je raiz
                
            cmp al, 04h
                je senoidal
            
            cmp al, 05h 
                je circular
                
            cmp al, 06h  
                jne seguir
                ret    
                
            seguir:    
            
            mov ah, 09h
            lea dx, error
            int 21h
            
            mov ah, 09h
            lea dx, continuar
            int 21h
            
            mov ah, 01h
            int 21h
            
            jmp bucle
            
            lineal: 
            
                call graficoLineal
                jmp bucle
            
            cuadratica:
                
                call graficoCuadratica
                jmp bucle
                
            raiz:
            
                call graficoRaiz
                jmp bucle
                
            senoidal:
                
                call graficoSenoidal
                jmp bucle
            
            circular:
                
                call graficoCircular
                jmp bucle    
                          
    menu endp
   
   saltoLinea proc
    
        push ax
        push dx
        
        mov ah, 02h
        mov dx, 0Ah
        int 21h
        
        pop dx
        pop ax
        
        ret
    
    saltoLinea endp
   
   borrarPantalla proc
        
        push ax
        
        mov ax, 03h
        int 10h
        
        pop ax
        
        ret
       
    borrarPantalla endp
      
    
    establecerModoVideo proc 
        
        mov ah, 0
        mov al, 13h
        int 10h
        
        mov ah, 0ch
        mov al, Color
        
        ret
       
        establecerModoVideo endp
           
   validar proc
    
        push ax
        push dx
        
        mov al, bandera
        
        cmp al, 01h
        je terminarValidar
        
        call borrarPantalla
        
        mov ah, 09h
        lea dx, explicacion
        int 21h
        
        call saltoLinea 
        
        mov ah, 09h
        lea dx, continuar
        int 21h
        
        mov ah, 01h
        int 21h
        
        mov bandera, 01h
        
        terminarValidar:
        
            pop dx
            pop ax
   
            ret
   
    validar endp
   
       kbhit proc ; Validar si se ha presionado una tecla, para finalizar el programa
        
        push ax

        mov ah, 01h 
        int 16h     ; Leer teclado
    
        jnz teclaPresionada  
    
        mov teclado, 0h 
        pop ax
        
        ret
    
            teclaPresionada:
            
                mov ah, 01h
                int 21h
                
                mov teclado, 01h ; Tecla presionada
                pop ax
                
                ret

       kbhit endp
   
   graficoLineal proc
    
        push cx
        push dx
        push si
        
        xor cx, cx
        xor si, si
        
        call validar 
        call borrarPantalla
        call establecerModoVideo
        
        bucleLineal:
        
            call kbhit
            cmp teclado, 0h
            jne terminarLineal
            
            mov dl, funcionLineal[si]
            int 10h
            
            add cx, 04h
            inc si
            
            cmp cx, 140h
            jne bucleLineal
             
            call borrarPantalla
            call establecerModoVideo
              
            xor cx, cx
            xor si, si
            jmp bucleLineal
        
        terminarLineal:
                
            pop si
            pop dx
            pop cx  
               
            ret
            
    graficoCuadratica proc
   
        push cx
        push dx
        push si
        
        xor cx, cx
        xor si, si
                   
        call validar            
        call borrarPantalla
        call establecerModoVideo
          
        bucleCuadratico:
        
            call kbhit
            cmp teclado, 0h
            jne terminarCuadratico
            
            mov dl, funcionCuadraticaEjeY[si]     
            inc si
                                                           
            mov cx, 0A0h                                               
            add cl, funcionCuadraticaEjeX[si]                
            int 10h
            
            mov cx, 0A0h
            sub cl, funcionCuadraticaEjeX[si]
            int 10h   
            
            cmp si, longitudCuadratica
            jne bucleCuadratico
                
            call borrarPantalla
            call establecerModoVideo
            
            xor cx, cx
            xor si, si
            
            jmp bucleCuadratico
            
            terminarCuadratico:              
                  
                pop si
                pop dx
                pop cx
            
                ret    
   
    graficoCuadratica endp
    
    graficoRaiz proc
        
        push cx
        push dx
        push si
        push di
        
        xor di,di                 
        xor si, si
        xor dx, dx     
        xor cx, cx
        
        call validar 
        call borrarPantalla
        call establecerModoVideo
        
        bucleRaiz:   
        
            call kbhit
            cmp teclado, 0h
            jne terminarRaiz
            
            mov cx, funcionRaizEjeX[si]
            mov dl, funcionRaizEjeY[di]
            int 10h
            
            add si, 02h
            inc di
                     
            cmp di, longitudRaiz 
            jne bucleRaiz
                   
          call borrarPantalla
          call establecerModoVideo
           
          xor si, si 
          xor di, di
          
          jmp bucleRaiz
          
          terminarRaiz:      
                
              pop cx
              pop dx
              pop si
              pop di
              
              ret      
             
        graficoRaiz endp
    
    graficoSenoidal proc
        
        push cx
        push dx
        push si
        
        xor cx, cx
        xor si, si
        
        call validar
        call borrarPantalla
        call EstablecerModoVideo
        
        bucleSenoidal:
        
            call kbhit
            cmp teclado, 0h
            jne terminarSenoidal
        
            mov dl, funcionSenoidal[si]
            int 10h
            
            inc cx
            inc si
            
            cmp cx, 140h
            je limpiar
             
            cmp si, longitudSenoidal
            jl bucleSenoidal
            
            xor si, si
            jmp bucleSenoidal
                              
            terminarSenoidal:
            
                pop si
                pop dx
                pop cx
                
                ret 
                
            limpiar:
            
                xor cx, cx
                xor si, si
            
                call borrarPantalla
                call establecerModoVideo
                
                jmp bucleSenoidal
                
        graficoSenoidal endp
    
    graficoCircular proc
        
        push cx
        push dx 
        push si
        push di
               
        call validar       
        call borrarPantalla
        call establecerModoVideo
         
        xor cx, cx
        xor dx, cx 
        xor si, si
        xor di, di
        
        bucleCirculo:
               
            call kbhit
            cmp teclado, 01h
            je terminarCirculo 
            
            mov cl, funcionCircularEjeX[si]
            mov dl, funcionCircularEjeY[di]
            int 10h
            
            inc si
            inc di
   
            cmp funcionCircularEjeX[si + 1], 0FFh
            jne bucleCirculo
            
            call borrarPantalla
            call establecerModoVideo
            
            xor si, si
            xor di, di
            
            jmp bucleCirculo
            
         terminarCirculo:    
         
             pop di
             pop si
             pop dx
             pop cx
               
             ret 
          
        graficoCircular endp
    
end code 
