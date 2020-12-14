.section	.rodata	#read only data section
str1:	.string	"l1\n"
str2:	.string	"l2\n"
str3:	.string	"l3\n"
.L50:
    .quad .L51
    .quad .L52
    .quad .L53
    .quad .L11
    
    .text
.globl run_func
    .type run_func, @function
run_func:
    pushq	%rbp		#save the old frame pointer
	movq	%rsp,	%rbp	#create the new frame pointer
    
    jmp *.L50(,%rdi,8)

.L51:
    movq    $str1,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L52:
    movq    $str2,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L53:
    movq    $str3,%rdi  
    movq	$0,%rax
    call    printf
    jmp .L11

.L11:
    movq	$0, %rax	#return value is zero (just like in c - we tell the OS that this program finished seccessfully)
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
    ret