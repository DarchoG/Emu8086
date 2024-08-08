.model small

.stack 100h

.data

    carpeta db "C:\emu8086\MyBuild\Ejemplo", 0
    archivo db "C:\emu8086\MyBuild\Ejemplo\Ejemplo.txt", 0
    manejador dw 0h
    
    escritura db "Ejemplo"
    longitud EQU $- escritura
    
    lectura db 10 dup ("$")
    
.code

    mov ax, @data
    mov ds, ax 
    
    call crearCarpeta
    call crearArchivo
    call cerrarArchivo
    call abrirArchivo
    call escribirArchivo
    call restablecerPuntero
    call leerArchivo
    call cerrarArchivo
    call borrarArchivo
    call borrarCarpeta
       
    mov ah, 04ch
    int 21h
    
    crearArchivo proc
        
        push ax
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 3Ch
        mov cx, 0h
        lea dx, archivo
        
        int 21h
        
        mov manejador, ax
           
        pop dx
        pop cx
        pop ax   
           
        ret
        
    crearArchivo endp
    
    cerrarArchivo proc
        
        push ax
        push bx
        
        mov ax, 0h
        mov ah, 3Eh
        mov bx, manejador
        
        int 21h
        
        pop bx
        pop ax
        
        ret
              
    cerrarArchivo endp  
    
    abrirArchivo proc
        
        push ax
        push dx
        
        mov ax, 0h
        mov ah, 3Dh
        mov al, 02h
        lea dx, archivo
        
        int 21h
        
        mov manejador, ax
        
        pop dx
        pop ax
        
        ret
               
    abrirArchivo endp
    
    escribirArchivo proc
        
        push ax
        push bx
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 040h
        mov bx, manejador   
        mov cx, longitud
        lea dx, escritura
        
        int 21h
        
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
            
    escribirArchivo endp 
    
    restablecerPuntero proc
        
        push ax
        push bx
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 42h
        mov bx, manejador
        mov cx, 0h
        mov dx, 0h
        
        int 21h
        
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
          
    restablecerPuntero endp
    
    leerArchivo proc
        
        push ax
        push bx
        push cx
        push dx
        
        mov ax, 0h
        mov ah, 3Fh
        mov bx, manejador
        mov cx, longitud
        lea dx, lectura
        
        int 21h
        
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
           
    leerArchivo endp
    
    borrarArchivo proc
        
        push ax
        push dx
        
        mov ax, 0h
        mov ah, 41h
        lea dx, archivo
        
        int 21h
        
        pop dx
        pop ax
        
        ret
        
    borrarArchivo endp
    
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
    
    borrarCarpeta proc
        
        push ax
        push dx
        
        mov ah, 3Ah
        lea dx, carpeta
        int 21h
        
        pop dx
        pop ax
        
        ret
      
    borrarCarpeta endp
    
end code
