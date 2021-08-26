.global	_start
.sect .data
	nro1:	.byte 1, 0, 1, 0, 0
	nro2:	.byte 1, 0, 0, 1, 1
	.equ	n,	5
	
.section .text

	main:
		#primer llamada a radixi
		add		$-4, %esp		#resultado de radixi
		push	$nro1			#direccion nro1
		push	$n				#cantidad de bits a tomar del arreglo
		call	radixi			#(%esp) = radixi(nro1, n)
		
		#segunda llamada a radixi
		add		$-4, %esp		#resultado de radixi
		push	$nro2			#direccion nro2
		push	$n				#cantidad de bits a tomar del arreglo
		call	radixi			#(%esp) = radixi(nro2, n)
		
		#suma de ambas llamadas a radixi
		
		#en este momento de la ejecucion la pila se encuentra asi

		#(%esp)	= %ebx = radixi(nro2,n)
		#4(%esp) = radixi(nro1, n)
		#8(%esp) = ret del main

		add		4(%esp), %ebx	#%ebx = radixi(nro1, n) + radixi(nro2, n)
		add		$8, %esp		#limpieza de stack para apuntar a ret
		ret
		
		.equ	res,	16
		.equ	arr,	12
		.equ	size,	8
		.equ	i,		-4

	radixi:
		#%eax = direccion de arr
		#%ebx = donde se arma la respuesta
		#%ecx = auxiliar

		#-4(%ebp) = int i para iterar
		#8(%ebp) = cantidad de bits a tomar del arreglo
		#12(%ebp) = dirección arr
		#16(%ebp) = resultado a retornar

		#debido a logica interna el resultado queda tanto
		#en 16(%ebp) como en %ebx

		#prologo de una funcion
		push	%ebp			
		mov		%esp, %ebp

		#creacion variable local i = size
		mov		size(%ebp), %ecx
		push	%ecx
		
		#logica de radixi
		mov		arr(%ebp), %eax		#%eax = direccion arr
		
		condRadixi:
			decl	i(%ebp)			#i--
			cmp		$0, i(%ebp)
			jge		loopRadixi		#is i >= 0?

			#false
			mov 	$32, %ecx			#%ecx = 32
			sub		size(%ebp), %ecx	#%ecx -= size
			sar 	%cl, %ebx			#extender signo %cl posiciones
			mov		%ebx, res(%ebp)		#return %ebx

			#epilogo de una funcion
			mov		%ebp, %esp
			pop		%ebp
			ret		$8	#limpieza parametros de entrada


		loopRadixi:
			#true
			shr		%ebx				#lugar para nuevo bit
			mov 	i(%ebp), %ecx		#%ecx = i
			movb	(%eax,%ecx,1), %cl	#%cl = arr[i]
			shl		$31, %ecx			#ahora arr[i] es el bit mas significativo de %ecx
			or		%ecx, %ebx			#lo agrego a %ebx
			jmp		condRadixi

	_start:
		call	main			
		mov		$0x1,%eax
		int		$0x80
	
.end