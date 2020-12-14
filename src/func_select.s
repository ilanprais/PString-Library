.section	.rodata	#read only data section
str1:	.string	"l1\n"
print:  .string "%d\n"
strplen: .string "first pstring length: %d, second pstring length: %d\n"
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
    je .L20 #if we got 60 then convert to 50
    jmp .L21 #continue to jump table logic

#### Jump Table Logic ####
.L21:
    cmpq $6,%rdi
    ja .L11
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
    movq    $str1,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L53:
    movq    $str1,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L54:
    movq    $str1,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L55:
    movq    $str1,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

#### Function termination and return ####
.L11:
    movq	$0,%rax	
	movq	%rbp,%rsp	
	popq	%rbp		
    ret