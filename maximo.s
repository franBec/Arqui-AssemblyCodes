#OBJETIVO: Encontrar el mayor de una lista de enteros positivos
#
#VARIABLES:
#
# %edi - indice
# %ebx - auxiliar: guarda el valor mas grande
# %eax - auxiliar: guarda el valor que esta siendo visto por indice
#
# DIRECCIONES DE MEMORIA:
#
# data_items - listado de numeros con marca de fin = 0
#
.section .data
data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
.section .text
.globl _start
_start:
movl $0, %edi 					#indice = 0
movl data_items(,%edi,4), %eax 	#eax = data_items[edi]
movl %eax, %ebx 				#como es el primer elemento, es el mas grande. Entonces ebx = eax
start_loop: 					#inicia loop
cmpl $0, %eax 					#if(data_items[eax]==0)
je loop_exit 					#rompe el loop
incl %edi 						#edi++
movl data_items(,%edi,4), %eax 	#eax = data_items[edi]
cmpl %ebx, %eax 				#if(ebx > eax)
jle start_loop 					#vuelve al inicio del loop
movl %eax, %ebx 				#ebx = eax
jmp start_loop					#vuelve al inicio del loop
loop_exit:						#salida del loop
movl $1, %eax 					#exit(1)
int $0x80 						#ejecuta comando salida