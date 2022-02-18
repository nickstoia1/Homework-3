# This is a set of examples in a series of using x86 (32bit) and x86_64 (64bit) assembly
# instructions. Assemble and link these files and trace through the executable with the
# debugger. The idea is to get a sense of how to use these instructions, so you can rip
# this and use it in your own code
#
# If you have any questions, comments, concerns, or find bugs, then just send me an email.
# 
# - richard.m.veras@ou.edu

.section .data
# In this example we don not have any static data to initialize
	
.section .text
# The .text section is our executable code.

# We need to make the symbol _start available to the loader (ld) and we do this
# with .globl	
.globl _start
_start:

	###########################
	# moving immediate values #
	###########################	
	# we use movq -- emphasis on the "q" -- because these are 64bit
	# quadwords
	# i.e. movq (for quad word, 8 bytes, 64bit) 0x0000000000000000 - 0xFFFFFFFFFFFFFFFF
	# i.e. movl (for .long, double word, 4 bytes, 32bit) 0x00000000 - 0xFFFFFFFF

	# Let us initialize some values to work with
	movq $0, %rax 
	movq $0x00000001, %rbx # same value in base 16 (Hex)
	movq $0x00000004, %rcx
	movq $0x0000000F, %rdx
	movq $0x0000000E, %rdi
	movq $0x0000000B, %rsi

	#############
	# Increment #
	#############
	# incq - increment the register by 1
	incq %rax

	#############
	# Decrement #
	#############
	# decq reg --> reg = reg-1
	decq %rbx
	decq %rbx

	#######
	# Add #
	#######
	# addq imm, regb --> regb = imm + regb
	addq $1, %rdx
	
	# addq rega, regb --> regb = rega + regb
	addq %rcx, %rdx

	############
	# Subtract #
	############
	# subq imm, regb --> regb = regb - imm
	subq $10, %rdx 
	
	# subq rega, regb --> regb = regb - rega
	subq %rsi, %rdi

	############
	# Multiply #
	############
	# imulq imm, regb --> regb = imm * regb
	imulq $3, %rax

	# imulq rega, regb --> regb = rega * regb
	imulq %rbx, %rcx


	#################################
	# Safely exit in x86_64 (64bit) #
	#################################
	jmp _exit_x86_64bit

_exit_x86_64bit:
	# This is slightly different because in x86_64 (64bit) we get the
	# syscall instruction, which provides more flexibility than int (interrupt)
	# so it is the defacto way for making system calls in 64bit binaries, in linux,
	# on systems with the x86_64 instruction set architecture.
	movq $60, %rax  # call number 60 -> exit
	movq $0x0, %rdi # return 0
	syscall #run kernel
	
	
