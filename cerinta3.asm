.data
	s: .space 1000
	formatScanf: .asciz "%300[^\n]"
	formatPrintf: .asciz "%d\n"
	sep: .asciz " "
	values: .space 200
.text
.global main
main:
	xorl %ecx, %ecx
	movl $values, %edi
et_for:
	movl $-1, (%edi, %ecx, 4)
	incl %ecx

	cmp $26, %ecx
	jne et_for


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

	movl %eax, %edx

	pushl %edx
	pushl %eax
	call atoi
	popl %ebx
	popl %edx

	cmp $0, %eax
	je solve_variable
	jne put_value


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
	jne put_value

	pushl %edx
	pushl %edx
	call strlen
	popl %ebx
	popl %edx

	cmp $1, %eax
	jg get_op
	je solve_variable

solve_variable:
	movl %edx, %esi
	xorl %ecx, %ecx
	xorl %eax, %eax
	movb (%esi, %ecx, 1), %al

	subl $97, %eax
	movl %eax, %ecx
	xorl %eax, %eax
	movl (%edi, %ecx, 4), %eax
		
	cmp $-1, %eax
	jne put_value

	xorl %eax, %eax
	movl %ecx, %eax
	
put_value:
	pushl %eax
	jmp et_while

get_op:
	movl %edx, %esi
	xorl %ecx, %ecx
	xorl %eax, %eax
	movb (%esi, %ecx, 1), %al
	
	cmp $97, %al 
	je do_add

	cmp $115, %al
	je do_sub

	cmp $109, %al
	je do_mul

	cmp $100, %al
	je do_div

	cmp $108, %al
	je do_let


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

do_let:
	popl %ebx
	popl %eax
	xorl %ecx, %ecx
	movl %eax, %ecx
	movl %ebx, (%edi, %ecx, 4)
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
