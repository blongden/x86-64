global print
section .text
print:
	xor rdx, rdx        ; set rdx to 0
	mov rbp, rsi        ; set branch pointer to address in rdi (arg0)
count:
    cmp [rbp], byte 0   ; reached null byte?
    jz count.end        ; yes
    inc rdx             ; inc byte count
    inc rbp             ; inc pointer
    jmp count           ; loop until null
count.end:
    mov rax, 1          ; call for sys_write
    mov rdi, 1          ; stdout
    syscall
    ret                 ; return to caller

section .bss
result resb 20          ; max possible length for a 64bit unsigned integer