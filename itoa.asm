global itoa
section .text
itoa:
    mov rax, rdi        ; rdi contains arg0 to match calling convention in linux, we need it in rax for div
    mov rbx, 10         ; we're only going to be dividing by 10
    mov r8, 0           ; use r8 internally to keep track of number of characters in the string
.div_loop:
    xor rdx, rdx        ; set rdx to 0 to stop floating point errors
    div rbx             ; divide rax by rbx (10)
    mov rcx, '0'        ; set rcx to the value of ascii 0
    add rcx, rdx        ; add ascii value of 0 to remainder
    push rcx            ; push ascii character on the stack
    inc r8              ; increment value in r8
    cmp rax, 0          ; check to see if there's anything left to divide
    jnz .div_loop       ; if there is, jump back to .div_loop
    mov rcx, result     ; move the address of result into rcx
.pop_loop:
    pop rax             ; take the left most character from the stack
    mov [rcx], al       ; move the right most 8 bits (ascii) from a into the address in rcx
    inc rcx             ; increment the address in rcx
    dec r8              ; decrement r8 (number of digits left)
    jnz .pop_loop       ; if there's still digits to pop, jump back to .pop_loop
    mov rax, result     ; set result in rax
    ret                 ; return to caller

section .bss
result resb 20          ; max possible length for a 64bit unsigned integer