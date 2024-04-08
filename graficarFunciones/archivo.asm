.model small

.stack 100h

.data
    
    ; Dictaminada para controlar la navegacion por el menu
    
    variableControl db 0h
    bandera db 0h 
    
    ; Mensajes Menu     
    
    bienvenida db "--- Bienvenido ---", 10, 10, 13, "El programa actual grafica cuatro de la siguientes funciones matematicas ", 10 , 10, 13, "$"
    operaciones db "1.- Lineal ", 10, 13, "2.- Cuadratica", 10, 13, "3.- Raiz Cuadrada", 10, 13, "4.- Senoidal", 10, 13, "5.- Salir", 10, 13, "$"
    operar db "Como desea operar ? ", 9, "$"
    
    ; Mensajes Control
    
    error db 13, "El dato ingresado no comprende ninguna opcion valida, favor de introducir un dato valido.", 10 ,10, 13, "$"
    continuar db "Presione cualquier tecla para continuar.", 10, 13, "$"
    explicacion db "La funcion se graficara indefindamente hasta detectar cualquier tecla (Este mensaje solo se mostrara una vez)", 10, 13, "$"
    
    ; Valores  
     
    funcionLineal dw 2, 3, 5, 6, 8, 10, 11, 13, 14, 16, 18, 19, 21, 22, 24, 26, 27, 29, 30, 32, 34, 35, 37, 38, 40, 42, 43, 45, 46, 48, 50, 51, 53, 54, 56, 58, 59, 61, 62, 64, 66, 67, 69, 70, 72, 74, 75, 77, 78, 80, 82, 83, 85, 86, 88, 90, 91, 93, 94, 96, 98, 99, 101, 102, 104, 106, 107, 109, 110, 112, 114, 115, 117, 118, 120, 122, 123, 125, 126, 128, 130, 131, 133, 134, 136, 138, 139, 141, 142, 144, 146, 147, 149, 150, 152, 154, 155, 157, 158, 160, 162, 163, 165, 166, 168, 170, 171, 173, 174, 176, 178, 179, 181, 182, 184, 186, 187, 189, 190, 192, 194, 195, 197, 198, 200, 202, 203, 205, 206, 208, 210, 211, 213, 214, 216, 218, 219, 221, 222, 224, 226, 227, 229, 230, 232, 234, 235, 237, 238, 240, 242, 243, 245, 246, 248, 250, 251, 253, 254, 256, 258, 259, 261, 262, 264, 266, 267, 269, 270, 272, 274, 275, 277, 278, 280, 282, 283, 285, 286, 288, 290, 291, 293, 294, 296, 298, 299, 301, 302, 304, 306, 307, 309, 310, 312, 314, 315, 317, 318, 320
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
   
   graficoLineal proc
    
        push cx
        push dx
        push si
        
        xor si, si
        
        call borrarPantalla
        
        mov ah, 0h  
        mov al, 13h ; 320 x 200 Pixeles a Color.
        int 10h ; Activar el modo video. 
        
        bucleLineal:
        
        mov dx, funcionLineal[si]
        mov ah, 0ch
        mov al, Color
        int 10h
        
        inc cx
        inc si
        
        cmp cx, 140h
        jne bucleLineal
        
        call borrarPantalla
        
        ret
        
    graficoLineal endp
   
end code  
