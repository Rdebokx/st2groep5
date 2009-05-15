#########################################################
# Name: operand_fetch					#
# Description: provides operand fetches			#
#	       for the different adressing modes.	#
# Author: Pascal Boeschoten				#
#########################################################



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
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

fetch_abX:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

fetch_abY:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_acc:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_imm:				# NIET AF
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_ind:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_inX:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_inY:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_rel:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_zp:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_zpX:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	

fetch_zpY:
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	
