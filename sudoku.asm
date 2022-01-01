.data
	read_mode: .asciz "r"
	input_file: .asciz "sudoku.in"
	write_mode: .asciz "w"
	output_file: .asciz "sudoku.out"
	newline: .asciz "\n"
	N: .long 9
	val: .space 4
	all: .long 81
	top: .space 4
	stk: .space 1000
	answer: .space 1000
	freq_lines: .space 1000
	freq_cols: .space 1000
	freq_squares: .space 1000
	sol: .long 0
	format_scanf: .asciz "%d"
	format_printf: .asciz "%d "
.text

update_freq:
	pushl %ebp
	movl %esp, %ebp

	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx

	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	movl 16(%ebp), %ecx
	movl 20(%ebp), %edx

update_freq_lines:
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx

	pushl %edx
	movl $9, %ebx
	mull %ebx
	addl %ecx, %eax
	movl %eax, %ecx
	lea freq_lines, %esi
	movl (%esi, %ecx, 4), %ebx
	popl %edx
	addl %edx, %ebx
	movl %ebx, (%esi, %ecx, 4)

	popl %edx
	popl %ecx
	popl %ebx
	popl %eax

update_freq_cols:
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx

	pushl %edx
	movl %ebx, %eax
	movl $9, %ebx
	mull %ebx
	addl %ecx, %eax
	movl %eax, %ecx
	lea freq_cols, %esi
	movl (%esi, %ecx, 4), %ebx
	popl %edx
	addl %edx, %ebx
	movl %ebx, (%esi, %ecx, 4)

	popl %edx
	popl %ecx
	popl %ebx
	popl %eax

update_freq_squares:
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx

	pushl %edx
	pushl %ecx
	xorl %ecx, %ecx
	pushl %ebx
	xorl %edx, %edx
	movl $3, %ebx
	divl %ebx
	xorl %edx, %edx
	mull %ebx
	popl %ebx
	movl %eax, %ecx
	movl %ebx, %eax
	movl $3, %ebx
	xorl %edx, %edx
	divl %ebx
	addl %eax, %ecx
	movl %ecx, %eax
	movl $9, %ebx
	xorl %edx, %edx
	mull %ebx
	popl %ecx
	addl %eax, %ecx
	popl %edx

	lea freq_squares, %esi
	movl (%esi, %ecx, 4), %ebx
	addl %edx, %ebx
	movl %ebx, (%esi, %ecx, 4)

	popl %eax
	popl %ebx
	popl %ecx
	popl %edx

	popl %edx
	popl %ecx
	popl %ebx
	popl %eax

	popl %ebp
	ret

check:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	movl 16(%ebp), %ecx

check_freq_lines:
	pushl %eax
	pushl %ebx
	pushl %ecx

	movl $9, %ebx
	mull %ebx
	addl %ecx, %eax
	movl %eax, %ecx
	lea freq_lines, %esi
	movl (%esi, %ecx, 4), %ebx
	cmp $0, %ebx
	je return_false

	popl %ecx
	popl %ebx
	popl %eax

check_freq_cols:
	pushl %eax
	pushl %ebx
	pushl %ecx

	movl %ebx, %eax
	movl $9, %ebx
	mull %ebx
	addl %ecx, %eax
	movl %eax, %ecx
	lea freq_cols, %esi
	movl (%esi, %ecx, 4), %ebx
	cmp $0, %ebx
	je return_false

	popl %ecx
	popl %ebx
	popl %eax
	

check_freq_squares:
	pushl %eax
	pushl %ebx
	pushl %ecx

	pushl %ecx
	xorl %ecx, %ecx
	pushl %ebx
	xorl %edx, %edx
	movl $3, %ebx
	divl %ebx
	xorl %edx, %edx
	mull %ebx
	popl %ebx
	movl %eax, %ecx
	movl %ebx, %eax
	movl $3, %ebx
	xorl %edx, %edx
	divl %ebx
	addl %eax, %ecx
	movl %ecx, %eax
	movl $9, %ebx
	xorl %edx, %edx
	mull %ebx
	popl %ecx
	addl %eax, %ecx

	lea freq_squares, %esi
	movl (%esi, %ecx, 4), %ebx
	cmp $0, %ebx
	je return_false

	popl %ecx
	popl %ebx
	popl %eax

return_true:
	movl $1, %edx
	jmp end_check

return_false:
	popl %ecx
	popl %ebx
	popl %eax
	movl $0, %edx
	jmp end_check

end_check:
	popl %ebp
	ret

get_pos_pair:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %eax
	xorl %edx, %edx
	movl $9, %ebx
	divl %ebx
	movl %edx, %ebx

	popl %ebp
	ret


backtracking:
	pushl %ebp
	movl %esp, %ebp

	cmp $1, sol
	je final_back

	movl 8(%ebp), %edx
	movl %edx, top 
	cmp $81, top
	je final_recursie

	movl top, %ecx
	lea stk, %edi
	movl (%edi, %ecx, 4), %eax

	cmp $-1, %eax
	je solve_back

	incl top
	pushl top
	call backtracking
	popl %ebx
	decl top
	jmp final_back

