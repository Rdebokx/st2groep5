#****************************************************
#* Subroutine: debug	          		    *
#* Description:					    *
#* Author: groep 5				    *
#**************************************************** 

.text
showA:		.asciz	"A-Register: 0x%d\n"
showX:		.asciz	"X-Register: 0x%d\n"
showY:		.asciz	"Y-Register: 0x%d\n"
showS:		.asciz	"S-Register: 0x%d\n"
showP:		.asciz	"P-Register: 0x%d\n"
showPC:		.asciz	"Program Counter: 0x%x\n"
showOpcode:	.asciz	"Opcode: 0x%x\n"

.global debug
.global showi
debug:
	pushl	%ebp			# push stack base pointer
	movl	%esp,%ebp		# esp becomings new esb
	
	call 	showi			#output PC en IR

	movzbl	A, %eax			# move 8-bit A-Register to stack as param
	pushl	%eax
	pushl	$showA			# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack
	
	movzbl	X, %eax			# move 8-bit X-Register to stack as param
	pushl	%eax
	pushl	$showX			# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack

	movzbl	Y, %eax			# move 8-bit Y-Register to stack as param
	pushl	%eax
	pushl	$showY			# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack

	movzbl	S, %eax			# move 8-bit S-Register to stack as param
	pushl	%eax
	pushl	$showS			# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack

	movzbl	P, %eax			# move 8-bit P-Register to stack as param
	pushl	%eax
	pushl	$showP			# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack
	
	movl	%ebp,%esp		# reset the stack pointer
	popl	%ebp			# pops the base pointer
	ret


#****************************************************
#* Subroutine: showi 				    *
#* Description:	display the current program counter *
#*				display the opcode  *
#* Author: Gerbert van Nieuwaal			    *
#****************************************************
showi:
	pushl	%ebp			# push stack base pointer
	movl	%esp,%ebp		# esp becomings new esb


	movzwl	PC, %eax		# move 16-bit program counter to stack as param
	pushl	%eax
	pushl	$showPC			# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack
	
	movzbl	IR, %eax		# move 8-bit instruction register to stack as param (opcode)
	pushl	%eax
	pushl	$showOpcode		# string for printing
	call	printf			# call printf
	movl	%ebp,%esp		# reset stack
	
	movl	%ebp,%esp		# reset the stack pointer
	popl	%ebp			# pops the base pointer
	ret				# return



