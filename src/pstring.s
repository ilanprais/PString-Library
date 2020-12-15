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

pstrijcpy:


swapCase:


pstrijcmp: