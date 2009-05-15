#########################################################
# Name: decode                                          #
# Description: provides operand fetches                 #
#              for the different adressing modes.       #
# Author: Jelle van Der Waa                             #
#########################################################

		
.text
	error: .asciz		"invalid instrucion \n" # error string for when an invalid instrucion is called
	
.global decode

decode:
	pushl	%ebp			# push the base pointer
  	movl    %esp, %ebp		# initialize the base pointer
  	
  	movl	$0, %ebx		#clear ebx
	movb	(IR), %bl		# move record of the table into ebx (4 every line), we use movb, to avoid non-significant numbers
	movl	$8,  %eax		# we have to multiply the IR by 8, to get the right record in the table (there are 2 elements per opcode, a long is 4)
	mull	%ebx			# multiplying
	movl	%eax, %ebx		# the instructions may affect EAX, so we use EBX	
	
	call	*TABLE(%ebx) 		# call the fetch-function
	pushl	MEM(%eax)			# push return value on stack

	addl	$4,	%ebx		# the execute method is in 2*IR + 1 (a long is 4)
	
							#(return value of fetch-function is already on stack, no need for pushing parameter)
	call	*TABLE(%ebx)	# call execute method 
							
	addl	$4, %esp		#remove the "return value" of fetch routine from stack
	movl 	%esp, %ebp 		#l copy stack pointer to ESP
	popl 	%ebp	
		
	ret



#########################################################
# Name: none                                            #
# Description: Everything that has no addres mode       #
#              uses this routine and does nothing       #
# Author: Jelle van Der Waa                             #
#########################################################
none:
	ret
	

#########################################################
# Name: invalid                                         #
# Description: This subroutine returns                  #
#              "invalid" and exit's the program with 1  #
# Author: Jelle van Der Waa                             #
#########################################################
invalid: 	
		pushl   $error 		# push the error string
		call 	printf 		# call printf and print the error string		
		addl	$4, %esp		# clear stack
		pushl	$1			# Illigal instruction abborts the whole program
		call 	exit		# Terminate the program


