.model small

.stack 100h

.data

    carpeta db "C:\emu8086\MyBuild\Estadistica", 0
    nombreArchivo db 64 dup ("$")
    extension db ".txt","$"
    direccionAbsoluta 255 dup ("$")
    handle dw 0
    stringAuxiliar db "$"
    
    primerTextoArchivo db "--- Numeros Registrados ---", 13, 10, 10, "$"

    titulo db "--- Moda, Media y Mediana ---", 13, 10, 10, "$"
    bienvenida db "Escriba los numeros de una sola cifra deseados a interpretar (Enter para terminar su captura).", 13, 10, 10, "- ", "$"
    
    resultados db 13, 10, 10, "--- Resultados --- ", 13, 10, 10, "$"
    promedioTexto db "Media: ", "$"
    medianaTexto db 10, 13, "Mediana: ", "$"
    modaTexto db 10, 13, "Moda: ", "$"
    
    indicacionArchivo db 13, 10, 10,"Ingrese el nombre del archivo a crear", 13, 10, 10, "- ", "$"
    
    primerMensaje db 13, 10, 10, "Se ha registrado satisfactoriamente los datos en la direccion : ", "$"
    segundoMensaje db 13, 10, 10, "Desea borrar el contenido creado? ", 13, 10, 10, "1.- Si", 13, 10, "2.- No", 13, 10, 10, "Como desea operar? ", "$" 
                                     
    datosEntrada db 255 dup ("$")
    cantidadDatos dw 0h
    
    ; Variables necesarias para el metodo de ordenamiento
    
    frecuencia db 10 dup (0h)
    sumaFrecuencias db 10 dup (0h)
    datosEntradaOrdenados 255 dup ("$") 
    
    ; Variables necesarias para alojar el resultado de la Media Aritmetica y Mediana
    
    promedio db "0.000", "$"
    mediana db "0.000", "$"
    moda db 11 dup("$")
    modaValorAlto db 0h
    
   
