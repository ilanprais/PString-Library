.section	.rodata	#read only data section
invalid:  .string "invalid input!\n"
    .text
.globl pstrlen
    .type pstrlen, @function
pstrlen:
    movzbq (%rdi),%rax
    ret

.globl replaceChar
    .type replaceChar, @function
replaceChar:
    movzbq (%rdi),%r11
    mov $0,%r10
    .L1:
        addq $1, %r10
        movzbq (%rdi,%r10,1),%rbx
        cmpq %rbx,%rsi
        jne .L2
        movb %dl,(%rdi,%r10,1)
    .L2:
        cmpq %r11,%r10
        jle .L1
    movq %rdi, %rax
    ret

.globl pstrijcpy
    .type pstrijcpy, @function
pstrijcpy:
    # out of bounds check
    movzbq (%rdi),%r10
    movzbq (%rsi),%r11
    cmp $0,%rdx # check i < 0
    jl .L6
    cmp %r10,%rcx # check j >= len
    jge .L6
    cmp %r11,%rcx
    jge .L6
    cmp %r10,%r11 # check i > j
    jl .L6

    movq %rdx,%r10 # i counter
    movq %rcx,%r11 # j counter
    .L3:
        cmp %r11,%r10
        jle .L5
    .L4:
        movq %rdi, %rax
        ret
    .L5:
        addq $1,%r10
        movb (%rsi,%r10,1), %bl
        movb %bl,(%rdi,%r10,1)
        jmp .L3
    .L6:
        movq %rdi, %rbx
        movq $invalid,%rdi  
        movq $0,%rax
        call printf
        movq %rbx, %rdi
        movq %rbx, %rax
        ret

.globl swapCase
    .type swapCase, @function
swapCase:
    movzbq (%rdi),%r11
    mov $0,%r10
    .L7:
        cmp %r11,%r10
        jle .L9
    .L8:
        ret
    .L9:
        addq $1,%r10
        movb (%rdi,%r10,1), %bl
        cmp $97, %bl
        jge .L10
        cmp $65, %bl
        jge .L11
        jmp .L7
    .L10:
        cmp $122, %bl
        jle .L12
        jmp .L7
    .L11:
        cmp $90, %bl
        jle .L13
        jmp .L7
    .L12:
        subb $32,%bl
        movb %bl,(%rdi,%r10,1)
        jmp .L7
    .L13:
        addb $32,%bl
        movb %bl,(%rdi,%r10,1)
        jmp .L7


pstrijcmp: