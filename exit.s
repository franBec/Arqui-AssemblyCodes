#Primer programa Assembly
#OBJETIVO: Retornar 0
#
#VARIABLES:
#
# %eax guarda el numero de llamada a sistema (siempre hace eso)
#
# %ebx guarda el return
#
.section .data
.section .text
.globl _start
_start:
movl $1, %eax	#llama al kernel de linux para salir de un programa
movl $0, %ebx	#lo que se va a retornar
int $0x80		#despierta al kernel para que ejecute el comando de salida