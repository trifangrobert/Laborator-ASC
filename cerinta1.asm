.data
	formatScanf: .asciz "%s"
	formatPrintfInt: .asciz "%d "
	formatPrintfChar: .asciz "%c "
	formatPrintfString: .asciz "%s "
	displayMinus: .asciz "%c"
	valueSign: .long 1
	letString: .asciz "let"
	addString: .asciz "add"
	subString: .asciz "sub"
	divString: .asciz "div"
	mulString: .asciz "mul"
	base16: .space 10000
	base2: .space 40000
	sz_base2: .long 0
.text
.global main

main:
	# read
	pushl $base16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl $base16, %edi
	movl $base2, %esi
	xorl %ecx, %ecx

et_for1:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je solve

	cmp $48, %al
	je digit0

	cmp $49, %al
	je digit1

	cmp $50, %al
	je digit2

	cmp $51, %al
	je digit3

	cmp $52, %al
	je digit4

	cmp $53, %al
	je digit5

	cmp $54, %al
	je digit6

	cmp $55, %al
	je digit7

	cmp $56, %al
	je digit8

	cmp $57, %al
	je digit9

	cmp $65, %al
	je digitA

	cmp $66, %al
	je digitB

	cmp $67, %al
	je digitC

	cmp $68, %al
	je digitD

	cmp $69, %al
	je digitE

	cmp $70, %al
	je digitF

cont:
	incl %ecx
	jmp et_for1


digit0:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont

digit1:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont

digit2:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont

digit3:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digit4:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digit5:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digit6:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digit7:
	pushl %ecx
	movl sz_base2, %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digit8:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digit9:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digitA:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digitB:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digitC:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont



digitD:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digitE:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $48, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


digitF:
	pushl %ecx
	movl sz_base2, %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	movb $49, (%esi, %ecx, 1)
	incl %ecx

	addl $4, sz_base2 
	popl %ecx
	jmp cont


solve:
	movl $base2, %edi
	xorl %ecx, %ecx

et_for:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je exit

	xorl %edx, %edx
	# sar peste primul bit care e mereu 1
	# formez identificatorul
	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %edx
	addl %eax, %edx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %edx
	addl %eax, %edx

	# am in edx identificatorul

	cmp $0, %edx
	je get_value

	cmp $1, %edx
	je get_variable

	cmp $2, %edx
	je get_op

get_op:
	incl %ecx
	jmp last8

continue_get_op:
	cmp $0, %ebx
	je put_let

	cmp $1, %ebx
	je put_add

	cmp $2, %ebx
	je put_sub

	cmp $3, %ebx
	je put_mul

	cmp $4, %ebx
	je put_div

put_let:
	pushl %edx
	pushl %ecx

	pushl $letString
	pushl $formatPrintfString
	call printf
	popl %ebx
	popl %ebx

	popl %ecx
	popl %edx

	jmp finish_get_op

put_add:
	pushl %edx
	pushl %ecx

	pushl $addString
	pushl $formatPrintfString
	call printf
	popl %ebx
	popl %ebx

	popl %ecx
	popl %edx

	jmp finish_get_op

put_sub:
	pushl %edx
	pushl %ecx

	pushl $subString
	pushl $formatPrintfString
	call printf
	popl %ebx
	popl %ebx

	popl %ecx
	popl %edx

	jmp finish_get_op


put_mul:
	pushl %edx
	pushl %ecx

	pushl $mulString
	pushl $formatPrintfString
	call printf
	popl %ebx
	popl %ebx

	popl %ecx
	popl %edx

	jmp finish_get_op

put_div:
	pushl %edx
	pushl %ecx

	pushl $divString
	pushl $formatPrintfString
	call printf
	popl %ebx
	popl %ebx

	popl %ecx
	popl %edx

	jmp finish_get_op

finish_get_op:
	incl %ecx
	jmp et_for

get_variable:
	incl %ecx
	jmp last8

continue_get_variable:
	movl %ebx, %eax
	pushl %edx
	pushl %ecx

	pushl %eax
	pushl $formatPrintfChar
	call printf
	popl %ebx
	popl %ebx

	popl %ecx
	popl %edx

	incl %ecx
	jmp et_for

get_value:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $49, %al
	jne last8

put_minus:
	xorl %eax, %eax
	movl $45, %eax

	pushl %ecx
	pushl %edx
	pushl %eax
	pushl $displayMinus
	call printf
	popl %ebx
	popl %ebx
	popl %edx
	popl %ecx
	jmp last8
	

continue_get_value:
	movl %ebx, %eax
	mull valueSign

	pushl %edx
	pushl %ecx
	pushl %eax
	pushl $formatPrintfInt
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	popl %edx

	incl %ecx
	jmp et_for
	

last8:
	xorl %ebx, %ebx
	xorl %eax, %eax
	
	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	incl %ecx
	movb (%edi, %ecx, 1), %al
	subl $48, %eax
	shl $1, %ebx
	addl %eax, %ebx

	cmp $0, %edx
	je continue_get_value

	cmp $1, %edx
	je continue_get_variable

	cmp $2, %edx
	je continue_get_op

exit:
	pushl $0
	call fflush
	popl %ebx
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
