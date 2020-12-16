.section	.rodata	#read only data section
invalid:    .string "invalid input!\n"
# The main code section #
    .text

# Pstring length #
.globl pstrlen
    .type pstrlen, @function
pstrlen:
    movzbq  (%rdi),%rax # Return first byte of pstring
    ret

# Replace old char for new char #
.globl replaceChar
    .type replaceChar, @function
replaceChar:
    movzbq  (%rdi),%r11 # Save string length at %r11
    mov     $0,%r10 # Loop counter
    .L1: # main loop body
    addq    $1, %r10 # increase counter
    movzbq  (%rdi,%r10,1),%rbx # check char at current place
    cmpq    %rbx,%rsi # compare current char with old char
    jne     .L2
    movb    %dl,(%rdi,%r10,1) # if equal then replace with new
    .L2: # loop termination check
    cmpq    %r11,%r10
    jle     .L1 # if not reached end then return to beginning 
    movq    %rdi, %rax # loop finished
    ret

# Copy str1[i:j] to str2[i:j] #
.globl pstrijcpy
    .type pstrijcpy, @function
pstrijcpy:
    # out of bounds check
    movzbq  (%rdi),%r10
    movzbq  (%rsi),%r11
    cmp     $0,%rdx # check i < 0
    jl      .L6
    cmp     %r10,%rcx # check j >= len
    jge     .L6
    cmp     %r11,%rcx
    jge     .L6
    cmp     %rdx,%rcx # check i > j
    jl      .L6

    movq    %rdx,%r10 # i counter
    movq    %rcx,%r11 # j counter
    # loop
    .L3: # loop termination check (check if i reached j)
    cmp     %r11,%r10
    jle     .L5 # if not then move to main body
    .L4: # termination and return
    movq    %rdi, %rax
    ret
    .L5: # main loop body
    addq    $1,%r10 # increase i by 1
    movb    (%rsi,%r10,1), %bl
    movb    %bl,(%rdi,%r10,1) # move str1[i] to str2[i]
    jmp     .L3 # return to loop termination check
    .L6: # invalid message and termination (from bound check)
    movq    %rdi, %rbx
    movq    $invalid,%rdi  
    movq    $0,%rax
    call    printf
    movq    %rbx, %rdi
    movq    %rbx, %rax
    ret

# Swap letter case #
.globl swapCase
    .type swapCase, @function
swapCase:
    movzbq  (%rdi),%r11 # save length
    mov     $0,%r10 # loop counter
    # loop
    .L7: # loop termination check (check if i reached length)
    cmp     %r11,%r10
    jle     .L9
    .L8: # termination and return
    ret
    .L9: # main loop body
    addq    $1,%r10 # increase counter
    movb    (%rdi,%r10,1), %bl # save current char
    cmp     $97, %bl # lower case lower bound check
    jge     .L10
    cmp     $65, %bl # heigher case lower bound check
    jge     .L11
    jmp     .L7
    .L10: # lower case heigher bound check
    cmp     $122, %bl 
    jle     .L12
    jmp     .L7
    .L11: # heigher case heigher bound check
    cmp     $90, %bl
    jle     .L13
    jmp     .L7
    .L12: # lower case to heigher swap
    subb    $32,%bl
    movb    %bl,(%rdi,%r10,1)
    jmp     .L7
    .L13: # heigher case to lower swap
    addb    $32,%bl
    movb    %bl,(%rdi,%r10,1)
    jmp     .L7

# Compare str1[i:j] and str2[i:j] #
.globl pstrijcmp
    .type pstrijcmp, @function
pstrijcmp:
    # out of bounds check
    movzbq  (%rdi),%r10
    movzbq  (%rsi),%r11
    cmp     $0,%rdx # check i < 0
    jl      .L17
    cmp     %r10,%rcx # check j >= len
    jge     .L17
    cmp     %r11,%rcx
    jge     .L17
    cmp     %rdx,%rcx # check i > j
    jl      .L17

    movq    %rdx,%r10 # i counter
    movq    %rcx,%r11 # j counter
    # loop
    .L14: # loop termination check (check if i reached j)
    cmp     %r11,%r10
    jle     .L16
    .L15: # termination and return (if reached end, return 0 because equal)
    movq    $0, %rax 
    ret
    .L18: # termination and return (if str1 > str2)
    movq    $1, %rax
    ret
    .L19: # termination and return (if str1 < str2)
    movq    $-1, %rax
    ret
    .L16: # main loop body
    addq    $1,%r10 # increase counter
    movb    (%rsi,%r10,1), %bl # get current char
    cmp     %bl,(%rdi,%r10,1) # compare and jump accordingly
    jg      .L18
    jl      .L19
    jmp     .L14 # characters are equal, move to next characters
    .L17: # invalid message and termination (from bound check)
    movq    $invalid,%rdi  
    movq    $0,%rax
    call    printf
    movq    $-2, %rax 
    ret