TABLE:
.long	none		,	 do_brk		#0x0
.long   fetch_inX	, 	 do_ora		#0x1
.long	invalid		, 	 invalid   	#0x2
.long   invalid		,	 invalid	#0x3
.long	invalid		,	 invalid	#0x4
.long	fetch_zp	,	 do_ora		#0x5 
.long	fetch_zp	,	 do_asl		#0x6
.long	invalid		,	 invalid	#0x7
.long	none		,	 do_php		#0x8 
.long	fetch_imm	,	 do_ora		#0x9
.long	fetch_acc	,	 do_asl		#0xa
.long	invalid		,	 invalid	#0xb 
.long	invalid		,	 invalid	#0xc
.long	fetch_abs	,	 do_ora		#0xd
.long	fetch_abs	,	 do_asl		#0xe
.long	invalid		,	 invalid	#0xf
.long	fetch_rel	,	 do_bpl		#0x10
.long	fetch_inY	,	 do_ora		#0x11
.long	invalid		,	 invalid	#0x12
.long	invalid		,	 invalid	#0x13
.long	invalid		,	 invalid	#0x14
.long	fetch_zpX	,	 do_ora		#0x15
.long	fetch_zpX	,	 do_asl		#0x16
.long	invalid		,	 invalid	#0x17
.long	none   		,	 do_clc 	#0x18
.long	fetch_abY	,	 do_ora		#0x19
.long 	invalid		,	 invalid	#0x1a
.long	invalid		,	 invalid	#0x1b
.long	invalid		,	 invalid	#0x1c
.long	fetch_abX	,	 do_ora		#0x1d
.long	fetch_abX	,	 do_asl		#0x1e
.long	invalid		,	 invalid	#0x1f
.long	fetch_abs	,	 do_jsr		#0x20
.long	fetch_inX	,	 do_and		#0x21
.long	invalid		,	 invalid	#0x22
.long	invalid		,	 invalid	#0x23
.long	fetch_zp	,	 do_bit		#0x24
.long	fetch_zp	,	 do_and		#0x25
.long	fetch_zp	,	 do_rol		#0x26
.long	invalid		,	 invalid	#0x27
.long	none		,	 do_plp		#0x28
.long	fetch_imm	,	 do_and		#0x29
.long	fetch_acc	,	 do_rol		#0x2a
.long	invalid		,	 invalid	#0x2b
.long	fetch_abs	,	 do_bit		#0x2c
.long	fetch_abs	,	 do_and		#0x2d
.long	fetch_abs	,	 do_rol		#0x2e
.long	invalid		,	 invalid	#0x2f
.long	fetch_rel	,	 do_bmi		#0x30
.long	fetch_inY	,	 do_and		#0x31
.long	invalid		,	 invalid	#0x32
.long	invalid		,	 invalid	#0x33
.long	invalid		,	 invalid	#0x34
.long	fetch_zpX	,	 do_and		#0x35
.long	fetch_zpX	,	 do_rol		#0x36
.long	invalid		,	 invalid	#0x37
.long	none		,	 do_sec		#0x38
.long	fetch_abY	,	 do_and		#0x39
.long	invalid		,	 invalid	#0x3a
.long	invalid		,	 invalid	#0x3b
.long	invalid		,	 invalid	#0x3c
.long	fetch_abX	,	 do_and		#0x3d
.long	fetch_abX	,	 do_rol		#0x3e
.long	invalid		,	 invalid	#0x3f
.long	none		,	 do_rti		#0x40
.long	fetch_inX	,	 do_eor		#0x41
.long	invalid		,	 invalid	#0x42
.long	invalid		,	 invalid	#0x43
.long	invalid		,	 invalid	#0x44
.long	fetch_zp	,	 do_eor		#0x45
.long	fetch_zp	,	 do_lsr		#0x46
.long	invalid		,	 invalid	#0x47
.long	none		,	 do_pha		#0x48
.long	fetch_imm	,	 do_eor		#0x49
.long	fetch_acc	,	 do_lsr		#0x4a
.long	invalid		,	 invalid	#0x4b
.long	fetch_abs	,	 do_jmp		#0x4c
.long	fetch_abs	,	 do_eor		#0x4d
.long	fetch_abs	,	 do_lsr		#0x4e
.long	invalid		,	 invalid	#0x4f
.long	fetch_rel	,	 do_bvc		#0x50
.long	fetch_inY	,	 do_eor		#0x51
.long	invalid		,	 invalid	#0x52
.long	invalid		,	 invalid	#0x53
.long	invalid		,	 invalid	#0x54
.long	fetch_zpX	,	 do_eor		#0x55
.long	fetch_zpX	,	 do_lsr		#0x56
.long	invalid		,	 invalid	#0x57
.long	none		,	 do_cli		#0x58
.long	fetch_abY	,	 do_eor		#0x59
.long	invalid		,	 invalid	#0x5a
.long	invalid		,	 invalid	#0x5b
.long	invalid		,	 invalid	#0x5c
.long	fetch_abX	,	 do_eor		#0x5d
.long	fetch_abX	,	 do_lsr		#0x5e
.long	invalid		,	 invalid	#0x5f
.long	none		,	 do_rts		#0x60
.long	fetch_inX	,	 do_adc		#0x61
.long	invalid		,	 invalid	#0x62
.long	invalid		,	 invalid	#0x63
.long	invalid		,	 invalid	#0x64
.long	fetch_zp	,	 do_adc		#0x65
.long	fetch_zp	,	 do_ror		#0x66
.long	invalid		,	 invalid	#0x67
.long	none		,	 do_pla		#0x68
.long	fetch_imm	,	 do_adc		#0x69
.long	fetch_acc	,	 do_ror		#0x6a
.long	invalid		,	 invalid	#0x6b
.long	fetch_ind	,	 do_jmp		#0x6c
.long	fetch_abs	,	 do_adc		#0x6d
.long	fetch_abs	,	 do_ror		#0x6e
.long	invalid		,	 invalid	#0x6f
.long	fetch_rel	,	 do_bvs		#0x70
.long	fetch_inY	,	 do_adc		#0x71
.long	invalid		,	 invalid	#0x72
.long	invalid		,	 invalid	#0x73
.long	invalid		,	 invalid	#0x74
.long	fetch_zpX	,	 do_adc 	#0x75
.long	fetch_zpX	,	 do_ror		#0x76
.long	invalid		,	 invalid	#0x77
.long	none		,	 do_sei		#0x78
.long	fetch_abY	,	 do_adc		#0x79
.long	invalid		,	 invalid	#0x7a
.long	invalid		,	 invalid	#0x7b
.long	invalid		,	 invalid	#0x7c
.long	fetch_abX	,	 do_adc		#0x7d
.long	fetch_abX	,	 do_ror		#0x7e
.long	invalid		,	 invalid	#0x7f
.long	invalid		,	 invalid	#0x80
.long	fetch_inX	,	 do_sta		#0x81
.long	invalid		,	 invalid	#0x82
.long	invalid		,	 invalid	#0x83
.long	fetch_inY	,	 do_sta		#0x84
.long	fetch_zp	,	 do_sta		#0x85
.long	fetch_zp	,	 do_stx		#0x86
.long 	invalid		,	 invalid	#0x87
.long 	none		,	 do_dey		#0x88
.long	invalid		,	 invalid	#0x89
.long	none		,	 do_txa		#0x8a
.long	invalid		,	 invalid	#0x8b
.long	fetch_abs	,	 do_sty		#0x8c
.long	fetch_abs	,	 do_sta		#0x8d
.long	fetch_abs	,	 do_stx		#0x8e
.long	invalid		,	 invalid	#0x8f
.long	fetch_rel	,	 do_bcc		#0x90
.long	fetch_inY	,	 do_sta		#0x91
.long	invalid		,	 invalid	#0x92
.long	invalid		,	 invalid	#0x93
.long	fetch_zpX	,	 do_sty		#0x94
.long	fetch_zpX	,	 do_sta		#0x95
.long	fetch_zpY	,	 do_stx		#0x96
.long	invalid		,	 invalid	#0x97
.long	none		,	 do_tya		#0x98
.long	fetch_abY	,	 do_sta		#0x99
.long	none		,	 do_txs		#0x9a
.long	invalid		,	 invalid	#0x9b
.long	invalid		,	 invalid	#0x9c
.long	fetch_abX	,	 do_sta		#0x9d
.long	invalid		,	 invalid	#0x9e
.long	invalid		,	 invalid	#0x9f
.long	fetch_imm	,	 do_ldy		#0xa0
.long	fetch_inX	,	 do_lda		#0xa1
.long	fetch_imm	,	 do_ldx		#0xa2
.long	invalid		,	 invalid	#0xa3
.long	fetch_zp	,	 do_ldy		#0xa4
.long	fetch_zp	,	 do_lda		#0xa5
.long	fetch_zp	,	 do_ldx		#0xa6
.long	invalid		,	 invalid	#0xa7
.long	none		,	 do_tay		#0xa8
.long	fetch_imm	,	 do_lda		#0xa9
.long	none		,	 do_tax		#0xaa
.long	invalid		,	 invalid	#0xab
.long	fetch_abs	,	 do_ldy		#0xac
.long	fetch_abs	,	 do_lda		#0xad
.long	fetch_abs	,	 do_ldx		#0xae
.long	invalid		,	 invalid	#0xaf
.long	fetch_rel	,	 do_bcs		#0xb0
.long	fetch_inY	,	 do_lda		#0xb1
.long	invalid		,	 invalid	#0xb2
.long	invalid		,	 invalid	#0xb3
.long	fetch_zpX	,	 do_ldy		#0xb4
.long	fetch_zpX	,	 do_lda		#0xb5
.long	fetch_zpY	,	 do_ldx		#0xb6
.long	invalid		,	 invalid	#0xb7
.long	none		,	 do_clv		#0xb8
.long	fetch_abY	,	 do_lda		#0xb9
.long	none		,	 do_tsx		#0xba
.long	invalid		,	 invalid	#0xbb
.long	fetch_abX	,	 do_ldy		#0xbc
.long	fetch_abX	,	 do_lda		#0xbd
.long	fetch_abY	,	 do_ldx		#0xbe
.long	invalid		,	 invalid	#0xbf
.long	fetch_imm	,	 do_cpy		#0xc0
.long	fetch_inX	,	 do_cmp		#0xc1
.long	invalid		,	 invalid	#0xc2
.long 	invalid		,	 invalid	#0xc3
.long	fetch_zp	,	 do_cpy		#0xc4
.long	fetch_zp	,	 do_cmp		#0xc5
.long	fetch_zp	,	 do_dec		#0xc6
.long	invalid		,	 invalid	#0xc7
.long	none		,	 do_iny		#0xc8
.long	fetch_imm	,	 do_cmp		#0xc9
.long	none		,	 do_dex		#0xca
.long	invalid		,	 invalid	#0xcb
.long	fetch_abs	,	 do_cpy		#0xcc
.long	fetch_abs	,	 do_cmp		#0xcd
.long	fetch_abs	,	 do_dec		#0xce
.long	invalid	 	,	 invalid	#0xcf
.long	fetch_rel	,	 do_bne		#0xd0
.long	fetch_inY	,	 do_jmp		#0xd1
.long	invalid		,	 invalid	#0xd2
.long	invalid		,	 invalid	#0xd3
.long	invalid		,	 invalid	#0xd4
.long	fetch_zpX	,	 do_cmp		#0xd5
.long	fetch_zpX	,	 do_dec		#0xd6
.long	invalid		,	 invalid	#0xd7
.long	none		,	 do_cld		#0xd8
.long	fetch_abY	,	 do_cmp		#0xd9
.long	invalid		,	 invalid	#0xda
.long	none		,	 do_stp		#0xdb
.long	invalid		,	 invalid	#0xdc
.long	fetch_abX	,	 do_cmp		#0xdd
.long	fetch_abX	,	 do_dec		#0xde
.long	invalid		,	 invalid	#0xdf
.long	fetch_imm	,	 do_cpx		#0xe0
.long	fetch_inX	,	 do_sbc		#0xe1
.long	invalid		,	 invalid	#0xe2
.long	invalid		,	 invalid	#0xe3
.long	fetch_zp	,	 do_cpx		#0xe4
.long	fetch_zp	,	 do_sbc		#0xe5
.long	fetch_zp	,	 do_inc		#0xe6
.long	invalid		,	 invalid	#0xe7
.long	none		,	 do_inx		#0xe8
.long	fetch_imm	,	 do_sbc		#0xe9
.long	none		,	 do_nop		#0xea
.long	invalid		,	 invalid	#0xeb
.long	fetch_abs	,	 do_cpx		#0xec
.long	fetch_abs	,	 do_sbc		#0xed
.long	fetch_abs	,	 do_inc		#0xee
.long	invalid		,	 invalid	#0xef
.long	fetch_rel	,	 do_beq		#0xf0
.long	fetch_inY	,	 do_sbc		#0xf1
.long	invalid		,	 invalid	#0xf2
.long	invalid		,	 invalid	#0xf3
.long	invalid		,	 invalid	#0xf4
.long	fetch_zpX	,	 do_sbc		#0xf5
.long	fetch_zpX	,	 do_inc		#0xf6
.long	invalid		,	 invalid	#0xf7
.long	none		,	 do_sed		#0xf8
.long	fetch_abY	,	 do_sbc		#0xf9
.long	invalid		,	 invalid	#0xfa
.long	invalid		,	 invalid	#0xfb
.long	invalid		,	 invalid	#0xfc
.long	fetch_abX	,	 do_sbc		#0xfd
.long	fetch_abX	,	 do_inc		#0xfe
.long	invalid		,	 invalid	#0xff
