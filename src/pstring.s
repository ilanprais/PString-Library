.section	.rodata	#read only data section
    
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
    jl .L4
    cmp %r10,%rcx # check j >= len
    jge .L4
    cmp %r11,%rcx
    jge .L4
    cmp %r10,%r11 # check i > j
    jl .L4

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


swapCase:


pstrijcmp: