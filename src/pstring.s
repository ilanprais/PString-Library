.section	.rodata	#read only data section
str:	.string	"%d\n"
    
    .text
.globl pstrlen
    .type pstrlen, @function

pstrlen:
    movzbq (%rdi),%rax
    ret

replaceChar:
    mov $-1,%rcx
    .L1:
        addq $1, %rcx
        cmpq (%rdi,%rcx,8),%rsi
        jne .L2
        mov %rdx,(%rdi,%rcx,8)
    .L2:
        cmpq (%rdi),%rcx
        jge .L1
    
    ret

pstrijcpy:


swapCase:


pstrijcmp: