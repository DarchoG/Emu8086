.model small ; tiny, small, medium, compact, large
                       
.stack 100h ; Datos de pila 

.data ; Segmento Variables 

    ; Mensajes de control a emitir
      
    primerMensaje db "Escribe el primer numero: ", "$"
    segundoMensaje db 13, "Escribe el segundo numero: ", "$"
    tercerMensaje db 10,13, "Resultado: ", "$"
    cuartoMensaje db " + ", "$"
    quintoMensaje db " = ", "$"
    
    ; Variables numericas contenedoras de mis resultados 
                                             
    primerNumero dw ?
    segundoNumero dw ?
    operacion dw ?
    
    ; Variables contenedoras de caracteres.
    
    primerNumeroString db "$$$$$$$$$"
    segundoNumeroString db "$$$$$$$$$"
    valorAuxiliarString db "$$$$$$$$$"
    resultado db "$$$$$$$$$"
    
    ; Variables auxiliares
         
    valorAuxiliar dw 0h
    bandera dw 0h                                     
    
.code

    mov ax, @data 
    mov ds, ax 
                   
    mov ah, 09h ; Imprimir un string con 09, cargarlo en DX con LEA
    lea dx, primerMensaje
    int 21h
                                          
    lea bx, primerNumeroString 
    call validacionNumero  
    
    lea bx, primerNumeroString
    call convertirNumero
    mov primerNumero, dx
             
    call saltoLinea
      
    mov ah, 09h
    lea dx, segundoMensaje
    int 21h
    
    lea bx, segundoNumeroString
    call validacionNumero
    
    lea bx, segundoNumeroString
    call convertirNumero
    mov segundoNumero, dx
    
    call saltoLinea
         
    mov ah, 09h
    lea dx, tercerMensaje
    int 21h  
                                     
    mov ah, 09h    
    lea dx, primerNumeroString
    int 21h 
    
    mov ah, 09h
    lea dx, cuartoMensaje
    int 21h
    
    mov ah, 09h
    lea dx, segundoNumeroString
    int 21h
    
    mov ah, 09h
    lea dx, quintoMensaje
    int 21h                
    
    call operar
                               
    mov ah, 09h
    lea dx, Resultado
    int 21h
              
    mov ah, 04ch
    int 21h    
    
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
    
    
    validacionNumero proc
    
        push ax
        push bx
        push si
               
        ; Cargar en la pila los datos ingresados, clonar los registros, evitar dejar residuos de su maniupulacion.
        
        xor si, si
        
        leerSiguienteCaracter:
        
        mov ah, 01h ; Ejecutar la funcion 01h de la interrupcion 21h que permite leer un solo caracter, almacenado en al.
        int 21h
                  
        ; Proceso de validacion del numero          
                  
        cmp al, "-" 
            jne procesarDigito; Jump if Not Equal, salto condicional, se produce si la comparacion anterior es falsa.
        cmp si, 0h
            jne terminarLectura
        
        mov [bx + si], al ; Alojar el dato digitado.
        inc si ; Incrementar 1 para comparar la siguiente posicion del string. 
        
        jmp leerSiguienteCaracter
        
        procesarDigito:
            
            cmp al, "0"
                jl terminarLectura ; Jump if Less Than, si es menor que 0 terminar lectura.
            cmp al, "9"
                jg terminarLectura ; Jump if Greater than, si es mayor que 9 terminar lectura.
            
            mov [bx + si], al ; Recorrer una posicion de la lectura del string.
            inc si
            jmp leerSiguienteCaracter
        
        terminarLectura:
            
            mov al, "$"
            mov [bx + si], al
            
            pop si
            pop bx
            pop ax
            
            ret ; Retornar al punto donde se hizo la llamada.
            
    validacionNumero endp
    
    
    convertirNumero proc
                            
         push ax ; Registro para las multiplicaciones.
         push bx ; String con los numeros.
         push cx ; Registro para multiplicar.
         push dx ; Variable contenedora de mi resultado, cambiar la variable dx por temporal ya que el excedente de mul lo coloca ahi
         push si ; Registro empleado para hacer el conteo de lo ciclos.                                                               .
                                      
         bucle:
                           
             mov cl, [bx + si]; Cargar caracteres.
             cmp cl, "$"
             je convertirFinal
             cmp cl, "-"
             je negativo
                  
             mov ax, 0Ah
             mov cx, valorAuxiliar
             mul cx
            
             mov valorAuxiliar, ax
             xor cx, cx
             mov cl, [bx + si]
                    
             sub cl, 30h ; Convertir ASCII a numero.
             add valorAuxiliar, cx
                                                               
             inc si
             jmp bucle
             
             negativo:
          
                mov bandera, 01h
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
            
            cmp bandera, 01h
            je negar
            
            ret
            
            negar:
            
                neg dx
                mov bandera, 0h
                ret
                                     
        convertirNumero endp
             
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
        
        cmp operacion, 0h
        jns positivo
        
        neg operacion
        mov bandera, 01h
            
        positivo:
        
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
                     
            div bx
            add dx, 30h 
            mov [valorAuxiliarString + si], dl
            xor dx, dx 
            inc si
            
            cmp ax, 0
            jne division
            
            cmp bandera, 01h
            jne sinSigno
            
            mov [valorAuxiliarString + si], "-"
            inc si
              
            sinSigno:
                                     
            call invertir
            
            ret
       
        divisionEuclidea endp
       
    
      invertir proc
                 
        push si ; Contiene la dimension de mi string
        push di
        
        dec si
        mov di, 0h
              
        proceso:  
                           
           mov al, valorAuxiliarString[si]     
           mov [Resultado + di], al    
           
           dec si
           inc di
           
           cmp si, -1h
           jne proceso
           
         mov Resultado[di], "$"         
         
         pop di
         pop si
                     
         ret
        
        invertir endp  

end code
