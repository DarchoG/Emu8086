#include <stdio.h>
#include <locale.h>

int ensamblador(int Digito);

int main(){

    setlocale(LC_CTYPE, "en_US.UTF-8");

    int numeroPrimo;

    printf("Ingrese el número que desee comprobar si es primo: ");
    scanf("%i", &numeroPrimo);

    int Resultado = ensamblador(numeroPrimo);

    if(Resultado == 0){

        printf("\nEl número %i no es primo.", numeroPrimo);
        return 0;

    }

    printf("\nEl número %i es primo.", numeroPrimo);

    return 0;
}

int ensamblador(int Digito){

    int Primo;

    //Comprobar si un numero es primo

    __asm__ __volatile__(

        //Cargo mis operandos y la variable admitida como parametro de la funcion

        "movl %1, %%eax;" // Numero cargado por la variable parametro
        "movl $2, %%ebx;" // Variable que incrementara en cada bucle para ver si es divisible

        //Casos bases, el 2 es primo y numeros inferiores a 1 no lo son, ya que cuenta el mismo 1 y los negativos

        "cmpl %%ebx, %%eax;"
        "je primo;"

        "cmpl %%ebx, %%eax;"
        "jl divisible;"

        "Ciclo: ;"

            "movl %%eax, %%esi;" // Guardo un respaldo en caso de ser modificado el registro
            "divl %%ebx;"
            "cmpl $0, %%edx;" // Comparo si obtengo 0 de residuo lo que significa que mi valor no es primo al ser divisible por un numero.
            "je divisible;"

            "movl %%esi, %%eax;"// Restauro el dato
            "incl %%ebx;" // Comprobar con el siguiene numero
            "xorl %%edx, %%edx;"

            "cmpl %%eax,  %%ebx;" // En caso de que mi varible sea equitativa al divisor significa que es primo ya que sera divisible solo por 1 y el mismo numero
            "je  primo;"
            "jmp Ciclo;"
            
        "divisible: ;"

            "movl $0, %%ecx;"
            "movl %%ecx, %0;"  
            "jmp Final;"

        "primo: ;"

            "movl $1, %%ecx;"
            "movl %%ecx, %0;"  
            "jmp Final;"

        "Final:;"     

        : "=r" (Primo) // Variable de salida
        : "m" (Digito) // Variable de entrada
        : "%eax", "%ebx", "%ecx", "%edx", "%esi"  // Registros a usar.
    );

    return Primo;
}
