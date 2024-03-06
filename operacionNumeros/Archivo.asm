.model small  ; Que tan grande quiero que sea el programa, termino medio es posible usar tiny, small, medium, compact, large
              ; Small soporta un segmento de datos y codigo
.stack 100h   ; Datos de pila 256 datos, 100h en hexadecimal, es una buena practica declarar el modulo de datos y memoria a hacer uso antes del codigo

.data ; Variables a usar;
    
    primerMensaje db "Escribe el primer numero: ", "$"
    segundoMensaje db "Escribe el segundo numero: ", "$"
    tercerMensaje db 10, "Resultado: " 
                                            
    primerNumero db "$$$$$$" ; El mensaje actualmente se desconoce, por tal motivo signo de interogacion
    segundoNumero db "$$$$$"
    
    primerValor dw  ?
    segundoValor dw ?
    
    Resultado db " + ", "$"                                        
    
    ; Los labels son direcciones susceptibles a ser usadas con el objetivo de servir como un operador de instruccion, en los casos previos serian mis saltos incondicionales
    ; Es requerido el : y un identificador.
    ; CMP simula los if, es un salto condicional.    

.code ; Operaciones logicas matematicas a realizar;

    mov ax, @data ; Todas mis variables las muevo a la parte alta de mi regitstro, para posteriormente cargarlo en DS
    mov ds, ax ; No se pueden usar las variables directamente a mis registros de segmentos, DS (Data Segment)
                   
    mov ah, 09h ; Imprimir un string con 09, cargarlo en mi segmentos de datos con mi operador lea
    lea dx, primerMensaje ; Load Effective Address, cargar una direccion de mi variable Mensaje y almacenarla en dx. 
    int 21h
                                          
    lea bx, primerNumero ;mov al, 01h ; La interrupicion 21h requiere tener un 1 en ah para para poder admmitir un solo caracter en ASCII, 02 imprime un solo cracter, 09 un string
    call validacionNumero ;int 21h ; Es posible alojarlo en en al o ah, preferentemente al. EL RESULTADO ES GUARDADO EN AL. 
             
    call saltoLinea
      
    mov ah, 09h
    lea dx, segundoMensaje
    int 21h
    
    lea bx, segundoNumero
    call validacionNumero
    
    call saltoLinea
                                     
    mov ah, 09h    
    lea dx, primerNumero
    int 21h
    
    mov ah, 09h
    lea dx, Resultado
    int 21h  
    
    mov ah, 09h
    lea dx, segundoNumero
    int 21h                
    
    lea bx, primerNumero
    lea di, primerValor
    call convertirNumero
    
    lea bx, segundoNumero
    lea di, segundoValor
    call convertirNumero
             
    jmp terminarPrograma   
    
    saltoLinea proc
        
        push ax
        push dx
           
        mov ah, 02h
        mov dx, 0Ah ; Salto de linea en ASCII
        int 21h
         
        pop ax
        pop dx                      
        
        ret           
        
    saltoLinea endp             
    
    
    validacionNumero proc;Creacion de una funcion para poder validar n cantidad de numeros y evitar repetir codigo
    
        push ax
        push bx
        push si
               
        ; Cargar en la pila los datos ingresados, clonar los registros, evitar dejar residuos de su maniupulacion.
        
        xor si, si
        
        leerSiguienteCaracter:
        
        mov ah, 01h ; Ejecutar la funcion 01h de la interrupcion 21h que permite leer un solo caracter, almacenado en al
        int 21h
                  
        ; Proceso de validacion del numero          
                  
        cmp al, "-" ; cmp es equivalente a un if
            jne procesarDigito; Jump if Not Equal, salto condicional, se produce si la comparacion anterior es falsa
        cmp si, 0h
            jne terminarLectura
        
        mov [bx + si], al ; Alojar el dato digitado
        inc si ; Incrementar 1 para comparar la siguiente posicion del string 
        
        jmp leerSiguienteCaracter
        
        procesarDigito:
            
            cmp al, "0"
                jl terminarLectura ; Jump if Less Than, si es menor que 0 terminar lectura
            cmp al, "9"
                jg terminarLectura ; Jump if Greater than, si es mayor que 9 terminar lectura
            
            mov [bx + si], al ; Recorrer una posicion de la lectura del string
            inc si
            jmp leerSiguienteCaracter
        
        terminarLectura:
            
            mov al, "$"
            mov [bx + si], al
            
            pop si
            pop bx
            pop ax
            
            ret ; Retornar al punto donde se hizo la llamada
            
    validacionNumero endp
    
    
    convertirNumero proc
                            
         push ax
         push bx
         push cx
         push di
         push si        
                   
         mov cx, 0h                 
                          
         bucle:                        
             
             mov al, 0Ah ; Multiplicar por 10 para aumentar el numeri
             imul cx
             mov cx,al
            
             xor ax, ax 
             mov al, [si + bx]; Cargar la cadena en al               
             cmp al, "$"
             je convertirFinal ; Jump if Equal, brincar si es igual, en dado caso hemos asumido que la cadena se agoto.
             cmp al, "-"
             je omitir
                       
             dx          
                       
             sub al, 30h ; Convertir ASCII a numero
             add cx, ax ; Desplazar una posicion por 10, para agregar el numero pasado   
             mov ax, 0Ah ; Poner 10 en ax para multiplicar  
             
             cmp si, 0h  ; En el primera iteracion no es necesario multiplicar por 10
             je Omitir
             
             imul cx
             mov cx, ax  
                                  
         omitir:
             
            mov cx, ax  
            inc si
            
            jmp bucle:
         
         convertirFinal:
         
            mov [di], cx 
            
            pop si
            pop di
            pop cx
            pop bx
            pop ax
            
            ret                                   
                              
        convertirNumero endp
    
    
    terminarPrograma:
        
        mov ah, 04ch
        int 21h
    
end code
