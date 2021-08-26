#OBJETIVO: Calcular 4!
#
#NOTAS: El programa no funciona correctamente con un factorial mayor a 5
#pues el resultado supera 255 y assembly se rompe
#
.section .data
#Este programa no tiene variables globales
.section .text
.globl _start
_start:
pushl $4		#numero al que se le va a calcular el factorial
call factorial 	#ejecuta la funcion factorial
popl %ebx 		#buena practica de programacion: limpiar lo que quede en el stack
movl %eax, %ebx #resultado de factorial esta en eax, lo movemos a ebx para retornarlo
#salida del programa
movl $1, %eax
int $0x80
#FIN DEL PROGRAMA PRINCIPAL
#
#FUNCION FACTORIAL
.type factorial,@function
factorial:
#procedimiento estandar para iniciar cualquier funcion
pushl %ebp
movl %esp, %ebp
#
movl 8(%ebp), %eax 	#eax = N
cmpl $1, %eax		#if(N==1)
je end_factorial	#fin factorial
decl %eax 			#eax = N-1
pushl %eax 			#inserto eax al stack para ser usado por siguiente llamada a factorial
call factorial 		#factorial(tope del stack) = factorial(N-1)
#para este punto del programa, eax tiene el resultado de la llamada a factorial
popl %ebx 			#ebx = pop stack = N-1
incl %ebx 			#ebx++ ---> ebx = N
imul %ebx, %eax 	#eax = eax * ebx ---> eax = N*(N-1)
end_factorial:
#procedimiento estandar para terminar cualquier funcion
movl %ebp, %esp
popl %ebp
ret