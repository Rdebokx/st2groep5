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


set_flag_carry:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b10000000, %al
	movb 	%al, (P)
	ret

set_flag_zero:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b01000000, %al
	movb 	%al, (P)
	ret

set_flag_interrupt:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b00100000, %al
	movb 	%al, (P)
	ret

set_flag_decimal:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b00010000, %al
	movb 	%al, (P)
	ret

set_flag_break:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b00001000, %al
	movb 	%al, (P)
	ret

set_flag_overflow:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b00000010, %al
	movb 	%al, (P)
	ret

set_flag_negative:
	movl	$0, %eax
	movb	(P), %al
	orb		$0b00000001, %al
	movb 	%al, (P)
	ret

reset_flag_carry:
	movl	$0, %eax
	movb	(P), %al
	and	$0b01111111, %al
	movb 	%al, (P)
	ret

reset_flag_zero:
	movl	$0, %eax
	movb	(P), %al
	and	$0b10111111, %al
	movb 	%al, (P)
	ret

reset_flag_interrupt:
	movl	$0, %eax
	movb	(P), %al
	and	$0b11011111, %al
	movb 	%al, (P)
	ret

reset_flag_decimal:
	movl	$0, %eax
	movb	(P), %al
	and	$0b11101111, %al
	movb 	%al, (P)
	ret

reset_flag_break:
	movl	$0, %eax
	movb	(P), %al
	and	$0b11110111, %al
	movb 	%al, (P)
	ret

reset_flag_overflow:
	movl	$0, %eax
	movb	(P), %al
	and	$0b11111101, %al
	movb 	%al, (P)
	ret

reset_flag_negative:
	movl	$0, %eax
	movb	(P), %al
	and	$0b11111110, %al
	movb 	%al, (P)
	ret

isset_flag_carry:
	movl	$0, %eax
	movb	(P), %al
	and		$0b10000000, %al
	ret

isset_flag_zero:
	movl	$0, %eax
	movb	(P), %al
	and		$0b01000000, %al
	ret

isset_flag_interrupt:
	movl	$0, %eax
	movb	(P), %al
	and		$0b00100000, %al
	ret

isset_flag_decimal:
	movl	$0, %eax
	movb	(P), %al
	and		$0b00010000, %al
	ret

isset_flag_break:
	movl	$0, %eax
	movb	(P), %al
	and		$0b00001000, %al
	ret

isset_flag_overflow:
	movl	$0, %eax
	movb	(P), %al
	and		$0b00000010, %al
	ret

isset_flag_negative:
	movl	$0, %eax
	movb	(P), %al
	and		$0b00000001, %al
	ret

   # ************************************************************************
   # * Subroutine name 	: do_flag_zn											*
   # * Description     	: set or resets the zero and negative flags acordingly				*
   # * Author          	: Tim												*
   # ***********************************************************************

do_flag_zn:
	cmp		$0, %eax		# compare %eax and 0
	je		zero_flag_on		# %eax == 0
	
zero_flag_off:
	call		reset_flag_zero		# sets the zero flag to false
	jmp		negative_flag
	
zero_flag_on:
	call		set_flag_zero		# sets the zero flag to true

negative_flag:
	cmp		$0, %eax		# compare %eax and 0
	jl		negative_flag_on	# A < 0
	
negative_flag_off:
	call		reset_flag_negative	# sets the negative flag to false
	jmp		end_do_flag_zn
	
negative_flag_on:
	call		set_flag_negative	# sets the negative flag to true

end_do_flag_zn:
	ret					# return from subroutine
