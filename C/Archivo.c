#include <stdio.h>
#include <locale.h>

int ensamblador(int Digito);

int main(){

    setlocale(LC_CTYPE, "Spanish");

    int numeroPrimo;

    printf("Ingrese el numero que desee comprobar si es primo: ");
    scanf("%i", &numeroPrimo);

    ensamblador(numeroPrimo);

    return 0;
}

int ensamblador(int Digito){

    int Primo = 1;

    asm(
        
        "movl 0x01h, %%eax;"
        "movl %1, %%ebx;"
        "movl %2, %%ecx;"

        "Ciclo: ;"

            "movl %%ebx, %%esi;"
            "divl %%ebx;"
            "cmpl $0, %%edx;"
            "je divisible;"

            "movl %%esi, %%ebx;"
            "incl %%eax;"

            "cmpl %%ebx,  %%eax;"
            "je  Final;"
            "jmp Ciclo;"
            
        "divisible: ;"

            "movl $0, %%ecx;"  
            "jmp Final;"

        "Final:;"     

        : "=r" (Primo)
        : "m" (Digito)
        : "%ecx"
    );

    return Primo;
}
