section .text
global _start
itoa:
    mov rax, [rsp+8]
    mov rbx, 10
    mov r8, 0
.div_loop:
    xor rdx, rdx
    div rbx

    mov rcx, '0'
    add rcx, rdx        ; add ascii value of 0 to remainder
    push rcx
    inc r8
    cmp rax, 0
    jnz .div_loop

    mov rcx, result
.pop_loop:
    pop rax
    mov [rcx], al
    inc rcx
    dec r8
    jnz .pop_loop

    ret

_start:
    push 123456789
    call itoa
    pop rax ; clean up the stack

    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, result
    mov rdx, 20          ; length of string
    syscall


exit:
    mov rax, 60
    mov rdi, 0
    syscall

section .data
int_val db 69
char_val db "Hello, world!", 10
.len equ $ -char_val

section .bss
result resb 20
