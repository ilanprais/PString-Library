.section	.rodata	#read only data section
invalid:    .string "invalid option!\n"
strplen:    .string "first pstring length: %d, second pstring length: %d\n"
strreplace: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
strijcpy:   .string "length: %d, string: %s\n"
strcmp:     .string "compare result: %d\n"
inputstr:   .string " %c"
inputstrint:.string "%d"
# The jump table labels
.L40:
    .quad .L50
    .quad .L11
    .quad .L52
    .quad .L53
    .quad .L54
    .quad .L55
# The main code section #
    .text
.globl run_func
    .type run_func, @function
# Start Function #
run_func:
    # Frame pointer
    pushq	%rbp		
	movq	%rsp,%rbp	
    
    subq    $50,%rdi # manipulation input to be between 1 and 10
    cmpq    $10,%rdi # if 60 (60 - 50 = 10) 
    je      .L20    # if we got 60 then convert to 50
    jmp     .L21    # continue to jump table logic

# Jump Table Logic #
.L21:
    cmpq    $6,%rdi # check option validity
    ja      .L12
    jmp     *.L40(,%rdi,8) # jump to label according to jump table

.L20:
    subq    $10,%rdi # subtract 10 if neccesary (when input is 60)
    jmp     .L21

# Jump Table Options #
# Calculate string length #
.L50:
    # first string
    movq    %rsi,%rdi # move pstring as first parameter
    call    pstrlen
    movq    %rax,%rsi # save in rsi
    # second string
    movq    %rdx,%rdi
    call    pstrlen
    movq    %rax,%rdx # save in rdx
    movq    $strplen,%rdi  
    movq	$0,%rax
    call    printf
    jmp     .L11

# Replace char #
.L52:
    movq    %rsi,%r13 # save first pstring for later
    movq    %rdx, %r12 # save second pstring for later

    # first input
    subq    $16, %rsp
    movq    %rsp,%rsi
    movq    $inputstr, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%r14 # save first char in %r14

    # second input
    subq    $16, %rsp
    movq    %rsp,%rsi
    movq    $inputstr, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%r15 # save second char in %r15

    # move chars and first string to parameters and replace
    movq    %r13, %rdi
    movq    %r14, %rsi
    movq    %r15, %rdx
    call    replaceChar
    movq    %rdi, %rcx

    # move chars and second string to parameters and replace
    movq    %r12, %rdi
    movq    %r14, %rsi
    movq    %r15, %rdx
    call    replaceChar
    movq    %rdi, %r8

    # move strings to parameters and print
    movq    %r14, %rsi
    movq    %r15, %rdx
    
    movq    $strreplace,%rdi  
    movq	$0,%rax
    call    printf
    jmp     .L11

# Copy i to j #
.L53:
    movq   %rsi,%r12 # save first pstring for later
    movq   %rdx,%r13 # save second pstring for later

    # first input - i
    subq    $16, %rsp
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%r14

    # second input - j
    subq    $16, %rsp
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%r15

    # move to function parameters and call strigcpy
    movq    %r12,%rdi
    movq    %r13,%rsi
    movq    %r14,%rdx
    movq    %r15,%rcx
    call    pstrijcpy

    # move to printf parameters and print first string
    movzbq  (%rdi),%r12
    movq    %rdi,%rdx
    movq    %r12,%rsi
    movq    $strijcpy,%rdi  
    movq    $0,%rax
    call    printf

    # move to printf parameters and print second string
    movzbq  (%r13),%r12
    movq    %r13,%rdx
    movq    %r12,%rsi
    movq    $strijcpy,%rdi  
    movq    $0,%rax
    call    printf
    jmp     .L11

# Upper to lower and lower to upper #
.L54:
    movq    %rdx,%r12   # saving second pstring for later
    movq    %rsi,%rdi   # calling swapCase on first string
    call    swapCase

    # Printing result
    movq    %rdi,%rdx
    movzbq  (%rdi),%rsi
    movq    $strijcpy,%rdi  
    movq    $0,%rax
    call    printf

    # calling swapCase on second string
    movq    %r12,%rdi
    call    swapCase

    # Printing result
    movq    %rdi,%rdx
    movzbq  (%rdi),%rsi
    movq    $strijcpy,%rdi  
    movq    $0,%rax
    call    printf

    jmp     .L11

# Compare pstrings between i and j #
.L55:
    movq   %rsi,%r12 # save first pstring for later
    movq   %rdx,%r13 # save second pstring for later

    # first input - i
    subq    $16, %rsp
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%r14 # Saving i at $r14

    # second input - j
    subq    $16, %rsp
    movq    %rsp,%rsi
    movq    $inputstrint, %rdi
    movq    $0,%rax
    call    scanf
    movzbq  (%rsp),%r15  # Saving j at $r15

    # moving pstrings,i and j to parameters and calling the function
    movq    %r12,%rdi
    movq    %r13,%rsi
    movq    %r14, %rdx
    movq    %r15, %rcx
    call    pstrijcmp

    # printing the result
    movq    %rax,%rsi
    movq    $strcmp,%rdi  
    movq    $0,%rax
    call    printf
    jmp     .L11

# invalid option #
.L12:
    movq    $invalid,%rdi  
    movq	$0,%rax
    call    printf

# Function termination and return #
.L11:
    movq	$0,%rax	
	movq	%rbp,%rsp	
	popq	%rbp		
    ret