solve_back:
	pushl top
	call get_pos_pair
	popl %ecx

	xorl %ecx, %ecx

	et_for_back:
		cmp $9, %ecx
		je final_back

		pushl %ecx
		pushl %ebx
		pushl %eax
		call check
		popl %eax
		popl %ebx
		popl %ecx

		cmp $0, %edx
		je incl_et_for_back

		pushl $-1
		pushl %ecx
		pushl %ebx
		pushl %eax
		call update_freq
		popl %eax
		popl %ebx
		popl %ecx
		popl %edx

		pushl %ecx
		pushl %eax

		movl %ecx, %eax
		movl top, %ecx
		lea stk, %edi
		movl %eax, (%edi, %ecx, 4)

		popl %eax
		popl %ecx

		incl top
		pushl %ecx
		pushl %ebx
		pushl %eax
		pushl top
		call backtracking
		popl %ebx
		popl %eax
		popl %ebx
		popl %ecx
		decl top

		pushl %ecx
		pushl %eax

		movl $-1, %eax
		movl top, %ecx
		lea stk, %edi
		movl %eax, (%edi, %ecx, 4)

		popl %eax
		popl %ecx

		pushl $1
		pushl %ecx
		pushl %ebx
		pushl %eax
		call update_freq
		popl %eax
		popl %ebx
		popl %ecx
		popl %edx

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
		cmp $81, %ecx
		je final_back

		movl (%edi, %ecx, 4), %ebx
		movl %ebx, (%esi, %ecx, 4)
		incl %ecx
		jmp replace_answer_stk

final_back:
	popl %ebp
	ret

init_freq:
	pushl %ebp
	movl %esp, %ebp

	xorl %ecx, %ecx
et_for_init_freq:
	cmp all, %ecx
	je end_init_freq

	lea freq_lines, %edi
	movl $1, %eax
	movl %eax, (%edi, %ecx, 4)

	lea freq_cols, %edi
	movl $1, %eax
	movl %eax, (%edi, %ecx, 4)

	lea freq_squares, %edi
	movl $1, %eax
	movl %eax, (%edi, %ecx, 4)

	incl %ecx
	jmp et_for_init_freq

end_init_freq:
	popl %ebp
	ret

.global main

main:
	call init_freq

	pushl $read_mode
	pushl $input_file
	call fopen
	popl %ebx
	popl %ebx

	lea stk, %edi
	xorl %ecx, %ecx
et_for_read_sudoku:
	cmp all, %ecx
	je end_read_sudoku

	pushl %ecx
	pushl $val
	pushl $format_scanf
	pushl %eax
	call fscanf
	popl %eax
	popl %ebx
	popl %ebx
	popl %ecx

	decl val	
	movl val, %ebx
	movl %ebx, (%edi, %ecx, 4)

	movl val, %ebx
	cmp $-1, %ebx
	je continue_et_for_read_sudoku

	pushl %eax
	pushl %ecx

	xorl %edx, %edx
	movl %ecx, %eax
	movl $9, %ebx
	divl %ebx

	pushl $-1
	pushl val
	pushl %edx
	pushl %eax
	call update_freq
	popl %ebx
	popl %ebx
	popl %ebx
	popl %ebx

	popl %ecx
	popl %eax

continue_et_for_read_sudoku:
	incl %ecx
	jmp et_for_read_sudoku

end_read_sudoku:
	pushl %eax
	call fclose
	popl %ebx
	jmp check_input

check_input:
	xorl %ecx, %ecx
	lea stk, %edi

	for_check:
		cmp $81, %ecx
		je solve

		lea freq_lines, %edi
		movl (%edi, %ecx, 4), %eax
		cmp $0, %eax
		jl no_solution 

		lea freq_cols, %edi
		movl (%edi, %ecx, 4), %eax
		cmp $0, %eax
		jl no_solution

		lea freq_squares, %edi
		movl (%edi, %ecx, 4), %eax
		cmp $0, %eax
		jl no_solution
		
	continue_for_check:
		incl %ecx
		jmp for_check

solve:
	pushl $0
	call backtracking
	popl %ebx
	cmp $0, sol
	je no_solution

print_sudoku:
	pushl $write_mode
	pushl $output_file
	call fopen
	popl %ebx
	popl %ebx

	lea answer, %edi
	xorl %ecx, %ecx
	et_for_print_sudoku:
		cmp all, %ecx
		je end_print_sudoku

		movl (%edi, %ecx, 4), %ebx
		incl %ebx

		pushl %ecx
		pushl %ebx
		pushl $format_printf
		pushl %eax
		call fprintf
		popl %eax
		popl %ebx
		popl %ebx
		popl %ecx

		incl %ecx

		pushl %ecx
		pushl %eax

		xorl %edx, %edx
		movl %ecx, %eax
		movl $9, %ebx
		divl %ebx
		cmp $0, %edx
		jne continue_et_for_print_sudoku

		popl %eax

		pushl $newline
		pushl %eax
		call fprintf
		popl %eax
		popl %ebx

		popl %ecx

		jmp et_for_print_sudoku

	continue_et_for_print_sudoku:
		popl %eax
		popl %ecx
		jmp et_for_print_sudoku

end_print_sudoku:
	pushl %eax
	call fclose
	popl %ebx
	jmp et_exit

no_solution:
	pushl $write_mode
	pushl $output_file
	call fopen
	popl %ebx
	popl %ebx

	movl $-1, %ebx
	pushl %ebx
	pushl $format_printf
	pushl %eax
	call fprintf
	popl %eax
	popl %ebx
	popl %ebx

	pushl $newline
	pushl %eax
	call fprintf
	popl %eax
	popl %ebx

	pushl %eax
	call fclose
	popl %ebx

et_exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
