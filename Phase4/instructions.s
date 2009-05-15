# ***********************************************************************
   # * Program name : instructions	                                       *
   # * Description  : Contains emulated C64 instructions				   *
   # * Author       : Groep 5  						   					   *
   # ***********************************************************************
.global do_adc
.global do_and
.global do_asl
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

# Flags work as following
# call set_flag_<type flag>		#sets the flag to true
# call reset_flag_<type flag>	#sets the flag to false


   # ***********************************************************************
   # * Subroutine name : ADC (Add memory to accumulator with carry)        *
   # * Description     : The ADC instruction adds a value from memory, the *
   # *					 current accumulator value and the carry, and	   *
   # *					 stores the result in the accumulator. It affects  *
   # *					 the carry, overflow, negative, and zero flags.    *
   # *					 ADC can very well handle negative numbers, using  *
   # *					 2's complement notation. In that case, you have   *
   # *					 to pay attention to the negative and overflow     *
   # *					 flags, but don't need to worry about the carry    *
   # *					 flag (which will be set, but is not of interest   *
   # *					 to the user).									   *
   # *					 The negative flag is simply set to the value of   *
   # *					 bit 7 of the result. The overflow flag is a       *
   # *					 little trickier: it indicates that a carry has    *
   # *					 occurred from the 7 least significant bits into   *
   # *					 bit 7 (recall that the least significant bit is   *
   # *					 bit 0). This allows you to check whether the	   *
   # *					 range of a signed 8-bits number (consisting of a  *
   # *					 sign bit and seven value bits) has been exceeded. *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************

do_adc: 							# Decrement Y by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	call 	isset_flag_carry
	cmp	$0,%eax					# check if carry is true
	je	adc_reset_x86carry		# if so, reset x86 carry to false
	
	stc								# else, set x86 carry
	jmp	adc_add					# jump to next

adc_reset_x86carry:
	clc								# set x86 carry
	
adc_add:
	movl	$0, %ebx				# clear ebx
	movl 	8(%ebp) , %ecx		# move the addres of the source to the %ecx
	movb 	(%ecx), %bl 		# move the value to %bl

	adcb	A,%bl					# add A and memory content with carry
	
	jnc		adc_carry_flag_off		# jmp if no carry
	call	set_flag_carry			# else, set carry flag to false
	jmp		adc_overflow			# and jump to next
	
adc_carry_flag_off:
	call	reset_flag_carry		# set carry flag to false
	
adc_overflow:
	jno		adc_overflow_flag_off	# jmp if no x86 overflow
	call	set_flag_overflow		# set zero flag to false
	jmp	adc_end			# jump to next

adc_overflow_flag_off:
	call	reset_flag_overflow		# set zero flag to true

adc_end:	
	movl	$0, %eax		#clear eax
	movl	A, %eax		#move A-register in eax
	call	do_flag_zn		#do the zero and negative flag

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret							# Return.


   # ***********************************************************************
   # * Subroutine name : AND ("AND" memory with accumulator)   	           *
   # * Description     : The AND instruction performs a bitwise AND		   *
   # *					 operation on the value in memory and the 		   *
   # *					 accumulator									   *
   # * Author          : Gerbert & Tim				   					   *
   # ***********************************************************************

do_and: 						
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %ebx		# clear ebx
	movl	8(%ebp), %ebx		# move parameter to ebx
	andb	A, %bl		# AND on A register of C64
	movl	$0, %eax		# clear %eax
	movl	A, %eax		# move value to %eax
	call	do_flag_zn		# set/resset zero and negative flag
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret							# Return.


   # ***********************************************************************
   # * Subroutine name : ASL (Arithmatic shift one bit left)   	           *
   # * Description     : The ASL instruction shifts the value in the accumulator
   # *					 or the memory one bit to the left        		   *
   # * Author          : Gerbert			   					   *
   # ***********************************************************************

