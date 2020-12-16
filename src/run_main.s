    .section	.rodata	#read only data section
inputstrint: .string "%d"
inputstr:    .string "%s"
# The main code section #
    .text

    .globl run_main
    .type run_main, @function
run_main:
    # Frame pointer
    pushq   %rbp		
	movq	%rsp,%rbp	

    # First pstring input
    subq    $256,%rsp   # Allocating memory for the struct
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movq    (%rsp),%r12 # saving the length in %r12

    movq    %rsp,%rsi
    movq    $inputstr, %rdi
    movq    $0,%rax
    call    scanf       # saving the string in the stack frame
    subq    $1,%rsp     # creating space for the length byte
    movb    %r12b,(%rsp)
    mov     %rsp,%r13   # Saving the first pstring at %r13

    # Second pstring input
    subq    $255, %rsp  # Allocating memory for the struct
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movq    (%rsp),%r12 # saving the length in %r12

    movq    %rsp,%rsi
    movq    $inputstr, %rdi
    movq    $0,%rax
    call    scanf       # saving the string in the stack frame
    subq    $1,%rsp     # creating space for the length byte
    movb    %r12b,(%rsp)
    movq    %rsp,%r14   # Saving the second pstring at %r14

    # Option input
    subq    $15, %rsp
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%rdi # saving the option as first parameter

    # moving pstrings to parameters
    movq    %r13,%rsi
    movq    %r14,%rdx

    call    run_func    # calling the option jump table

    # stack frame reset and return
    movq    $0,%rax	
	movq    %rbp,%rsp	
	popq    %rbp	
    ret
    
