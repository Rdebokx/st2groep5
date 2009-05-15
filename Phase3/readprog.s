.global readprog

.data
filename:	.asciz	"image.bin"

readprog:
	pushl %ebp                      #   push base pointer
	movl    %esp, %ebp				#   copy stack pointer
	
	pushl	$MEM
	pushl	$filename
	call	readimage
	addl	$8,%esp
	
	movl %ebp, %esp       			# clear local variables
	popl %ebp            			# restore base pointer
	ret                   			# return from subroutine
