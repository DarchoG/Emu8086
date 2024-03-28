.model small

.stack 100h

.data
    
    primerNumero dw ?
    segundoNumero dw ?
    
.code

   mov ax, @data
   mov ds, ax
   
   mov primerNumero, 05h
   mov segundoNumero, 07h
   
   neg segundoNumero
   
   mov bx, primerNumero
   add bx, segundoNumero
   
   cmp bx, 0
   jl negativo:
   
   mov ah, 04ch
   int 21h
   
   negativo:
   
   neg bx
         
end code    
