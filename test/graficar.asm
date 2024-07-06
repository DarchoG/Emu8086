org 100

    xor ax, ax
    mov al, 13h
    int 10h
               
    mov ah, 0Ch
    mov al, 01h           
    mov cx, 50h
    mov dx, 3Ch
    
    graficar:
    
        int 10h
        inc cx
        
        cmp cx, 0F0h
        jne graficar
        
        mov cx, 50h
        inc al
        add dx, 05h
        
        cmp al, 10h
        jne graficar
        ret  
