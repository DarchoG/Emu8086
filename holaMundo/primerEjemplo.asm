org 100h ; Empezar en la direccion 100h.
    
   jmp start ; Salto incondiconal, por lo tanto siempre ocurre, para evitar ejecutar. 

   string db "Hello World", "$" ; Las variables necesitan disponer de un "$" al final para ser mostradas en pantalla con la interrupcion.
   
   start: ; Etiqueta definida para realizar saltos.
   
   ; Uso de la interrupcion 21h 09h, espera en DX la posicion de memoria de la variable a imprimir.   

   mov ah, 09h
   lea dx, string ; LEA = Load Effective Address, carga la dirección de memoria de la variable string.
   int 21h
