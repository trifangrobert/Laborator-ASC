.data
	matrix: .space 2000
	value: .space 4
	sz: .space 4
	N: .space 4
	M: .space 4
	i: .space 4
	j: .space 4
	index: .space 4
	s: .space 500
	sep: .asciz " "
	formatPrintfEnter: .asciz "\n"
	formatScanf: .asciz "%2000[^\n]"
	formatPrintf: .asciz "%d "
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

	lea matrix, %edi

	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	pushl %edx
	pushl %eax
	call atoi
	popl %ebx
	popl %edx
	movl %eax, N

	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %edx
	pushl %eax
	call atoi
	popl %ebx
	popl %edx
	movl %eax, M

	xorl %eax, %eax
	movl N, %eax
	mull M
	movl %eax, sz

	movl $0, index
et_for:
	movl index, %ecx 
	cmp sz, %ecx
	je solve

	pushl %ecx

	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %edx
	pushl %eax
	call atoi
	popl %ebx
	popl %edx

	popl %ecx
	movl %eax, (%edi, %ecx, 4)

	incl index
	jmp et_for

solve:
	# sar peste let
	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call strlen
	popl %ebx

	cmp $6, %eax
	je do_rotate

	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call atoi
	popl %ebx

	movl %eax, value

	pushl $sep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, %esi
	xorl %ecx, %ecx
	xorl %eax, %eax
	movb (%esi, %ecx, 1), %al

	cmp $97, %eax
	je do_add

	cmp $115, %eax
	je do_sub

	cmp $109, %eax
	je do_mul

	cmp $100, %eax
	je do_div

do_add:
	movl $0, index

et_add_for:
	movl index, %ecx 
	cmp sz, %ecx
	je et_print

	xorl %eax, %eax
	movl (%edi, %ecx, 4), %eax

	addl value, %eax

	movl %eax, (%edi, %ecx, 4)

	incl index
	jmp et_add_for

do_sub:
	movl $0, index

et_sub_for:
	movl index, %ecx 
	cmp sz, %ecx
	je et_print

	xorl %eax, %eax
	movl (%edi, %ecx, 4), %eax

	subl value, %eax

	movl %eax, (%edi, %ecx, 4)

	incl index
	jmp et_sub_for


do_mul:
	movl $0, index

et_mul_for:
	movl index, %ecx 
	cmp sz, %ecx
	je et_print

	xorl %eax, %eax
	movl (%edi, %ecx, 4), %eax

	xorl %edx, %edx
	imull value

	movl %eax, (%edi, %ecx, 4)

	incl index
	jmp et_mul_for


do_div:
	movl $0, index

et_div_for:
	movl index, %ecx 
	cmp sz, %ecx
	je et_print

	xorl %eax, %eax
	movl (%edi, %ecx, 4), %eax

	xorl %edx, %edx
	cdq
	idivl value

	movl %eax, (%edi, %ecx, 4)

	incl index
	jmp et_div_for


do_rotate:
	pushl M
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl N
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	movl $0, j
	et_for_j:
		xorl %ecx, %ecx
		movl j, %ecx
		cmp M, %ecx
		je exit

		xorl %eax, %eax
		movl N, %eax
		decl %eax
		movl %eax, i

		et_for_i:
			xorl %ecx, %ecx
			movl i, %ecx
			cmp $-1, %ecx
			je continue_for_j

			xorl %eax, %eax
			movl i, %eax
			mull M
			addl j, %eax

			xorl %ecx, %ecx
			movl %eax, %ecx

			xorl %eax, %eax
			movl (%edi, %ecx, 4), %eax

			pushl %eax
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx

			decl i
			jmp et_for_i

	continue_for_j:
		incl j
		jmp et_for_j

et_print:
	pushl N
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl M
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	movl $0, index

et_print_for:
	movl index, %ecx 
	cmp sz, %ecx
	je exit

	xorl %eax, %eax
	movl (%edi, %ecx, 4), %eax

	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	incl index
	jmp et_print_for

exit:
	pushl $formatPrintfEnter
	call printf
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
