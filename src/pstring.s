.section	.rodata	#read only data section
str:	.string	"ere\n"
    
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
    ret

.globl pstrijcpy
    .type pstrijcpy, @function
pstrijcpy:

    movq %rdx,%r10 # src counter
    movq $1,%r11 # dest counter
    .L3:
        cmp %rbx,%r11
        jle .L5
    .L4:
        ret
    .L5:
        movb (%rsi,%r10,1), %bpl
        movb %bpl,(%rdi,%r11,1)
        addq $1,%r10
        addq $1,%r11
        jmp .L3


swapCase:


pstrijcmp: