
.model small  ; Que tan grande quiero que sea el programa, termino medio es posible usar tiny, small, medium, compact, large
              ; Small soporta un segmento de datos y codigo
.stack 100h   ; Datos de pila 256 datos, 100h en hexadecimal, es una buena practica declarar el modulo de datos y memoria a hacer uso antes del codigo

.data ; Variables a usar;
      
    primerMensaje db "Escribe el primer numero: ", "$"
    segundoMensaje db "Escribe el segundo numero: ", "$"
    tercerMensaje db 10,"Resultado: + ", "$"
    cuartoMensaje db " = ", "$"
                                             
    primerNumero dw "$$$$$$" ; El mensaje actualmente se desconoce, por tal motivo signo de interogacion
    segundoNumero dw "$$$$$"
        
    resultado db " + ", "$"
    operacion dw ? ; ? = El valor se desconoce
    
    contadorAuxiliar dw 0h
    valorAuxiliar dw 0h                                     
    
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
    lea dx, resultado
    int 21h  
    
    mov ah, 09h
    lea dx, segundoNumero
    int 21h
    
    mov ah, 09h
    lea dx, cuartoMensaje
    int 21h                
    
    lea bx, primerNumero
    call convertirNumero
    mov primerNumero, dx
    
    lea bx, segundoNumero
    call convertirNumero
    mov segundoNumero, dx
    
    call operar
                               
    mov ah, 09h
    lea dx, operacion
    int 21h
              
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
                            
         push ax ; Registro para las multiplicaciones
         push bx ; String con los numeros
         push cx ; Registro para multiplicar
         push dx ; Variable contenedora de mi resultado, cambiar la variable dx por temporal ya que el excedente de mul lo coloca ahi
         push si ; Registro empleado para hacer el conteo de lo ciclos
         
         call contarDigitos       
                   
         mov cx, 0h ; Limpiar                
                          
         bucle:      
             
             xor ax, ax ; Limpiar
             mov al, [bx + si]; Cargar caracteres
             cmp al, "$"
             je convertirFinal
             cmp al, "-"
             je omitir
             
             sub al, 30h ; Convertir ASCII a numero
             mov cx, 01h
             call obtenerPotencia
             
             mul cx ; Multiplico por mi notacion posicional
                                                                 
             call guardarNumero ; Resultado lo guardo en otra variable                         
       
         omitir:
               
            inc si           
            jmp bucle
         
         convertirFinal:
                     
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
            mov dx, valorAuxiliar
            mov valorAuxiliar, 0h
            mov contadorAuxiliar, 0h
            
            ret                                   
                              
        convertirNumero endp
    
    contarDigitos proc  ; Necesito contar los digitos para saber en que posicion estoy en mi bucle porque al iterar el string lo hago en posicion 0, pero realmente es el bit mas significativo.
             
             push bx
             push si
             
             inicio:
             
             mov al, [bx + si]; Cargar caracteres
             cmp al, "$"
             je objetivo
             cmp al, "-"
             je saltar
               
             saltar:
             
                inc si
                jmp inicio     
             
             objetivo:
             
               dec si   
               mov contadorAuxiliar, si ; Saber la cantidad de posiciones que tiene mi cantidad para poderlo convertir satisfactoriamente
               
               pop si
               pop bx                          
          
               ret 
                          
        contarDigitos endp

    
    obtenerPotencia proc  ; Obtener la notacion posicional para obtener mi valor, retornar dicho valor, potencias de 10.
        
        push ax
        push si
        
        mov si, contadorAuxiliar ; Cargar la ultima posicion.
        
        ; ax Tiene mi valor ingresado a obtener la potencia             
        ; cx Tiene 10
                
        ciclo: 
                      
           cmp si, 0h
           je final
                    
           mov al, 0Ah ; Multiplicar base         
           mul cx ; Multiplico por mi base
           mov cx, ax ; Actualizo mi resultado
             
           dec si
           
           jmp ciclo
    
        final:
               
         pop si      
         pop ax
         
         sub contadorAuxiliar, 01h
        
         ret
        
        obtenerPotencia endp
    
     
     guardarNumero proc ; Empleado para tener mas registros disponibles para la suma
        
        push bx
        
        mov bx, ax
        add valorAuxiliar, bx 
        
        pop bx
                           
        ret                 
        
        guardarNumero endp
        
        
     operar proc
        
        push ax
        push bx
        push cx
        push dx
        push si
        
        mov ax, primerNumero
        mov bx, segundoNumero
        
        add ax, bx
        mov operacion, ax
        
        call divisionEuclidea   
        
        pop si       
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
        
        operar endp
        
        
     divisionEuclidea proc
        
        xor ax, ax
        xor bx, bx
        xor dx, dx
        mov ax, operacion
        mov bx, 0Ah
        mov si, 0h
        
        division:
                 
            xor dx, dx     
            div bx
            add dx, 30h 
            mov [valorAuxiliar + si], dx
            inc si
            
            cmp ax, 0
            jne division
                                     
            call invertir
            
            ret
       
        divisionEuclidea endp
       
    
      invertir proc
                   
        push si ; Contiene la dimension de mi string
        push di

        dec si ; Contiene la dimension de mi string
        mov di, 0h
      
        proceso:  
                
           mov ax, valorAuxiliar[si]     
           mov [operacion + di], ax    
           
           dec si
           inc di
           
           cmp si, 0h
           jne proceso
           
         inc di
         mov operacion[di], "$"         
         
         pop di
         pop si
                     
         ret
        
        invertir endp  
         
         
    terminarPrograma:
        
        mov ah, 04ch
        int 21h      
                
end code
