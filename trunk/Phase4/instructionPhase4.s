-BCC
-BCS
-BEQ
-BMI
-BNE
-BPL
-BRK
-BVC
-BVS
-CLI
-JMP
-JSR
-RTI
-RTS


	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return. 

do_bcc:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return. 

   # ***********************************************************************
   # * Subroutine name : TOBCD						   *
   # * Description     : returns the bcd value of the parameter in %eax	   *
   # * 			Push the value you want to convert before you call *
   # * Author          : Tim & Gerbert					   *
   # ***********************************************************************
tobcd:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer

	movl	$0, %ebx		# clear %ebx
	movb	8(%ebp), %bl		# get value and move it to %ebx
	
	call	set_flag_decimal	# set's the decimal flag to 1
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return. 

   # ***********************************************************************
   # * Subroutine name : FROMBCD					   *
   # * Description     : returns the normal value of the parameter in %eax *
   # * 			Push the value you want to convert before you call *
   # * Author          : Tim & Gerbert					   *
   # ***********************************************************************

frombcd:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer

	movl	$0, %eax
	movl	$0, %ebx
	movl 	$0, %ecx
	movb	8(%ebp), %al
	movb	%al, %bl
first_bit:
	movb	%bl, %cl
	andb	$0b10000000, %cl
	jz	seccond_bit
	subb	%al, $48
seccond_bit:
	movb	%bl, %cl
	andb	$0b01000000, %cl
	jz	third_bit
	subb	%al, $24
third_bit:
	movb	%bl, %cl
	andb	$0b00100000, %cl
	jz	fourth_bit
	subb	%al, $12
fourth_bit:
	movb	%bl, %cl
	and	$0b00010000, %cl
	jz	from_bcd_end
	subb	%al, $6

from_bcd_end:
	call	reset_flag_decimal	# sets the decimal flag to false

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return. 


0010 0000 to
0001 0010
1001 0000 to
0101 1010
1001 1001 to
0110 0011

vanaf 10 is het -6

	






   # ***********************************************************************
   # * Subroutine name : SED (Set Decimal flag)				   *
   # * Description     : The SED instruction sets the decimal flag of the P*
   # *					 register to 1.			   *
   # * Author          : Tim					   	   *
   # ***********************************************************************
do_sed:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	call	set_flag_decimal	# set decimal flag to 1

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

   # ***********************************************************************
   # * Subroutine name : SEI (Set interrupt flag)			   *
   # * Description     : The SEI instruction sets the interrupt flag of the P  *
   # *					 register to 1.			   *
   # * Author          : Tim					   	   *
   # ***********************************************************************
do_sei:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	call	set_flag_interrupt	# set interrupt flag to 1

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.
