#########################################################
# Name: operand_fetch					#
# Description: provides operand fetches			#
#	       for the different adressing modes.	#
# Author: Pascal Boeschoten				#
#########################################################

.text 
formstr: 	.asciz "De eax is: %x\n"


# Refer to manual (3.5) for description of adressing modes

.global fetch_abs 
.global fetch_abX
.global fetch_abY 
.global fetch_acc
.global fetch_imm 
.global fetch_ind
.global fetch_inX
.global fetch_inY
.global fetch_rel
.global fetch_zp
.global fetch_zpX
.global fetch_zpY 



fetch_abs:							#werkt mischien...
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	movl 	$0, %ecx 		# clear the ecx
	incw	PC 			# increase the program counter
	movw 	PC, %cx			# get PC in bx

	movl	$0, %eax		# clear %eax
	movb	MEM(%ecx), %al		# get seccond byte and put it in the %eax (ADL)
	incw	%cx			# increase 
	movb	MEM(%ecx), %ah		# get third byte and put it in the %ebx (ADH)
	addl 	$MEM, %eax 		# move the return value to %eax
	incw	PC			# increment the Program Counter


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

fetch_abX:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	######## FETCH_ABS ##############

	movl 	$0, %ecx 		# clear the ecx
	incw	PC 			# increase the program counter
	movw 	PC, %cx			# get PC in bx

	movl	$0, %eax		# clear %eax
	movb	MEM(%ecx), %al		# get seccond byte and put it in the %eax (ADL)
	incw	%cx			# increase 
	movb	MEM(%ecx), %ah		# get third byte and put it in the %ebx (ADH)

	####### END ####

	addb	X, %al			# add register X to ADH:ADL
	#movl 	MEM(%eax), %eax 	# move the return value to %eax
	addl 	$MEM, %eax 		# move the return value to %eax
	incw	PC			# increment the Program Counter

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

fetch_abY:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	#call 	fetch_abs		# get ADH:ADL

	###### FETCH_ABS #############

	movl 	$0, %ecx 		# clear the ecx
	incw	PC 			# increase the program counter
	movw 	PC, %cx			# get PC in bx

	movl	$0, %eax		# clear %eax
	movb	MEM(%ecx), %al		# get seccond byte and put it in the %eax (ADL)
	incw	%cx			# increase 
	movb	MEM(%ecx), %ah		# get third byte and put it in the %ebx (ADH)

	####### END ####

	addb	Y, %al			# add register Y to ADH:ADL
	#movl 	MEM(%eax), %eax 	# move the return value to %eax
	addl 	$MEM, %eax
	incw	PC			# increment the Program Counter

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_acc:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	movl	$0, %eax		# clear %eax
	leal 	A, %eax 		# return register A
#	incw 	PC 			# increments the program counter
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_imm:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	incw	PC
	movl 	$0, %ebx
	movzwl 	PC, %eax		# get PC in ax (zero extend)
	addl 	$MEM, %eax
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_ind:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	######## FETCH_ABS ##############

	movl 	$0, %ecx 		# clear the ecx
	incw	PC 			# increase the program counter
	movw 	PC, %cx			# get PC in bx

	movl	$0, %eax		# clear %eax
	movb	MEM(%ecx), %al		# get seccond byte and put it in the %eax (ADL)
	incw	%cx			# increase 
	movb	MEM(%ecx), %ah		# get third byte and put it in the %ebx (ADH)

	####### END ####
	
	movl	$0, %ebx
	movb	MEM(%eax), %bl		# get the value at ADH:ADL and put it in %ebx
	incl	%eax			# increase %eax
	movb	MEM(%eax), %bh		# get the value at ADH:ADL +1 and save it in %eax
	movl	%ebx, %eax	
	
	#movl 	MEM(%eax), %eax 	# move the return value to %eax
	addl 	$MEM, %eax
	incw	PC				# increment the Program Counter
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_inX:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	movzwl 	PC, %ebx		# get PC in bx (zero extend to ebx)
	incb 	%bl			# increase program counter
	movl	$0, %eax		# clear %eax
	movb	MEM(%ebx), %al		# get seccond byte and put it in the %eax (ADL)
	addb	X, %al			# add X to %eax (ADL)

	movl	MEM(%eax), %ebx		# get the value at 00:ADL+X and put it in %ebx
	incl	%eax			# increase %eax
	movl	MEM(%eax), %eax		# get the value at ADH:ADL +1 and save it in %eax
	sal	$8, %eax		# shift %eax 1 byte further
	addl	%ebx, %eax		# add %ebx to %eax 
	#movl 	MEM(%eax), %eax 	# move the return value to %eax
	addl 	$MEM, %eax
	incw	PC				# increment the Program Counter
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_inY:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movzwl 	PC, %ebx		# get PC in bx (zero extend to ebx)
	incb 	%bl			# increase program counter
	movl	$0, %eax		# clear %eax
	movb	MEM(%ebx), %al		# get seccond byte and put it in the %eax (ADL)

	movl	MEM(%eax), %ebx		# get the value at 00:ADL and put it in %ebx
	incl	%eax			# increase %eax
	movl	MEM(%eax), %eax		# get the value at ADH:ADL +1 and save it in %eax
	sal	$8, %eax		# shift %eax 1 byte further
	addl	%ebx, %eax		# add %ebx to %eax 

	addb	Y, %al			# add Y to the %eax
	incw	PC			# increment the Program Counter
	#movl 	MEM(%eax), %eax 	# move the return value to %eax
	addl 	$MEM, %eax
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_rel:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	incw 	PC 			# increment PC because we need PC + 1

	movzwl 	PC, %ebx		# get PC in bx (zero extend to ebx)
	incw 	%bx			# increase program counter value
	movl	$0, %eax		# clear %eax
	#movb	MEM(%ebx), %al		# get second byte and put it in the %eax (offset)
	addl 	$MEM, %eax
	
	addl	PC, %eax		# PC + offset
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_zp:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	
	incw	PC
	movzwl 	PC, %ebx		# get PC in bx (zero extend to ebx)
	
	movl	$0, %eax		# clear %eax
	movb	MEM(%ebx), %al		# get seccond byte and put it in the %eax (ADL)
	addl 	$MEM , %eax

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_zpX:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	######### FETC_zp ######

	incw	PC			# increment the Program Counter
	movzwl 	PC, %ebx		# get PC in bx (zero extend to ebx)
	movl	$0, %eax		# clear %eax
	movb	MEM(%ebx), %al		# get seccond byte and put it in the %eax (ADL)

	###### END

	addb	X, %al			# add X register to %eax
	addl 	$MEM, %eax


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_zpY:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	###### FETCH_ZP

	incw	PC			# increment the Program Counter
	movzwl 	PC, %ebx		# get PC in bx (zero extend to ebx)
	movl	$0, %eax		# clear %eax
	movb	MEM(%ebx), %al		# get seccond byte and put it in the %eax (ADL)

	###### END

	addb	Y, %al			# add Y register to %eax	
	addl 	$MEM, %eax

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	