do_asl:
	pushl	%ebp				# Prolog: push the base pointer
	movl 	%esp, %ebp 			# and copy stack pointer to EBP.

	movl	$0, %ebx			# clear ebx
	movl	8(%ebp), %ebx		# move parameter to ebx
	#shlb	%bl, A				# bitshift left on A register of C64
	shlb	%bl					# bitshift
	movb	%bl, A				# move bitshifted value to C64 A Register
	jc		asl_carry			# jump if carry occurs to asl_carry
	#call	reset_Cflag			# else reset C64 Carry flag
	jmp		asl_end				# jump to end
	
asl_carry:
	#call	set_Cflag			# set C64 Carry flag
		
asl_end:
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret							# Return.

do_bcc:
do_bcs:
do_beq:
	ret

do_bit:
do_bmi:
do_bne:
do_bpl:
do_brk:
do_bvc:
do_bvs:
	ret

   # ***********************************************************************
   # * Subroutine name : CLC (Clear carry flag)              	           *
   # * Description     : The CLC instruction sets the carry flag of the    *
   # *					 P register to 0.								   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_clc: 							# Clear carry flag
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	call	reset_flag_carry		# sets the carry flag to 0
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine
	
   # ***********************************************************************
   # * Subroutine name : CLD (Clear decimal flag)           	           *
   # * Description     : The CLV instruction sets the decimal flag of the  *
   # *					 P register to 0.								   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_cld: 							# Clear decimal flag
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	call	reset_flag_decimal		# sets the decimal flag to 0
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : CLI (Clear interrupt disable flag)                *
   # * Description     : The CLV instruction sets the interrupt disable    *
   # *					 flag of the P register to 0.					   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_cli: 							# Clear interrupt disable flag
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	call	reset_flag_interrupt	# sets the interrupt disable flag to 0
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : CLV (Clear overflow flag)           	           *
   # * Description     : The CLV instruction sets the overflow flag of the *
   # *					 P register to 0.								   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_clv: 							# Clear overflow flag
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	call	reset_flag_overflow		# sets the overflow flag to 0
	
	movl 	%esp, %ebp 		# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

do_cmp:
do_cpx:
do_cpy:
	ret

   # ************************************************************************
   # * Subroutine name : DEC (Decrement Memory  by one)           	   		*
   # * Description     : The DEC instruction subtracts one from the value  	* 
   # * 			 at the effective memory addres. 		   					*
   # *			 The zero and negative flags are affected depending			*
   # *			 on the new value 				   							*
   # * Author          : Jelle					   	   						*
   # ************************************************************************
do_dec: 							# Decrement Memory by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	movl	$0, %eax				#	clear %eax
	movl	$0, %ebx				#	clear %ebx
	movb    8(%ebp), %al			#   Move the memory addres to %eax
	movb    8(%ebp), %bl 			#   Move the memory value to %ebx
	decb	%bl 					#   Decrease %ebx with one (the memory value)
	movb 	%bl, 8(%ebp) 			#   Move the decreased memory value to the real Memory 
	movl    $0 , %eax 			# Clear the eax 
	movb    %bl , %al 			# move value to the eax to set the flags
	call 	do_flag_zn  			# set the negative and zero flags

	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : DEX (Decrement X by one)           	           *
   # * Description     : The DEX instruction subtracts one from the value  *
   # *					 in the X register. The negative and zero flags    *
   # *					 are affected depending on the new X register	   *
   # *					 value.											   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_dex: 							# Decrement X by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	decb	X						# X--
		
	movl    $0 , %eax 			# Clear the eax 
	movl    X , %eax 			# move value to the eax to set the flags
	call 	do_flag_zn  			# set the negative and zero flags
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : DEY (Decrement Y by one)           *
   # * Description     : The DEY instruction subtracts one from the value  *
   # *					 in the Y register. The negative and zero flags    *
   # *					 are affected depending on the new Y register	   *
   # *					 value.											   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_dey: 							# Decrement Y by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	decb	Y						# Y--
	movl    $0 , %eax 			# Clear the eax 
	movl    Y , %eax 			# move value to the eax to set the flags
	call 	do_flag_zn  			# set the negative and zero flags
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ************************************************************************
   # * Subroutine name 	: EOR ("Exclusive OR" memory with accumulator)	    *
   # * Description     	: The EOR instruction performs a bitwise XOR	 	*
   # *				  	  operation on the value in memory and the			*
   # * 					  accumulator value. The result is stored in the 	*
   # *					  accu mulator. The zero and negative flags are		*
   # * 					  affected depending on the result					*
   # * Author          	: Pascal											*
   # ************************************************************************

