# This is a set of examples in a series of using x86 (32bit) and x86_64 (64bit) assembly
# instructions. Assemble and link these files and trace through the executable with the
# debugger. The idea is to get a sense of how to use these instructions, so you can rip
# this and use it in your own code
#
# If you have any questions, comments, concerns, or find bugs, then just send me an email.
# 
# - richard.m.veras@ou.edu

# Resources to check out:
# http://insightforfuture.blogspot.com/2010/11/x86-assembly-if-else-control-structures.html

	
.section .data
# This example does not make use of the data section	
.section .text
# The .text section is our executable code.

# We need to make the symbol _start available to the loader (ld) and we do this
# with .globl	
.globl _start
_start:

	# example of an if/else
	movq $0x1, %rax
	movq $0xF, %rbx

	cmpq %rax, %rbx
	jle _case_b
_case_a:
	movq $0xBEEF, %rcx
	jmp _end_of_if_else
_case_b:
	movq $0xCAFE, %rcx
_end_of_if_else:
	




	# example of a for loop
	# We are going to multiply 4 by 2 using addition. (2+2+2+2)

	movq $0x0, %rax

	# initialize our counter
	movq $0x4, %rdi
_start_of_loop:
	# if rdi == 0 jump to end
	cmpq $0, %rdi
	je _end_of_loop

	# do some work
	addq $0x2, %rax

	# decrease the counter
	decq %rdi
	jmp _start_of_loop
_end_of_loop:

	
	
	jmp _exit_x86_64bit



	
_exit_x86_64bit:
	# This is slightly different because in x86_64 (64bit) we get the
	# syscall instruction, which provides more flexibility than int (interrupt)
	# so it is the defacto way for making system calls in 64bit binaries, in linux,
	# on systems with the x86_64 instruction set architecture.
	movq $60, %rax  # call number 60 -> exit
	movq $0x0, %rdi # return 0
	syscall #run kernel
	
	
