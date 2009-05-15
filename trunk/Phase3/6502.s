  # ************************************************************************
   # * Program name : 6502	                                           *
   # * Description  : Declareer en initialiseer alles			   *
   # * Author       : Groep 5  						   *
   # ***********************************************************************
#emulator
.global MEM					# 64kb 'linear' memory space

# Create the A, X, Y , PC, S, IR and P registers
.global PC	#Program Counter
.global S	#Stackpointer
.global A	#Accumelator register
.global X	#x register
.global Y	#y register
.global IR	#Instruction register
.global P	#p register

#initialize the mem and stack
.bss
MEM:	.skip 0xFFFF				# Reserve 65536  bytes of main memory 
 
.data
#initialize the A, X, Y, PC, S, IR and P registers to 0
PC:		.word	0	
S:		.byte	0xFF	
A:		.byte 	0
X: 		.byte 	0
Y: 		.byte 	0
IR: 	.byte 	0
P: 		.byte 	0

.global start
start:
	pushl 	%ebp				#Prologue
	movl  	%esp,%ebp

	#clear all the 6502 registers; PC will be initialized in initPC
	movb	$0, S
	movb	$0, A
	movb	$0, X
	movb	$0, Y
	movb	$0, IR
	movb	$0, P
	
	call 	readprog			#load the program in Memory
	call	initpc				#initialize the PC

	call	fetch				#call the fetch subroutine in fetch.s : DEBUG: the bug should be somewehere in here.
	movl	%ebp,%esp			#Epilogue
	popl	%ebp				#restore basepointer
	pushl	$0					#push exit code
	call	exit				#exit


##################################################
# Subroutine: 	initpc				 #
# Description:	initializes the PC		 #
##################################################
initpc:
	#haal de waardes van plaats FF:FC en FF:FD uit het MEM, en plaats die in de PC....
	
	movl 	$0xFFFC, %ebx			# at FF:FC is the initial PC
	movl	$0, %eax
	movw 	MEM(%ebx), %ax			# get initial PC into ax: we move a Word, so it also takes the next long (second element of PC)
	movw 	%ax, (PC)				# and put into PC
	ret
