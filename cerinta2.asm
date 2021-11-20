.data
	s: .space 1000
	formatScanf: .asciz "%300[^\n]"
	formatPrintf: .asciz "%d\n"
	sep: .asciz " "
.text
.global main
main:
	pushl $s
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $sep
	pushl $s
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call atoi
	popl %ebx

	pushl %eax

et_while:
	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	cmp $0, %eax
	je et_print

	movl %eax, %edx

	pushl %edx
	pushl %eax
	call atoi
	popl %ebx
	popl %edx
	
	cmp $0, %eax
	je get_op

	pushl %eax
	jmp et_while

get_op:
	movl %edx, %edi
	xorl %ecx, %ecx
	xorl %eax, %eax
	movb (%edi, %ecx, 1), %al
	
	cmp $97, %al 
	je do_add

	cmp $115, %al
	je do_sub

	cmp $109, %al
	je do_mul

	cmp $100, %al
	je do_div


do_add:
	popl %ebx
	popl %eax
	addl %ebx, %eax
	pushl %eax
	jmp et_while

do_sub:
	popl %ebx
	popl %eax
	subl %ebx, %eax
	pushl %eax
	jmp et_while	

do_mul:
	popl %ebx
	popl %eax
	mull %ebx
	pushl %eax
	jmp et_while

do_div:
	xorl %edx, %edx
	popl %ebx
	popl %eax
	divl %ebx
	pushl %eax
	jmp et_while

et_print:
	popl %eax
	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
