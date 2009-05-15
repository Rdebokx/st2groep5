   # ************************************************************************
   # * Subroutine name : Binary to BCD (Binary Coded Decimal)      	   		*
   # * Description     : Converts the parameter to BCD bit representation	*
   # * 					 and returns it in the %eax							*
   # * 					 Parameter has length long							*
   # * Author          : Gerbert				   	   						*
   # ************************************************************************
tobcd:
	pushl 	%ebp                    #   push base pointer
	movl    %esp, %ebp              #   copy stack pointer
	
	movl	$0, %eax				# clear %eax
	movl	$0, %ecx				# counter = o (for amount of shifts)
	
	movl	8(%ebp),%eax			# get parameter #1: binary value (only 1)

tobcd_loop:
	shlb	%al						# 1) shift
	incb	%cl						# counter++
	cmpb	$8, %cl					# 2) if value has been shifted 8 times
	je		tobcd_out				# jump out of the loop
	
# 3) compare each column with 5
tobcd_cmp_lower:
	movb	%al,%bl					# store to temp var
	andb	$0b00001111,%bl			# keep lower decimal
	cmpb	$0b00000101,%bl 		# compare lower decimal with 5
	jl		tobcd_cmp_higher		# if value >= 5 then dont jump
tobcd_lower_add:
	addb	$0b00000011,%al			# add 3 to lower part of value

tobcd_cmp_higher:
	movb	%al,%bl					# store to temp var
	andb	$0b11110000,%bl			# keep higher decimal
	cmpb	$0b01010000,%bl 		# compare higher decimal with 5
	jl		tobcd_step4				# if value >= 5 then dont jump
tobcd_lower_add:
	addb	$0b00110000,%al			# add 3 to lower part of value

tobcd_step4:
	jmp		tobcd_loop				# 4) repeat
	
tobcd_out:
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine


   # ************************************************************************
   # * Subroutine name : BCD to (Binary Coded Decimal) to binary     	   	*
   # * Description     : Converts the parameter from BCD bit representation	*
   # * 					 and returns it in the %eax							*
   # * 					 Parameter has length long							*
   # * Author          : Gerbert				   	   						*
   # ************************************************************************
frombcd:
	movl	$0,%ebx					# clear %ebx
	movl	$0,%eax					# clear %eax
	
	movl	8(%ebp),%eax			# get parameter #1: bcd value (only 1)
	
	movb	%al,%bl					# store to temp var
	andb	$0b00001111,%bl			# keep lower decimal
	
	shrb	%al						# shift 4 places right
	shrb	%al
	shrb	%al
	shrb	%al
	
	mulb	$10						# multiply higher decimal with 10
	addb	%bl,%al					# add lower decimal to higher decimal
	
	movl 	%ebp, %esp 				# copy stack pointer to ESP
	popl 	%ebp					# restore base pointer
	ret								# return from subroutine
