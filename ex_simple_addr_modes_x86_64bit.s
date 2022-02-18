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
	# i.e. movq (for quad word, 8 bytes, 64bit)
	# i.e. movl (for .long, double word, 4 bytes, 64bit)
	
	movq $128, %rax # Using base 10
	movq $0x00000080, %rbx # same value in base 16 (Hex)
	movq $0x600DCAFE, %rcx # We can make silly words in hex to make (Good Cafe)
	movq $0xBADD3CAF, %rdx # (bad decaf)
	movq $0xB01DFACE, %rdi # (boldface)
	movq $0xDEADBEEF, %rsi # (dead beef)

	############################
	# moving between registers #
	############################
	# We actually have a lot of registers in 64 bit like r8 through r15
	# that can be used in the same way, but we will restrict ourselves
	# to these six
	# note: still using "movq" because these are 64bit quadwords
	movq %rbx, %rax
	movq %rcx, %rbx
	movq %rdx, %rcx
	movq %rdi, %rdx
	movq %rax, %rdi

	# Just for completeness I will include the extra registers.
	movq %rax, %r8
	movq %rax, %r9
	movq %rax, %r10
	movq %rax, %r11
	movq %rax, %r12
	movq %rax, %r13	
	movq %rax, %r14
	movq %rax, %r15


	# Nothing is stoping us from using just the 32bit part of these registers
	# Let us throw some 64 bit junk into our registers and see what happens when
	# we use the 32 bit double word instructions.
	movq $0xFFFFFFFFFFFFFFFF, %rax
	movq $0xFFFFFFFFFFFFFFFF, %rbx
	movq $0xFFFFFFFFFFFFFFFF, %rcx
	movq $0xFFFFFFFFFFFFFFFF, %rdx
	movq $0xFFFFFFFFFFFFFFFF, %rdi
	movq $0xFFFFFFFFFFFFFFFF, %rsi
	

	###########################
	# moving immediate values #
	###########################	
	# we use movl -- emphasis on the "l" -- because these are 32bit
	
	movl $0, %eax # Using base 10
	movl $0x0000, %ebx # same value in base 16 (Hex)
	movl $0xD065, %ecx # We can make silly words in hex to make
	                  # things easier to read. ("dogs")
	movl $0xCA75, %edx # ("cats")
	movl $0xCAF3, %edi #
	movl $0xBEEF, %esi #

	# moving between registers
	# note: still using "movl" because these are 32bit .longs
	movl %ebx, %eax
	movl %ecx, %ebx
	movl %edx, %ecx
	movl %edi, %edx
	movl %eax, %edi


	# One thought to leave you on. There are situations where we might want to
	# "mix" the register types. For example, we want to use 64bit addresses, but
	# work on 32bit data. In these situations you would see the %eXX registers mixed
	# with the %rXX registers in the same instruction.

	
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
	
	
