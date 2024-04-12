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
    funcionCuadratica db 199, 196, 191, 184, 175, 164, 151, 136, 119, 100, 79, 56, 31, 4
    funcionRaiz dw 1, 4, 9, 16, 25, 36, 49  , 64, 81, 100, 121, 144, 169, 196, 225, 256, 289
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
            
            call borrarPantalla
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
            
            mov dl, funcionCuadratica[si]     
            inc si
                 
            mov cx, 0A0h
            add cx, si
            int 10h
            
            mov cx, 0A0h
            sub cx, si
            int 10h   
            
            cmp dl, 04h
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
        
        xor si, si
        xor dx, dx     
        xor cx, cx
        
        call validar 
        call borrarPantalla
        call establecerModoVideo
        
        mov dx, 0C8h ; 200 Decimal
        
        bucleRaiz:   
        
            call kbhit
            cmp teclado, 0h
            jne terminarRaiz
        
            mov cx, funcionRaiz[si]
            int 10h
            
            add si, 02h
            dec dx
                     
            cmp cx, 0121h 
            jne bucleRaiz
                   
          call borrarPantalla
          call establecerModoVideo
           
          xor si, si 
          mov dx, 0C8h
          
          jmp bucleRaiz
          
          terminarRaiz:      
                
              pop cx
              pop dx
              pop si
              
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
