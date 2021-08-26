.section .text
.global _start

main: #pp reside en eax
	for:
		mov $lista,%eax #for(pp=&lista;*pp;)
 		jmp cond
	
	loopf:
		if:
			mov (%eax),%ecx # if((*pp)->clv==5)
 			cmpl $5,clv(%ecx) # *pp=(*pp)->next
			jne else # else
			mov next(%ecx),%ecx # pp=&((*pp)->next)
			mov %ecx,(%eax) # end if
			jmp endif

		else:
			lea next(%ecx),%eax

	endif:
		cond:
			cmpl $NULL,(%eax) #end for
			jne loopf
			ret

_start:
	call main
	mov $1,%eax #call exit
	mov $0,%ebx
	int $0x80

.section .data
	.equ clv,0
 	.equ next,4
 	.equ NULL,0

	lista: .long nodo1
		
		nodo0:	.long 5
 				.long nodo2
		nodo1:	.long 5
 				.long nodo0
		nodo2:	.long 1
 				.long nodo4
		nodo3:	.long 5
				.long NULL
		nodo4:	.long 5
				.long nodo3
.end