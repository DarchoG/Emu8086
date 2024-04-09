.model small

.stack 100h

.data
    
    ; Dictaminada para controlar la navegacion por el menu
    
    variableControl db 0h
    bandera db 0h
    teclado db 0h 
    
    ; Mensajes Menu     
    
    bienvenida db "--- Bienvenido ---", 10, 10, 13, "El programa actual grafica cuatro de la siguientes funciones matematicas ", 10 , 10, 13, "$"
    operaciones db "1.- Lineal ", 10, 13, "2.- Cuadratica", 10, 13, "3.- Raiz Cuadrada", 10, 13, "4.- Senoidal", 10, 13, "5.- Salir", 10, 10, 13, "$"
    operar db "Como desea operar ? ", 9, "$"
    
    ; Mensajes Control
    
    error db 13, "El dato ingresado no comprende ninguna opcion valida, favor de introducir un dato valido.", 10 ,10, 13, "$"
    continuar db "Presione cualquier tecla para continuar.", 10, 13, "$"
    explicacion db "La funcion se graficara indefindamente hasta detectar cualquier tecla (Este mensaje solo se mostrara una vez)", 10, 13, "$"
    
    ; Valores  
     
    funcionLineal db 200, 197, 195, 192, 190, 187, 185, 182, 180, 177, 175, 172, 170, 167, 165, 162, 160, 157, 155, 152, 150, 147, 145, 142, 140, 137, 135, 132, 130, 127, 125, 122, 120, 117, 115, 112, 110, 107, 105, 102, 100, 97, 95, 92, 90, 87, 85, 82, 80, 77, 75, 72, 70, 67, 65, 62, 60, 57, 55, 52, 50, 47, 45, 42, 40, 37, 35, 32, 30, 27, 25, 22, 20, 17, 15, 12, 10, 7, 5, 2, 0
    funcionCuadratica db "$$$$$"
    funcionRaizCuadrada db "$$$$"
    funcionSenoidal db "$$$$"
      
    Color EQU 0fh ;
    
.code

    mov ax, @data
    mov ds, ax
    
    call menu
        
    mov ah, 04ch
    int 21h 
    
   proc menu
    
        bucle:
        
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
                
                jne seguir
                ret
                
            seguir:    
            
            mov ah, 09h
            lea dx, error
            int 21h
            
            mov ah, 09h
            lea dx, continuar
            int 21h
            
            call borrarPantalla
            jmp bucle
            
            lineal: 
            
                call graficoLineal
                jmp bucle
            
            cuadratica:
                
                ;call graficoCuadratica
                jmp bucle
                
            raiz:
            
                ;call graficoRaiz
                jmp bucle
                
            senoidal:
                
                ;call graficoSenoidal
                jmp bucle
                          
    menu endp
   
   saltoLinea proc
    
        push ax
        push dx
        
        mov ah, 02h
        mov dx, 0Ah
        int 21h
        
        pop dx
        
        ret
    
    saltoLinea endp
   
   borrarPantalla proc
        
        push ax
        
        mov ax, 3
        int 10h
        
        pop ax
        
        ret
       
    borrarPantalla endp
   
   validar proc
    
    ret
    
    
    validar endp
   
   
   graficoLineal proc
    
        push cx
        push dx
        push si
        
        xor cx, cx
        xor si, si
        
        call borrarPantalla
        
        mov ah, 0h  
        mov al, 13h ; 320 x 200 Pixeles a Color.
        int 10h ; Activar el modo video. 
        
        bucleLineal:
        
        mov dl, funcionLineal[si]
        mov ah, 0ch
        mov al, Color
        int 10h
        
        add cx, 04h
        inc si
        
        cmp cx, 140h
        jne bucleLineal
        
        call borrarPantalla
        
        ret
        
    graficoLineal endp
   
    kbhit proc ; Validar si se ha presionado una tecla, para finalizar el programa

        mov ah, 01h 
        int 16h     ; Leer teclado
    
        jnz teclaPresionada ; Si ZF=0, una tecla ha sido presionada
    
        mov teclado, 0h ; No se ha presionado ninguna tecla  
        
        ret
    
            teclaPresionada:
            
            mov teclado, 01h ; Tecla presionada
            ret

       kbhit endp
   
end code  
