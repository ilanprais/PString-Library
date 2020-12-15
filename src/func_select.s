.section	.rodata	#read only data section
str1:	.string	"l1\n"
print:  .string "%d\n"
invalid: .string "invalid option!\n"
strplen: .string "first pstring length: %d, second pstring length: %d\n"
strreplace: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
strijcpy: .string "length: %d, string: %s\n"
strcmp: .string "compare result: %d\n"
.L40:
    .quad .L50
    .quad .L11
    .quad .L52
    .quad .L53
    .quad .L54
    .quad .L55
    
    .text
.globl run_func
    .type run_func, @function
#### Start Function ####
run_func:
    #Frame pointer
    pushq	%rbp		
	movq	%rsp,%rbp	
    
    subq $50,%rdi
    cmpq $10,%rdi
    je .L20 # if we got 60 then convert to 50
    jmp .L21 # continue to jump table logic

#### Jump Table Logic ####
.L21:
    cmpq $6,%rdi # check option validity
    ja .L12
    jmp *.L40(,%rdi,8)

.L20:
    subq $10,%rdi
    jmp .L21

#### Jump Table Options ####
.L50:
    movq %rsi,%rdi
    call pstrlen
    movq %rax,%rsi
    movq %rdx,%rdi
    call pstrlen
    movq %rax,%rdx
    movq    $strplen,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L52:
    movq %rdx, %r12
    movq %rsi, %rdi
    movq $98, %rsi
    movq $99, %rdx
    call replaceChar
    movq %rdi, %rcx

    movq %r12, %rdi
    movq $98, %rsi
    movq $99, %rdx
    call replaceChar
    movq %rdi, %r8

    movq $98, %rsi
    movq $99, %rdx
    
    movq    $strreplace,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L53:
    movq %rsi,%rdi
    movq %rdx,%rsi
    movq $1,%rdx
    movq $3,%rcx
    call pstrijcpy
    movzbq (%rdi),%r12
    movq %rdi,%rdx
    movq %r12,%rsi
    movq $strijcpy,%rdi  
    movq $0,%rax
    call printf
    jmp .L11

.L54:
    movq %rdx,%r12 # saving 3rd argument for later
    movq %rsi,%rdi
    call swapCase
    movq %rdi,%rdx
    movzbq (%rdi),%rsi
    movq $strijcpy,%rdi  
    movq $0,%rax
    call printf

    movq %r12,%rdi
    call swapCase
    movq %rdi,%rdx
    movzbq (%rdi),%rsi
    movq $strijcpy,%rdi  
    movq $0,%rax
    call printf

    jmp .L11

.L55:
    movq %rsi,%rdi
    movq %rdx,%rsi
    movq $0, %rdx
    movq $2, %rcx
    call pstrijcmp
    movq %rax,%rsi
    movq $strcmp,%rdi  
    movq $0,%rax
    call printf
    jmp .L11

#### invalid option ####
.L12:
    movq    $invalid,%rdi  
    movq	$0,%rax
    call    printf

#### Function termination and return ####
.L11:
    movq	$0,%rax	
	movq	%rbp,%rsp	
	popq	%rbp		
    ret