do_eor: 						
	pushl	%ebp				# Prolog: push the base pointer
	movl 	%esp, %ebp 			# and copy stack pointer to EBP.

	movl	$0, %eax			# clear eax
	movl	$0, %ebx			# clear ebx
	movb	8(%ebp), %bl		# move parameter to ebx
	movb	A, %al				# move C64 A Register to eax
	xorb	%al, %bl				# AND on A register of C64
	movb	%al, A				# Move result to A

	call 	do_flag_zn  			# set the negative and zero flags
	movl 	%ebp, %esp 				# Copy stack pointer to ESP
	popl 	%ebp					# Restore base pointer
	ret								# Return from subroutine

   # ***********************************************************************
   # * Subroutine name : INX (Increment X by one)           	           	*
   # * Description     : The INX instruction decrements one from the value 	*
   # *		       	 in the X register. The negative and zero flags    		*
   # *			 are affected depending on the new X register	   			*
   # *					 value.				   								*
   # * Author          : Jelle					   							*
   # ***********************************************************************
do_inx: 							# Increment X by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	incb	X						# X++
	movl    $0 , %eax 			# Clear the eax 
	movl    X , %eax 			# move value to the eax to set the flags
	call 	do_flag_zn  			# set the negative and zero flags

	movl 	%esp, %ebp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine


   # ***********************************************************************
   # * Subroutine name : INY (Increment Y by one)           		   		*
   # * Description     : The DEY instruction increments one from the value 	*
   # *			 in the Y register. The negative and zero flags    			*
   # *			 are affected depending on the new Y register	   			*
   # *					 value.				   								*
   # * Author          : Jelle	   					   						*
   # ***********************************************************************
do_iny: 							# Increment Y by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	incb	Y						# Y++
	movl    $0 , %eax 			# Clear the eax 
	movl    Y , %eax 			# move value to the eax to set the flags
	call 	do_flag_zn  			# set the negative and zero flags
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine


   # ***********************************************************************
   # * Subroutine name : INC (Increment memory by one)                     	*
   # * Description     : The INC instruction increments the memery with one	*
   # * Author          : Jelle 						   						*
   # ***********************************************************************
do_inc: 							# Increment Memory by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	movl	$0, %eax				#	Clear %eax
	movl 	$0, %ebx 		# clear %ebx
	movl 	$0, %ecx 		# clear %ecx
	movl 	8(%ebp) , %ecx		# move the addres of the source to the %ecx
	movb 	(%ecx), %bl 		# move the value to %bl
	incb 	%bl 			# increment bl
	movb 	%bl, %al 		# move the value of ebx to eax for setting the flags
	call 	do_flag_zn 	 	# Set the negative and zero flags
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

do_jmp:
do_jsr:
	ret

   # ***********************************************************************
   # * Subroutine name : LDA to LDY											*
   # * Description     : load operations				   					*
   # * Author          : Tim					   					   		*
   # ***********************************************************************
do_lda:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movb	8(%ebp), %al		# Get memory from adres %eax and put it in temp
	movb	%al, A		# Move the value into the accumulator
	call	do_flag_zn		# correct the zero and negative flags

	movl 	%ebp, %esp 		# copy stack pointer to ESP
	popl 	%ebp			# restore base pointer
	ret				# return from subroutine

do_ldx:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movb	8(%ebp), %al		# Get memory from adres %eax and put it in temp
	movb	%al, X		# Move the value into the X-register
	call	do_flag_zn		# correct the zero and negative flags

	movl 	%ebp, %esp 		# copy stack pointer to ESP
	popl 	%ebp			# restore base pointer
	ret				# return from subroutine

