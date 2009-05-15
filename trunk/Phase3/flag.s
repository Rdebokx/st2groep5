   # ************************************************************************
   # * Subroutine names	: Alle set reset en isset functies		    *
   # * Description     	: Set: set de bijbehorende flag, 
   # * 			Reset: reset de bijbehorende flag, 
   # * 			isset: return 0 als het niet geset is in de %eax.					*
   # * Author          	: Tim												*
   # ***********************************************************************

.global set_flag_carry
.global set_flag_zero
.global set_flag_interrupt
.global set_flag_decimal
.global set_flag_break
.global set_flag_overflow
.global set_flag_negative

.global reset_flag_carry
.global reset_flag_zero
.global reset_flag_interrupt
.global reset_flag_decimal
.global reset_flag_break
.global reset_flag_overflow
.global reset_flag_negative

.global isset_flag_carry
.global isset_flag_zero
.global isset_flag_interrupt
.global isset_flag_decimal
.global isset_flag_break
.global isset_flag_overflow
.global isset_flag_negative

.global do_flag_zn
.global do_intel_flag_carry


set_flag_carry:
	movl	$0, %eax
	movb	P, %al
	orb		$0b000000001, %al
	movb 	%al, P
	ret

set_flag_zero:
	movl	$0, %eax
	movb	P, %al
	orb		$0b00000010, %al
	movb 	%al, P
	ret

set_flag_interrupt:
	movl	$0, %eax
	movb	P, %al
	orb		$0b00000100, %al
	movb 	%al, P
	ret

set_flag_decimal:
	movl	$0, %eax
	movb	P, %al
	orb		$0b00001000, %al
	movb 	%al, P
	ret

set_flag_break:
	movl	$0, %eax
	movb	P, %al
	orb		$0b00010000, %al
	movb 	%al, P
	ret

set_flag_overflow:
	movl	$0, %eax
	movb	P, %al
	orb		$0b01000000, %al
	movb 	%al, P
	ret

set_flag_negative:
	movl	$0, %eax
	movb	P, %al
	orb		$0b10000000, %al
	movb 	%al, P
	ret

reset_flag_carry:
	movl	$0, %eax
	movb	P, %al
	and	$0b11111110, %al
	movb 	%al, P
	ret

reset_flag_zero:
	movl	$0, %eax
	movb	P, %al
	and	$0b11111101, %al
	movb 	%al, P
	ret

reset_flag_interrupt:
	movl	$0, %eax
	movb	P, %al
	and	$0b11111011, %al
	movb 	%al, P
	ret

reset_flag_decimal:
	movl	$0, %eax
	movb	P, %al
	and	$0b11110111, %al
	movb 	%al, P
	ret

reset_flag_break:
	movl	$0, %eax
	movb	P, %al
	and	$0b11101111, %al
	movb 	%al, P
	ret

reset_flag_overflow:
	movl	$0, %eax
	movb	P, %al
	and	$0b10111111, %al
	movb 	%al, P
	ret

reset_flag_negative:
	movl	$0, %eax
	movb	P, %al
	and	$0b01111111, %al
	movb 	%al, P
	ret

isset_flag_carry:
	movl	$0, %eax
	movb	P, %al
	and		$0b00000001, %al
	ret

isset_flag_zero:
	movl	$0, %eax
	movb	P, %al
	and		$0b00000010, %al
	ret

isset_flag_interrupt:
	movl	$0, %eax
	movb	P, %al
	and		$0b00000100, %al
	ret

isset_flag_decimal:
	movl	$0, %eax
	movb	P, %al
	and		$0b00001000, %al
	ret

isset_flag_break:
	movl	$0, %eax
	movb	P, %al
	and		$0b00010000, %al
	ret

isset_flag_overflow:
	movl	$0, %eax
	movb	P, %al
	and		$0b01000000, %al
	ret

isset_flag_negative:
	movl	$0, %eax
	movb	P, %al
	and		$0b10000000, %al
	ret

   # ************************************************************************
   # * Subroutine name 	: do_flag_zn											*
   # * Description     	: set or resets the zero and negative flags acordingly				*
   # * Author          	: Tim												*
   # ***********************************************************************
# Is het zero als carry gezet is en de rest is 0 ???? DENK IDIOTEN
do_flag_zn:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	pushl	%eax

	cmp		$0, %al			# compare %eax and 0
	je		zero_flag_on		# %eax == 0	
	
zero_flag_off:
	call		reset_flag_zero		# sets the zero flag to false
	jmp		negative_flag
	
zero_flag_on:
	call		set_flag_zero		# sets the zero flag to true

negative_flag:
	popl	%eax
	cmp		$0, %al			# compare %eax and 0
	jl		negative_flag_on	# A < 0
	
negative_flag_off:
	call		reset_flag_negative	# sets the negative flag to false
	jmp		end_do_flag_zn
	
negative_flag_on:
	call		set_flag_negative	# sets the negative flag to true

end_do_flag_zn:
	movl 	%ebp, %esp     		# Clear local variables from stack.
	popl 	%ebp           		# Restore caller’s base pointer.
	ret					# return from subroutine

 # ************************************************************************
   # * Subroutine name 	: do_intel_flag_carry								*
   # * Description     	: set or reset the intel carry flag					*
   # * Author          	: Gerbert & Roy										*
   # ***********************************************************************	
do_intel_flag_carry:
	call	isset_flag_carry	# check if zero flag is set
	jz		set_intel_carry		# if not, reset intel carry flag
	stc							# else, set intel carry flag
	jmp		intel_flag_and

set_intel_carry:
	clc							# reset intel carry flag

intel_flag_and:
	ret	
