.data
	helloWorld: .asciz "Hello, world!\n"
.text
.global _start
_start:
	mov $4, %eax
	mov $1, %ebx
	mov $helloWorld, %ecx
	mov $15, %edx
	int $0x80

	mov $1, %eax
	mov $0, %ebx
	int $0x80