.code

    mov ax, @data
    mov ds, ax
    
    call inicio
    call capturaNumeros
    call metodoOrdenamiento
    call obtenerPromedio
    call obtenerMediana
    call obtenerModa
    call mostrarResultados
    call crearArchivo
    call menu
    
    mov ah, 04ch
    int 21h
    
    proc inicio
        
        push ax
        push dx
        
        mov ax, 0h
        mov ah, 09h
        lea dx, titulo
        int 21h
        
        mov ah, 09h
        lea dx, bienvenida
        int 21h
           
        pop dx
        pop ax
              
        ret      
    
    inicio endp
    
    capturaNumeros proc
        
        push ax
        push dx
        push si
        
        xor ax, ax
        xor dx, dx
        xor si, si
        
        bucleLectura:
        
            mov ah, 01h
            int 21h
            
            cmp al, 0Dh
            je finLectura
            
            cmp al, "0"
            jl separarInput
            
            cmp al, "9"
            jg separarInput
            
            mov datosEntrada[si], al
            inc si
            
            cmp si, 0FFh
            je finLectura
            
            separarInput:
            
                mov ah, 02h
                mov dl, 02ch
                int 21h
                
                mov ah, 02h
                mov dl, 020h
                int 21h
                
                jmp bucleLectura  
       
       finLectura:
       
            mov cantidadDatos, si
            
            pop si
            pop dx
            pop ax
        
            ret
             
    capturaNumeros endp
    
    metodoOrdenamiento proc ; Counting Sort
        
        push ax
        push bx
        push cx
        push si
        push di
        
        xor ax, ax
        xor bl, bl
        xor si, si
        
        obtenerFrecuencias:
        
            mov bl, datosEntrada[si]
            sub bl, "0"
            
            mov al, frecuencia[bx]
            inc al
            mov frecuencia[bx], al
            
            inc si
            
            cmp si, cantidadDatos
            jne obtenerFrecuencias
           
            xor ax, ax 
            xor si, si      
            
        sumarFrecuencias:
        
            add al, frecuencia[si]
            mov sumaFrecuencias[si], al            
            inc si
            
            cmp si, 0Ah
            jne sumarFrecuencias
            
            xor ax, ax
            xor bx, bx
            xor cx, cx
            xor si, si
            xor di, di 
            
        ordenar:
        
            mov bl, datosEntrada[si]
            sub bl, "0"
            
            mov cl, sumaFrecuencias[bx]
            mov di, cx
            dec di  
            
            add bl, "0"
            
            mov datosEntradaOrdenados[di], bl
            sub bl, "0"
            
            mov cx, di
            mov sumaFrecuencias[bx], cl
            
            inc si 
            
            cmp si, cantidadDatos
            jne ordenar
        
        pop di   
        pop si
        pop cx
        pop bx     
        pop ax        
             
        ret     
                
    metodoOrdenamiento endp 
    
    obtenerDecimales macro numero, cantidad, resultado
        
        local decimales, finalDecimales
        
        push ax
        push bx
        push cx
        push si
        push di
        
        xor si, si
        xor dx, dx
        
        mov bx, cantidad
        div bx
        
        add al, "0"
        mov resultado[si], al
        sub al, "0"
        
        add si, 02h
        mov cx, 0Ah
        
        decimales:
        
            cmp dx, 0h
            je finalDecimales
            
            mov ax, dx
            xor dx, dx 
            mul cx
           
            div bx
            
            add ax,"0"
            mov resultado[si], al
            
            inc si 
            
            cmp si, 05h
            je finalDecimales
            
            jmp decimales     
        
        finalDecimales:
        
        pop di
        pop si
        pop cx
        pop bx
        pop ax       
        
    endm    
    
    obtenerPromedio proc
        
        push ax
        push bx
        push si
        
        xor ax, ax
        xor bx, bx    
        xor si, si    
            
        sumatoria:
        
            mov bl, datosEntrada[si]
            sub bl, "0"
            add ax, bx
            
            inc si
            
            cmp cantidadDatos, si
            jne sumatoria
                                        
            obtenerDecimales ax, cantidadDatos, promedio
            
            pop si
            pop bx
            pop ax
            
            ret
              
    obtenerPromedio endp
    
    obtenerMediana proc
        
        push ax
        push bx
        push cx

        mov ax, cantidadDatos
        mov bx, 02h
        mov dx, 0h
        
        div bx
        
        cmp dx, 0h ; Comprobar paridad
        je par
       
        mov si, ax
        
        mov bl, datosEntradaOrdenados[si]
        xor si, si
        mov mediana[si[], bl
        
        jmp finalMediana    
        
        par:
            
            dec ax
            
            mov bx, ax
            xor ax, ax
            xor cx, cx
            
            mov cl, datosEntradaOrdenados[bx]
            sub cl, "0"
            add ax, cx
                      
            inc bx          
            mov cl, datosEntradaOrdenados[bx]
            sub cl, "0"
            add ax, cx
            
            obtenerDecimales ax, 02h, mediana   
                     
         finalMediana:
         
            pop cx
            pop bx
            pop ax
            
            ret    
                
    obtenerMediana endp
    
    obtenerModa proc
                
        push ax
        push bx
        push si
        push di      
        
        xor ax, ax
        xor bx, bx 
        xor si, si
        xor di, di
        
        bucleModa:
   
            cmp si, 0Bh
            je finModa
            
            mov al, frecuencia[si]
            
            cmp al, modaValorAlto
            jg establecerValorAlto
            
            cmp al, 0h ; Necesario para omitir el caso especial donde valor mas alto es 0.
            je omitirValor  
            
            cmp al, modaValorAlto
            je agregarValorAlto
            
            omitirValor:
            
            inc si
            jmp bucleModa
            
          establecerValorAlto:
            
                mov modaValorAlto, al
                
                restablecerArray:
                
                    cmp di, -1h
                    je restablecerDI ; agregarValorAlto y es restablecido el valor a 0. 
                
                    mov moda[di], "$"
                    dec di
                                  
                    jmp restablecerArray
                    
                    restablecerDI:
                    
                        inc di
                        jmp agregarValorAlto
                                   
          agregarValorAlto:
          
                mov bl, "0"
                add bx, si
                
                mov moda[di], bl
                inc si
                inc di
                
                jmp bucleModa 
          
        finModa:     
                
            pop di
            pop si
            pop bx
            pop ax
            
            ret
   
    obtenerModa endp
    
    mostrarResultados proc
        
        push ax
        push dx
        
        mov ah, 09h
        lea dx, resultados
        int 21h
        
        mov ah, 09h
        lea dx, promedioTexto
        int 21h
        
        mov ah, 09h
        lea dx, promedio
        int 21h
        
        mov ah, 09h
        lea dx, medianaTexto
        int 21h
        
        mov ah, 09h
        lea dx, mediana
        int 21h
        
        mov ah, 09h
        lea dx, modaTexto
        int 21h
        
        mostrarValoresModa:
        
            mov ah, 02h
            mov dl, moda[si]
            int 21h
            
            inc si
            cmp moda[si], "$"
            je omitirComa 
            
            mov ah, 02h
            mov dl, 02ch
            int 21h
                
            mov ah, 02h
            mov dl, 020h
            int 21h
            
            jmp mostrarValoresModa
            
            omitirComa: 

        pop dx
        pop ax
        
        ret
        
    mostrarResultados endp
    
    crearCarpeta proc
            
        push ax
        push dx
            
        mov ah, 39h
        lea dx, carpeta
        int 21h
             
        pop dx
        pop ax
        
        ret
        
    crearCarpeta endp
        
    crearArchivo proc 
        
        push ax
        push bx
        push cx
        push dx        
        push si
        push di
        
        call crearCarpeta
        
        mov ah, 09h
        lea dx, indicacionArchivo
        int 21h
        
        xor si, si
        
        
        obtenerNombre:
        
            mov ah, 01h
            int 21h
            
            cmp al, 0Dh
            je finObtenerNombre
            
            cmp al, "A"
            jl obtenerNombre
            
            cmp al, "z"
            jg obtenerNombre
            
            mov nombreArchivo[si], al
            inc si
            
            cmp si, 3Ah ; 59 en Decimal, 6 caracteres menos por la extension, inicio en 0 y disponer de un caracter "$".
            jne obtenerNombre
            
            finObtenernombre:
            
            xor di, di
            
         agregarExtension:
         
            mov al, extension[di]
            mov nombreArchivo[si], al
            
            inc si
            inc di
            
            cmp di, 04h
            jne agregarExtension
            
            xor si, si
            xor di, di
                     
         generarDireccionArchivo:
         
            mov al, carpeta[si]
            
            mov direccionAbsoluta[si], al
            
            inc si
            
            cmp carpeta[si], 0h ; Caracter Nulo
            jne generarDireccionArchivo
            
            mov direccionAbsoluta[si], "\"
            inc si
            
         copiarNombreArchivo:
         
            mov al, nombreArchivo[di]
            mov direccionAbsoluta[si], al
            
            inc si
            inc di
            
            cmp nombreArchivo[di], "$"
            jne copiarNombreArchivo
            
            mov direccionAbsoluta[si], 0h ; Incorporar el caracter nulo, necesario para indicar el fin de la ruta
            inc si
            
            mov direccionAbsoluta[si], "$" ; Incorporar  un "$" para mostrar en pantalla la direccion final del archivo creado
          
         ; Crear Archivo 
            
         mov ax, 0h
         mov ah, 3Ch
         mov cx, 0h
         lea dx, direccionAbsoluta 
         int 21h
         
         mov handle, ax
         
         ; Cerrar Archivo
         
         mov ax, 0h
         mov ah, 3Eh
         mov bx, handle
         int 21h
         
         ; Abrir Archivo
         
         mov ax, 0h
         mov ah, 3Dh
         mov al, 01h ; Modo Lectura
         lea dx, direccionAbsoluta
         int 21h
         
         mov handle, ax
         
         call escribirArchivo
         call cerrarArchivo
         
         pop di
         pop si
         pop dx
         pop cx
         pop bx
         pop ax
         
         ret
           
  crearArchivo endp
  
  escribirString macro string
    
        local bucleString 
    
        push ax
        push bx
        push cx
        push dx
        push si
        push di
        
        xor si, si
        xor di, di
        
        bucleString:
        
            xor dx, dx 
            
            mov ax, 0h
            mov ah, 40h
            mov bx, handle
            mov cx, 01h
            mov dl, string[si]
            mov stringAuxiliar[di], dl
            mov dx, offset(stringAuxiliar)
            int 21h
            
            inc si
            cmp string[si], "$"
            jne bucleString 
            
            xor si, si
        
        pop di    
        pop si
        pop dx
        pop cx
        pop bx
        pop ax    
    
  endm
  
  escribirLista macro string
    
        local bucleLista bucleListaOmitirComa
        
        push ax
        push bx
        push cx
        push dx
        push si
        push di
        
        xor si, si
        xor di, di
        
        bucleLista:
        
            xor dx, dx
       
            mov ah, 40h
            mov bx, handle
            mov cx, 01h
            mov dl, string[si]
            mov stringAuxiliar[di], dl
            mov dx, offset(stringAuxiliar)
            int 21h
    
            inc si
            cmp string[si], "$"
            je bucleListaOmitirComa
            
            mov ah, 40h
            mov bx, handle
            mov cx, 01h
            mov dl, ","
            mov stringAuxiliar[di], dl
            mov dx, offset(stringAuxiliar)
            int 21h
            
            mov ah, 40h
            mov bx, handle
            mov cx, 01h
            mov dl, " "
            mov stringAuxiliar[di], dl
            mov dx, offset(stringAuxiliar)
            int 21h
            
            jmp bucleLista
            
       bucleListaOmitirComa:
       
       pop di
       pop si
       pop dx
       pop cx
       pop bx
       pop ax  
    
  endm
  
  escribirArchivo proc
        
        push ax
        push bx
        push cx
        push dx
        push si
        
        xor dx, dx
        xor si, si
        
        escribirString primerTextoArchivo
        escribirLista datosEntrada
        escribirString resultados
        escribirString promedioTexto
        escribirString promedio
        escribirString medianaTexto
        escribirString mediana
        escribirString modaTexto
        escribirLista moda
        
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret 
                                 
  escribirArchivo endp
  
  cerrarArchivo proc
    
        push ax
        push bx
        
        mov ax, 0h
        mov ah, 3Eh
        mov bx, handle
        int 21h
        
        pop bx
        pop ax
        
        ret
      
  cerrarArchivo endp
  
  menu proc
        
        push ax
        push dx
        
        mov ah, 09h
        lea dx, segundoMensaje
        int 21h
        
        mov ah, 01h
        int 21h
        
        sub al, "0"
        
        cmp al, 02h
        je  omitirBorrar
        
        mov ah, 41h
        lea dx, direccionAbsoluta
        int 21h
        
        mov ah, 3Ah
        lea dx, carpeta
        int 21h
        
        omitirBorrar:
        
        pop dx
        pop ax
             
        ret
         
  menu endp
                     
end code
