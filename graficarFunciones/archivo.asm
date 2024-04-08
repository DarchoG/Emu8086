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
     
    funcionLineal db "$$$$$$$"
    funcionCuadratica db "$$$$$"
    funcionRaizCuadrada db "$$$$"
    funcionSenoidal db "$$$$"
    
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
            
                ;call graficoLineal
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
        
    
    saltoLinea endp
   
   borrarPantalla proc
        
        push ax
        
        mov ax, 3
        int 10h
        
        pop ax
       
    borrarPantalla endp
  

end code  
