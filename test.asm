%include "itoa.asm"
%include "print.asm"

section .text
global _start
_start:
    mov rdi, 696969       ; argument for itoa
    call itoa           ; call itoa

    mov rsi, rax        ; put result of itoa in rsi for write operation
    call println
exit:
    mov rax, 60         ; sys_exit 
    mov rdi, 0          ; code 0 (successful)
    syscall

section .data
int_val db 69
char_val db "Hello, world!", 10
.len equ $ -char_val

