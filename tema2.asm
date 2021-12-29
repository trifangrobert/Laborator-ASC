.data
	N: .space 4
	sz: .space 4
	M: .space 4
	v: .space 10000
	val: .space 4
	freq: .space 10000
	stk: .space 10000
	answer: .space 10000
	sol: .long 0
	pos: .space 4
	a: .space 4
	b: .space 4
	top: .space 4
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	formatPrintfEnter: .asciz "\n"
.text

get_min:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx

	cmp %ebx, %ecx
	jle ret_min_c
	jg ret_min_b

ret_min_c:
	movl %ecx, %eax
	jmp final_get_min

ret_min_b:
	movl %ebx, %eax
	jmp final_get_min

final_get_min:
	popl %ebp
	ret

get_max:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx

	cmp %ebx, %ecx
	jge ret_max_c
	jl ret_max_b

ret_max_c:
	movl %ecx, %eax
	jmp final_get_max

ret_max_b:
	movl %ebx, %eax
	jmp final_get_max

final_get_max:
	popl %ebp
	ret

check:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %edx ### pozitie
	movl %edx, pos

	movl %edx, %ebx
	subl M, %ebx

	pushl $0
	pushl %ebx
	call get_max
	popl %ebx
	popl %ebx

	movl %eax, a

	movl %edx, %ebx
	addl M, %ebx

	movl sz, %ecx
	decl %ecx

	pushl %ecx
	pushl %ebx
	call get_min
	popl %ebx
	popl %ebx

	movl %eax, b

	xorl %ecx, %ecx
	movl a, %ecx
	movl 12(%ebp), %edx ### valoare
	lea stk, %edi
	movl $1, %eax

et_for_check:
	cmp b, %ecx
	jg final_check

	movl (%edi, %ecx, 4), %ebx
	cmp %ebx, %edx
	je found

	incl %ecx
	jmp et_for_check

found:
	movl $0, %eax

final_check:
	popl %ebp
	ret


init_freq:
	pushl %ebp
	movl %esp, %ebp

	movl $1, %ecx
	lea freq, %edi
et_for_freq:
	cmp N, %ecx
	jg finish_init_freq

	movl $3, %eax
	movl %eax, (%edi, %ecx, 4)

	incl %ecx
	jmp et_for_freq

finish_init_freq:
	popl %ebp
	ret

backtracking:
	pushl %ebp
	movl %esp, %ebp

	cmp $1, sol
	je final_back

	movl 8(%ebp), %edx
	movl %edx, top

	xorl %edx, %edx
	movl sz, %edx
	cmp top, %edx
	je final_recursie

	movl top, %ecx
	lea stk, %edi
	movl (%edi, %ecx, 4), %eax

	cmp $0, %eax
	je solve_back

	incl top
	pushl top
	call backtracking
	popl %ebx
	decl top
	jmp final_back

solve_back:
	xorl %ecx, %ecx
	movl $1, %ecx

	et_for_back:
		cmp N, %ecx
		jg final_back

		lea freq, %esi
		movl (%esi, %ecx, 4), %eax

		cmp $0, %eax
		je incl_et_for_back

		pushl %ecx
		pushl %ecx
		pushl top
		call check
		popl %ebx
		popl %ebx
		popl %ecx

		cmp $0, %eax
		je incl_et_for_back

		lea freq, %esi
		movl (%esi, %ecx, 4), %eax
		decl %eax
		movl %eax, (%esi, %ecx, 4)

		pushl %ecx
		lea stk, %esi
		movl %ecx, %eax
		movl top, %ecx
		movl %eax, (%esi, %ecx, 4)
		popl %ecx

		incl top
		pushl %ecx
		pushl top
		call backtracking
		popl %ebx
		popl %ecx
		decl top

		lea freq, %esi
		movl (%esi, %ecx, 4), %eax
		incl %eax
		movl %eax, (%esi, %ecx, 4)

		pushl %ecx
		lea stk, %esi
		movl top, %ecx
		movl $0, %eax
		movl %eax, (%esi, %ecx, 4)
		popl %ecx

		incl_et_for_back:
			incl %ecx
			jmp et_for_back

final_recursie:
	movl $1, %eax
	movl %eax, sol

	lea stk, %edi
	lea answer, %esi
	xorl %ecx, %ecx
	replace_answer_stk:
		cmp sz, %ecx
		je final_back

		movl (%edi, %ecx, 4), %ebx
		movl %ebx, (%esi, %ecx, 4)
		incl %ecx
		jmp replace_answer_stk
	
final_back:
	popl %ebp
	ret

.global main
main:

read_data:
	pushl $N
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl $3, %ebx
	movl N, %eax
	mull %ebx
	movl %eax, sz

	pushl $M
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx	

	call init_freq

	xorl %ecx, %ecx
	lea v, %edi
	lea freq, %esi
et_for_v:
	cmp sz, %ecx
	je solve

	pushl %ecx
	pushl $val
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popl %ecx

	movl val, %eax
	movl %eax, (%edi, %ecx, 4)
	pushl %esi
	lea stk, %esi
	movl %eax, (%esi, %ecx, 4)
	popl %esi

	cmp $0, %eax
	je inc_for_v

	pushl %ecx
	movl val, %ecx
	movl (%esi, %ecx, 4), %eax
	decl %eax
	movl %eax, (%esi, %ecx, 4)
	popl %ecx
inc_for_v:
	incl %ecx
	jmp et_for_v

solve:
	//TODO daca input ul e gresit
	xorl %ecx, %ecx
	lea stk, %edi
	et_for_i:
		cmp sz, %ecx
		je start_back

		movl (%edi, %ecx, 4), %ebx
		cmp $0, %ebx
		je incl_et_for_i

		movl $0, (%edi, %ecx, 4)

		pushl %ecx
		pushl %ebx
		pushl %ecx
		call check
		popl %ebx
		popl %ebx
		popl %ecx

		movl %ebx, (%edi, %ecx, 4)

		cmp $0, %eax
		je no_solution

		incl_et_for_i:
			incl %ecx
			jmp et_for_i

start_back:
	xorl %eax, %eax
	movl %eax, top
	pushl top
	call backtracking
	popl %ebx
	
print_answer:
	xorl %edx, %edx
	cmp sol, %edx
	je no_solution

	xorl %ecx, %ecx
	lea answer, %esi
	et_for_answer:
		cmp sz, %ecx
		je et_exit

		pushl %ecx
		pushl (%esi, %ecx, 4)
		pushl $formatPrintf
		call printf
		popl %ebx
		popl %ebx
		popl %ecx

		incl %ecx
		jmp et_for_answer

no_solution:
	pushl $-1
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

et_exit:
	pushl $formatPrintfEnter
	call printf
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

