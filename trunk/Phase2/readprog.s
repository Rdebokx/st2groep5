.data
filename:	.asciz	"image.bin"

.global readprog
readprog:
	pushl 	%ebp					#   push base pointer
	movl    %esp, %ebp				#   copy stack pointer
	
	pushl	$MEM					#put MEM on the stack
	pushl	$filename				#put the file name of the program on the stack
	call	readimage				#call readimage. This will use the pushed variables of the stack
	addl	$8,%esp					#"remove" variables from stack
	
	movl %ebp, %esp       			# clear local variables
	popl %ebp            			# restore base pointer
	ret                   			# return from subroutine