do_ldy:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movb	8(%ebp), %al		# Get memory from adres %eax and put it in temp
	movb	%al, Y		# Move the value into the Y-register
	call	do_flag_zn		# correct the zero and negative flags

	movl 	%ebp, %esp 		# copy stack pointer to ESP
	popl 	%ebp			# restore base pointer
	ret				# return from subroutine


   # ***********************************************************************
   # * Subroutine name : LSR (logical shift right)          *
   # * Description     : The LSR instruction shifts the value in the memory address one bit to the right
   # * Author          : Jelle & Tim 					   					   *
   # ***********************************************************************
do_lsr:

	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	movl 	$0, %ebx 		# clear %ebx
	movl 	$0, %ecx 		# clear %ecx
	movl 	8(%ebp) , %ecx		# move the addres of the source to the %ecx
	movb 	(%ecx), %bl 		# move the value to %bl
	call 	 isset_flag_carry 	# check if the carry flag is set , returns in %eax 
	cmp 	$0, %eax		# if there isn't a carry jump else just do ROL	
	je 	carry_off_lsr 		# else just rsll

carry_on_lsr:
		
	stc 	 		# set the intel carry flag
	jmp 	do_lsr_func 	# Jump  to subroutine for logical shift

carry_off_lsr: 			
	clc 			# clear the intel carry flag
		
do_lsr_func:

	shrb 	%bl 	 	# logic shift right
	movl 	%ebx, %eax 	# move the value of %ebx to %eax 
	call 	do_flag_zn 	# set the negative and zero flag
	movl 	%ebx, (%ecx) 	# move the new value to the memory addres or accumulator	
	jc 	lsr_carry_on    # set the carry flag
	jmp	lsr_carry_off   # set the carry flag off

lsr_carry_on:
	call 	set_flag_carry  # set the carry flag
	jmp 	do_end_lsr  	# jump to the end

lsr_carry_off:
	call 	reset_flag_carry # reset the carry flag

do_end_lsr:	
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret						# return from subroutine
	
   # ***********************************************************************
   # * Subroutine name : NOP (No operation)						           *
   # * Description     : The NOP instruction does nothing.				   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_nop: 							
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : ORA ("OR" memory with accumulator)    	           	*
   # * Description     : The ORA instruction performs a bitwise or 			*
   # *					 operation on the value in the memory and the 	 	*
   # *					 accumulator										*
   # * Author          : Roy						   					   	*
   # ***********************************************************************
do_ora:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movl	$0, %ebx				# clear EBX
	movb	A, %bl				# store the value of the accumulator in EBX
	movl	8(%ebp), %eax			# store the value of the place in the memory where the stackpointer points to, in EAX
	orl		%ebx, %eax				# perform a bitwise or operation on EBX and EAX (value of accumulator and memory), result is in EAX
	movl	%eax, A					# move the result to the Accumulator
	
	call	do_flag_zn				# set negative and zero flag if necessary, depending on eax
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine



   # ***********************************************************************
   # * Subroutine name : PHA (Push acumulator on stack)        	           	*
   # * Description     : The PHA instruction pushes the value of the		*
   # *					 acumulator on the stack and decreases the stack- 	*
   # *					 pointer											*
   # * Author          : Roy						   					   	*
   # ***********************************************************************
do_pha:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	movl 	$0, %ebx	
	movl	$0, %eax				# clear EAX
	movb	A, %al				# Store the value of the Acumulator in EAX
	movb	S, %bl				# Store the value of the Stackpointer in EBX
	addl $256, %ebx				# move 256 to ebx , because locations in memory is 01:ff
	movl	%eax, MEM(%ebx)			# Move the value of the acumulator to the stack
	decb	S						# Decrease the Stackpointer
       
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine



   # ***********************************************************************
   # * Subroutine name : PHP (Push Processorstatus on stack)   	           	*
   # * Description     : The PHP instruction pushes the value of the		*
   # *					 P register on the stack and decreases the stack- 	*
   # *					 pointer											*
   # * Author          : Roy						   					   	*
   # ***********************************************************************
