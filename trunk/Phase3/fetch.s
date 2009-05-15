   # ************************************************************************
   # * Program name : Fetch                                                 *
   # * Description  : De fetch subroutine plus een main om hem		    *
   # * 		      te testen						    *
   # * Author       : Pascal Boeschoten  		                    *
   # ************************************************************************
   
.bss

.text
	outputstr:	.asciz "%d\n%d\n"	# output string for number printing
	

   # ************************************************************************
   # * Subroutine : fetch                                                   *
   # * Description : application entry point                                *
   # ************************************************************************
.global fetch

fetch:	
		pushl 	%ebp			# Prolog: push the base pointer
		movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
fetchcycle:	
		movl	$0, %ebx		# Clear EBX
		movw	(PC), %bx			# Move PC to BX
		movw	MEM(%ebx), %ax	# Copy memory location which PC points at to AX
		movb	%al, (IR)			# Copy least sign. 8 bits of EAX (the OpCode) to IR
		
		#call	showi			# Call showi routine
		call 	debug
		cmpb	$0xdb, (IR) 		# Compare IR to "stop" OpCode
		je	endfetch		# If equal, return to main.
		
		call 	decode			# else, call the function in the table : DEBUG: Segfault is caused by Decode!!!!!!!!!!!

else:		
		incw	(PC)			# Else, increment PC
		jmp	fetchcycle		# and restart the cycle.		

endfetch:	
		movl 	%ebp, %esp  		# Clear local variables from stack.
		popl 	%ebp           		# Restore caller’s base pointer.
		ret                 		# Return from subroutine.

