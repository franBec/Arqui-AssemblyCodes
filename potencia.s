#PROGRAMA PRINCIPAL
#OBJETIVO: Calcular 2^3 + 5^2
#
.section .data
#Este programa no tiene variables globales#
.section .text
.globl _start
_start:
#
#calculo de 2^3
pushl $3	#push segundo argumento
pushl $2	#push primer argumento
call power	#llama a la funcion potencia
#ahora el control lo tiene la funcion potencia
#ahora el control volvio al programa princial
addl $8, %esp	#actualiza el tope del stack limpiando parametros ya usados
#ahora eax tiene el resultado de la funcion
pushl %eax	#salva el resultado de 2^3 en el stack
#
#calculo de 5^2
pushl $2 	#push segundo argumento
pushl $5	#push primer argumento
call power 	#llama a la funcion potencia
#ahora el control lo tiene la funcion potencia
#ahora el control volvio al programa princial
addl $8, %esp #actualiza el tope del stack limpiando parametros ya usados
#ahora eax tiene el resultado de la funcion
#
popl %ebx #como el resultado de  2^3 quedo en el stack, es asignado a ebx
addl %eax, %ebx #ebx = ebx + eax
#instrucciones necesarias para terminar el programa
movl $1, %eax
int $0x80
#FIN DEL PROGRAMA
#
#FUNCION POTENCIA
#OBJETIVO: retorna (primer argumento) ^ (segundo argumento)
#
#NOTAS: Esta funcion solamente sirve con valores mayor iguales a 1
#
#VARIABLES:
#
# %eax - auxiliar
# %ebx - almacenara base de la potencia
# %ecx - almacenara exponente de la potencia
#-4(%ebp) - auxiliar: guarda el resultado actual
#
#realmente con eax, ebx, y ecx seria suficiente
#-4(%ebp) esta con fines de mostrar como funciona una variable local
#pero si vamos a ser sinceros, esta estorbando mas que nada
#
.type power, @function
power:
pushl %ebp #agrega %ebp al stack
#Vease a %ebp es como un indice para moverse en el stack
movl %esp, %ebp #pone a %ebp en una "posicion incial"
#posicion incial = lugar del stack que separa los parametros de las variables locales
subl $4, %esp		#se hace lugar para una variable local
movl 8(%ebp), %ebx	#guarda el primer argumento en ebx
movl 12(%ebp), %ecx	#guarda el segundo argumento en ecx
movl %ebx, -4(%ebp)	#guarda lo que tiene ebx (base de la potencia) en la direccion de retorno
#esto es necesario por si el exponente es 1, ya que no habría que hacer nada
#
#LOOP
#
power_loop_start:
cmpl $1, %ecx 			#if(exponente == 1)
je end_power 			#rompe loop
movl -4(%ebp), %eax		#eax = resultado actual
imul %ebx, %eax 		#eax = eax * ebx
movl %eax, -4(%ebp) 	#resultado actual = eax
decl %ecx 				#exponente--
jmp power_loop_start	#reinicia el loop
#
#FIN LOOP
#
end_power:
movl -4(%ebp), %eax #eax = resultado actual
#esto es necesario porque una funcion retorna el valor que haya en eax
#
#instrucciones para finalizar correctamente una funcion
#sin romper nada dentro y fuera de la misma
#
movl %ebp, %esp
popl %ebp
ret