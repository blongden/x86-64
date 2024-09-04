section .text

count:
    cmp byte [rbp], 0   ; reached null byte?
    jz count.end        ; yes
    inc rdx             ; inc byte count
    inc rbp             ; inc pointer
    jmp count           ; loop until null
count.end:
    ret

global print
print:
    push rdx
    push rcx
    push rbx
    push rax

	xor rdx, rdx        ; set rdx to 0
	mov rbp, rsi        ; set branch pointer to address in rsi (arg0)

    call count

    mov rax, 1          ; call for sys_write
    mov rdi, 1          ; stdout
    syscall

    pop rax
    pop rbx
    pop rcx
    pop rdx
    ret                 ; return to caller

global println
println:
    call print
    push rax
    mov rax, 10
    push rax
    mov rsi, rsp
    call print
    pop rax
    pop rax
    ret