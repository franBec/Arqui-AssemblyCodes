.global	_start
.sect .data
	nro1:	.byte	1
			.byte	0
			.byte	1
			.byte	0
			.byte	0

	nro2:	.byte	1
			.byte	0
			.byte	0
			.byte	1
			.byte	1

	.equ	n,	5
	
.section	.text

	main:
		add		$-4, %esp		#dejamos lugar para el resultado de magni
		push	$nro1			#base del arreglo
		push	$n			#tama\~no del arreglo
		call	radixi			#interpretamos el nro 1 en c'2
		pop		%eax			#obtenemos la interpretaci'on
		add		$-4, %esp		
		push	$nro2			#base del arreglo 2
		push	$n			#tama\~no del arreglo 2
		call	radixi			#interpretamos el nro 2 en c'2
		add		(%esp), %eax		#sumamos la interpretaci'on del nro1 con la del nro 2
		add		$4, %esp			#eliminamos el resultado de la pila
		ret
		
		.equ	res,	16
		.equ	rep,	12
		.equ	size,	8
		.equ	i,		-4

	radixi:
		push	%ebp			#guadamos el praa
		mov		%esp, %ebp		#actualizamos la nueva base del reg. activaci'on
		add		$-4, %esp		#lugar para la vble local i
		push	%eax			#guardamos eax porque lo vamos a usar
		push	%ebx			#idem
		push	%ecx			#idem
		mov		rep(%ebp), %eax		#cargamos la base en eax
		#movl	$0, i(%ebp)		# vble i <-- 0
		movl	size(%ebp), %ecx
		decl	%ecx
		movl	%ecx, i(%ebp)	#i = n-1

	for:
		jmp	cond

	.l1:
		shr		%ebx			#hacemos lugar en resultado para agregar un bit del n'umeto
		mov 	i(%ebp), %ecx		#cargo el 'indice en ecx
		movb	(%eax,%ecx,1), %cl	#cargo el elemento rep(i) en cl
		shl		$31, %ecx		#corro el bit 0 al bit 31
		or		%ecx, %ebx		#guardo el bit en el resultado
		incl	i(%ebp)			#incremento i
	cond:
		mov 	size(%ebp), %ecx		#cargo el tama\~no del arreglo
		cmp		%ecx, i(%ebp)		# for(i:=0;i<size;i++)
		jl		.l1
		mov 	$32, %ecx
		sub		size(%ebp), %ecx		# eax <-- 32-(size)
		sar 	%cl, %ebx		# extiendo el signo del resultado
		mov		%ebx, res(%ebp)		# guardo el resultado en la pila
		pop		%ecx
		pop		%ebx
		pop		%eax
		mov		%ebp, %esp		# eliminamos vbles locales
		pop		%ebp			# obtenemos el praa
		ret		$8			# obtenemos la dir de retorno y eliminamos param de entrada

	_start:
		call	main			
		mov		$0x1,%eax
		mov		$0,%ebx
		int		$0x80
	
.end