do_php:		# ok
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	movl	$0, %eax		# clear %eax and %ebx
	movl	$0, %ebx

	movb	(P), %al				# Store the value of the p-register in EAX
	movb	(S), %bl				# Store the value of the Stackpointer in EBX
	movb	%al, MEM(%ebx)				# Move the value of the acumulator to the stack
	decb	%bl
	movb 	%bl, (S)				# Decrease the Stackpointer
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine


   # ***********************************************************************
   # * Subroutine name : PLA (Pull acumulator from stack       	           	*
   # * Description     : The PLA instruction pulls the value from the stack	*
   # *					 and stores it in the acumulator. Finally, it	 	*
   # *					 Increments the Stackpointer						*
   # * Author          : Roy						   					   	*
   # ***********************************************************************
do_pla:
	pushl 	%ebp					# push base pointer
	movl    %esp, %ebp				# copy stack pointer
	movl    $0, %ebx 			# clear the ebx
	incb 	S 				# increment the Stackpointer
	movzbl	S, %ebx				# Store the value of the stackpointer in %eax
	addl $256, %ebx				# move 256 to ebx , because locations in memory is 01:ff
	movl	$0,%eax					# Clear %eax
	movb	MEM(%ebx),%al			# Store value of the stack in %ebx
	movb	%al, A					# Move the value to the accumulator
	#incb S                              # Increment Stackpointer




	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : PLP (Pull processor status from stack       	    *
   # * Description     : The PLP instruction pulls the value from the stack	*
   # *					 and stores it in the P Register. Finally, it	 	*
   # *					 Increments the Stackpointer						*
   # * Author          : Roy						   					   	*
   # ***********************************************************************
do_plp:
	pushl 	%ebp                    # push base pointer
	movl    %esp, %ebp              # copy stack pointer
	
	movl	S, %eax				# Store the value of the stackpointer
	movl	$0, %ebx				# Clear EBX
	movl	8(%ebp), %ebx			# Store the value the stackpointer points to
	movb	%bl, P					# Move the value to the C64 P Register
	incl	S						# increments the Stackpointer
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine

   # ***********************************************************************
   # * Subroutine name : ROL (Rotate one bit left)			   				*
   # * Description     : The ROL instruction shifts the value in the       	*
   # *			 		Accumulator or a memory address one bit to the left	*
   # * 		       		the low bit is set to the value of the carry flag 	*
   # * 		       		and the bit that is shifted out is stored in the  	*
   # * 		       		carry flag, the negative and zero flags are affected*
   # * 		       		depending on the new value 			   				*
   # * Author          : Jelle 					   	   						*
   # ***********************************************************************

do_rol:
	pushl 	%ebp
	movl 	%esp, %ebp
	movl	$0, %ebx

	movb 	8(%ebp) , %bl 	# move the memory value to the %ebx
	call 	 isset_flag_carry 	# check if the carry flag is set , returns in %eax 
	cmp 	$0, %eax		# if there isn't a carry jump else just do ROL	
	je 	carry_off_rol 		# else just roll

carry_on_rol:
	stc 				# set carry flag
	jmp	rol_dorol	

carry_off_rol:
	clc 				# clear the carry flag

rol_dorol:
	movl 	$0, %eax 		# clear the eax register
	movb 	A, %al 		# move accumulator to the %eax
	rolb    %al	 		# Rotate one bit left
	movb 	%al, A 		# move the value of %eax to the accumulator

	call 	do_flag_zn 		# set the negative and zero flag
	jc	rol_set_c64_carry	# if intel carry flag is true

rol_set_c64_carry:
	call    set_flag_carry			# sets the c64 carry flag
	jmp	rol_end			# jump to end

rol_unset_c64_carry:
	call 	reset_flag_carry		# resets the c64 carry flag
	
rol_end:
	movl 	%ebp, %esp 		# Copy the stack pointer to ESP
	popl 	%ebp 			# restor the pase pointer
	ret 				# return from subroutine

   # ***********************************************************************
   # * Subroutine name : ROR (Rotate one bit right) 			   			*
   # * Description     : The ROR instruction shifts the value in the       	*
   # *			 Accumulator or a memory address one bit to the right		*
   # * 		       : the high bit is set to the value of the carry flag 	*
   # * 		       : and the carry flag is set tot the old value of the		*
   # * 		       : low bit. The negative and zero flags are affected		*
   # * 		       : depending on the new value 			   				*
   # * Author          : Jelle 					   	   						*
   # ***********************************************************************
   
   

do_ror:
	pushl 	%ebp
	movl 	%esp, %ebp
	movl	$0, %ebx

	movb 	8(%ebp) , %bl 	# move the memory value to the %ebx
	call 	 isset_flag_carry 	# check if the carry flag is set , returns in %eax 
	cmp 	$0, %eax		# if there isn't a carry jump else just do ROL	
	je 	carry_off_ror 		# else just roll

carry_on_ror:
	stc
	jmp	ror_doror	

carry_off_ror:
	clc

ror_doror:
	movl 	$0, %eax 		# clear the eax register
	movb 	A, %al 		# move accumulator to the %eax
	rorb    %al	 		# Rotate one bit left
	movb 	%al, A 		# move the value of %eax to the accumulator

	call 	do_flag_zn 		# set the negative and zero flag
	jc	ror_set_c64_carry	# if intel carry flag is true

ror_set_c64_carry:
	call    set_flag_carry			# sets the c64 carry flag
	jmp	ror_end			# jump to end

ror_unset_c64_carry:
	call 	reset_flag_carry		# resets the c64 carry flag
	
ror_end:
	movl 	%ebp, %esp 		# Copy the stack pointer to ESP
	popl 	%ebp 			# restor the pase pointer
	ret 				# return from subroutine

 
   # ***************************************************************************************
   # * Subroutine name : RTI ( Return from interrupt )
   # * The RTI instruction returns program control to normal execution when interrupt handling is complete
   # * Author : 	Jelle 
   # *****************************************************************************************

do_rti:
	ret


   # ***************************************************************************************
   # * Subroutine name: RTS ( Return form subroutine )
   # * The RTS instruction returns from a subroutine call by restoring the program counter
   # * Author :  unkown 
   # ***************************************************************************************
do_rts:
	ret




  # ***********************************************************************
   # * Subroutine name : SBC (Subtract memory from accumulator with borrow)*
   # * Description     : The SBC instruction subtracts the memory and      *
   # *					 borrow from the accumulator, and stores the       *
   # *					 result in the accumulator. Borrow is defined as   *
   # *					 the logical inverse of carry, so if the carry flag*
   # *					 is set, there is no borrow to be subtracted. The  *
   # *					 6502 adds the carry to the bit-inverted value     *
   # *					 read from memory, to gain a proper 2's complement *
   # *					 representation of the negative number to be       *
   # *					 subtracted. Then the negative value is added to   *
   # *					 the accumulator value. Check for yourself that    *
   # *					 doing it this way does give the correct value!    *
   # *					 The carry flag is affected as borrow, so the      *
   # *					 carry flag is set when no borrow was needed, and  *
   # *					 vice versa. Again, check for yourself that a      *
   # *					 carry means that no borrow was needed. The		   *
   # *					 overflow, negative, and zero flags are affected   *
   # *					 as usually.									   *
   # * Author          : Gerbert					   					   *
   # ***********************************************************************
do_sbc: 							# Decrement Y by one
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	call	isset_flag_carry		# 
	cmp		$0,%eax					# carry is true
	je		sbc_reset_x86carry		# reset x86 carry to false
	stc								# set x86 carry
	jmp		sbc_add					# jump to next

sbc_reset_x86carry:
	clc								# set x86 carry
	
sbc_add:
	movl	$0, %ebx				# clear ebx
	movl	8(%ebp),%eax			# copy addressing to tempaddress
	movb	8(%ebp),%bl			# copy memory content to temp
	addb	A,%bl					# add A and memory content with carry/borrow
	
	jnc		sbc_carry_flag_off		# jmp if carry
	call	set_flag_carry			# set carry flag to false
	jmp		sbc_overflow			# jump to next
	
sbc_carry_flag_off:
	call	reset_flag_carry		# set carry flag to false
	
sbc_overflow:
	jno		sbc_overflow_flag_off	# jmp if x86 overflow not
	call	set_flag_overflow		# set zero flag to false
	jmp		sbc_negative			# jump to next

sbc_overflow_flag_off:
	call	reset_flag_overflow		# set zero flag to true
	
sbc_negative:
	cmp		$0,A					# compare 0 with A
	jge		sbc_negative_flag_off	# A >= 0
	call	set_flag_negative		# set negative flag to true
	jmp		sbc_zero				# jump to next

sbc_negative_flag_off:
	call	reset_flag_negative		# set negative flag to false
	
sbc_zero:
	cmp		$0,A					# compare 0 with A
	jne		sbc_zero_flag_off		# A != 0
	call	set_flag_zero			# set zero flag to true
	jmp		sbc_end					# jump to next

sbc_zero_flag_off:
	call	reset_flag_zero			# set zero flag to false
	
sbc_end:	
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine	


   # ***********************************************************************
   # * Subroutine name : SEC (Set carry flag)				   				*
   # * Description     : The SEC instruction sets the carry flag of the P  	*
   # *					 register to 1.			   							*
   # * Author          : Tim					   	   						*
   # ***********************************************************************
do_sec:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	call	set_flag_carry	#set the carry flag

	movl 	%ebp, %esp     	# Clear local variables from stack.
	popl 	%ebp           	# Restore caller’s base pointer.
	ret						# Return.

do_sed:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	call	set_flag_decimal# set decimal flag

	movl 	%ebp, %esp     	# Clear local variables from stack.
	popl 	%ebp           	# Restore caller’s base pointer.
	ret						# Return.

do_sei:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	call	set_flag_interrupt

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

   # ************************************************************************
   # * Subroutine name 	: STA (Store accumulator in memory)		  	        *
   # * Description     	: The STA instruction stores the value in the 		*
   # *				  	  accumulator at the effective memory adress given	*
   # * 					  as its operand.									*
   # * Author          	: Tim												*
   # ************************************************************************
do_sta:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %ebx 		# clear the ebx register
	movb	A, %bl 		# move A to the bl register
	movb	%bl, 8(%ebp)		# move the bl register to the memory addres

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

   # ************************************************************************
   # * Subroutine name 	: STP (Stop processor)					  	        *
   # * Description     	: The STP instruction halts the processor.the 		*
   # *				  	  accumulator at the effective memory adress given	*
   # * 					  as its operand.									*
   # * Author          	: Tim												*
   # ************************************************************************

do_stp:

	# if everyting works fine... the fetchcycle shouldnt even call this subroutine.
	# Therefore, we only made it a stub

	ret				# Return.


   # ************************************************************************
   # * Subroutine name 	: STX (Store the X register in memory)		        *
   # * Description     	: The STX instruction stores the value in the 		*
   # *				  	  X register at the effective memory adress given	*
   # * 					  as its operand.									*
   # * Author          	: Tim												*
   # ************************************************************************
do_stx:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %ebx
	movb	X, %bl
	movb	%bl, 8(%ebp)

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

   # ************************************************************************
   # * Subroutine name 	: STY (Store the Y register in memory)		        *
   # * Description     	: The STY instruction stores the value in the 		*
   # *				  	  Y register at the effective memory adress given	*
   # * 					  as its operand.									*
   # * Author          	: Tim												*
   # ************************************************************************
do_sty:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %ebx 		# clear the ebx register 
	movb	Y, %bl 		# move the Y register in to the bl register
	movb	%bl, 8(%ebp) 		# move the bl register to the memory addres

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

   # ************************************************************************
   # * Subroutine name 	: TAX (Transfer accumulator to X register)		    *
   # * Description     	: The TAX instruction copies the value in the		*
   # *				  	  accumulator to the X register. The negative and 	*
   # * 					  zero flags are affected depending on the value	*
   # *					  copied.											*
   # * Author          	: Tim												*
   # ************************************************************************
do_tax:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %eax 		# clear the eax register 
	movb	A, %al 		# move the A register to the al register
	movb	%al, X 		# move the al register to the X register
	call	do_flag_zn 		# set the negative or zero flag

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.


  # ************************************************************************
   # * Subroutine name 	: TAY (Transfer accumulator to Y register)		    *
   # * Description     	: The TA?shva=1#inboxY instruction copies the value in the		*
   # *				  	  accumulator to the Y register. The negative and 	*
   # * 					  zero flags are affected depending on the value	*
   # *					  copied.											*
   # * Author          	: Tim												*
   # ************************************************************************
do_tay:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %eax 		# clear the eax register
	movb	A, %al 		# move the A register to the al register
	movb	%al, Y 		# move the al register to the Y register
	call	do_flag_zn 		# set the negative and zero flag

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.

   # ************************************************************************
   # * Subroutine name 	: TSX (Transfer stack pointer to X register)	    *
   # * Description     	: The TSX instruction copies the value of the		*
   # *				  	  stack pointer to the X register. The negative and	*
   # * 					  zero flags are affected depending on the value	*
   # *					  copied.											*
   # * Author          	: Tim												*
   # ************************************************************************
do_tsx:
	pushl	%ebp			# Prolog: push the base pointer
	movl 	%esp, %ebp 		# and copy stack pointer to EBP.

	movl	$0, %eax 		# clear the eax register
	movb	(S), %al 		# move the Stack pointer to the al register
	movb	%al, X 		# move the al to the X register
	call	do_flag_zn 		# set the negative and zero flag

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret				# Return.


   # ************************************************************************
   # * Subroutine name 	: TXA (Transfer X register to accumulator)		    *
   # * Description     	: The TXA instruction copies the value of the		*
   # *				  	  X register to the accumulator. The negative and	*
   # * 					  zero flags are affected depending on the value	*
   # *					  copied.											*
   # * Author          	: Tim												*
   # ************************************************************************
do_txa:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer

	movl	$0, %eax 		# clear the eax register
	movb	X, %al 		# move the X register to the al register
	movb	%al, A 		# move the al register to the X register
	call	do_flag_zn 		# set the negative and zero flag
	
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp			# restore base pointer
	ret				# return from subroutine

   # ************************************************************************
   # * Subroutine name 	: TXS (Transfer X register to stack pointer)	    *
   # * Description     	: The TXS instruction copies the value of the		*
   # *				  	  X register to the stack pointer. No flags are		*
   # * 					  affected.											*
   # * Author          	: Tim												*
   # ***********************************************************************
do_txs:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer

	movl	$0, %eax 		# clear the eax register
	movb	X, %al 		# move the X register to the eax register
	movb	%al, (S) 		# move the al register to the stack pointer

	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp			# restore base pointer
	ret				# return from subroutine

   # ************************************************************************
   # * Subroutine name 	: TYA (Transfer Y register to accumulator)		    *
   # * Description     	: The TYA instruction copies the value of the		*
   # *				  	  Y register to the accumulator. The negative and	*
   # * 					  zero flags are affected depending on the value	*
   # *					  copied.											*
   # * Author          	: Tim												*
   # ***********************************************************************

do_tya: 				# Transfer Y register to accumulator
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movl	$0, %eax
	movb	Y,%al		# move Y register to temp
	movb	%al,A		# move temp to a register
	
	call	do_flag_zn
	
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp			# restore base pointer
	ret				# return from subroutine
