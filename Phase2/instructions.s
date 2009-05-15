#####################################################################
# Program name : instructions 				            #
# Description : Contains subroutines which emulate C64 instructions #
# Author : Groep5						    #
#####################################################################


###################
# Use this!!!!
###################
#do_:					# 
#	pushl	%ebp			# Prolog: push the base pointer
#	movl 	%esp, %ebp 		# and copy stack pointer to EBP.
#
#
#	movl 	%ebp, %esp     		# Clear local variables from stack.
#	popl 	%ebp           		# Restore caller’s base pointer.
#	ret				# Return.
###################
#
###################
	
.global do_adc
.global do_asl
.global do_and
.global do_bcc
.global do_bcs
.global do_beq
.global do_bit
.global do_bmi
.global do_bne
.global do_bpl
.global do_brk
.global do_bvc
.global do_bvs
.global do_clc
.global do_cld
.global do_cli
.global do_clv
.global do_cmp
.global do_cpx
.global do_cpy
.global do_dec
.global do_dex
.global do_dey
.global do_eor
.global do_inc
.global do_inx
.global do_iny
.global do_jmp
.global do_jsr
.global do_lda
.global do_ldx
.global do_ldy
.global do_lsr
.global do_nop
.global do_ora
.global do_pha
.global do_php
.global do_pla
.global do_plp
.global do_rol
.global do_ror
.global do_rti
.global do_rts
.global do_sbc
.global do_sec
.global do_sed
.global do_sei
.global do_sta
.global do_stp
.global do_stx
.global do_sty
.global do_tax
.global do_tay
.global do_tsx
.global do_txa
.global do_txs
.global do_tya

do_adc:								
	pushl	%ebp				# Prolog: push the base pointer
	movl 	%esp, %ebp 			# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.
	
do_asl: 						
	pushl	%ebp				# Prolog: push the base pointer
	movl 	%esp, %ebp 			# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret	
do_and:						
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_bcs: 							# Branch on carry set
	
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.


 							# Branch on carry set
								# Setting Negative flag
and_lesser:						
	#call	set_Nflag

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret							# Return.

# Arithmetic shift one bit left

do_bcc: 							# Branch on carry clear
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.


do_beq: 							# Branch on equal
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_bit: 							# Bit test
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_bmi: 							# Branch on result minus
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_bne: 							# Branch on not equal
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_bpl: 							# Branch on result plus
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_brk: 							# Break instruction
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_bvc: 							# Branch on overflow clear
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

## einde pascal's stuk
 

do_bvs: 							# branch on overflow set        
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_clc: 							# clear carry flag              
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_cld: 							# clear decimal mode            
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_cli: 							# clear interrupt disable bit   
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_clv: 							# clear overflow flag           
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_cmp: 							# compare memory and accumulator
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_cpx: 							# compare memory and X register
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_cpy: 							# compare memory and Y register
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_dec: 							# Decrement memory by one
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_dex: 							# Decrement X by one
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_dey: 							# Decrement Y by one
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_eor: 							# Exclusive OR memory with accumulator
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.


## INC to PHP -- Roy
do_inc:				#Increment memory by one
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_inx:				#Increment X register by one
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_iny:				#Increment Y register by one
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_jmp:				#Jump to new location
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.
do_jsr:				#Jump to subroutine
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_lda:				#Load accumulator with memory
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_ldx:				#Load X register with memory
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_ldy:				#Load Y register with memory
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_lsr:				#Logical shift one bit right
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_nop:				#No operation
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_ora:				#OR memory with accumulator
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_pha:				#Push accumulator on stack
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_php:				#Push processor status on stack
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

###  PLA to STA -- Tim ###
do_pla:					# Pull accumulator from stack
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_plp:					# Pull processor status from stack
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_rol:					# Rotate one bit left
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_ror:					# Rotate one bit right
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_rti:					# Return from interrupt
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_rts:					# Return from subroutine
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_sbc:					# Subtract memory from accumulator with borrow
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_sec:					# Set carry flag
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_sed:					# Set decimal mode
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_sei:					# Set interrupt disable status
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_sta:					# Store accumulator in memory
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

### End part Tim ###

### STP  to TYA ###

do_stp:					# Stop processor
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_stx:					# Store the X register in memory
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_sty:					# Store the Y register in memory
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_tax:					# Transfer accumulator to X register
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_tay:					# Transfer accumulator to Y register
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_tsx:					# Transfer stack pointer to X register
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_txa:					# Transfer X register to accumulator
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_txs:					# Transfer X register to stack pointer
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

do_tya:					# Transfer Y register to accumulator
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.


	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.
