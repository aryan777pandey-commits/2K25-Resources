    .text
    .globl  is_palindrome

is_palindrome:
    # Function prologue
    pushq   %rbp
    movq    %rsp, %rbp
    
    # Initialize pointers
    movq    %rdi, %rcx        # %rcx = start of string
    leaq    -1(%rdi,%rsi), %rdx  # %rdx = end of string (last character)
    
    # If string length is 0 or 1, it's automatically a palindrome
    cmpl    $1, %esi
    jle     is_palindrome_true
    
check_loop:
    # Compare characters at both ends
    movb    (%rcx), %al      # Get character from beginning
    movb    (%rdx), %bl      # Get character from end
    
    # If characters don't match, not a palindrome
    cmpb    %bl, %al
    jne     is_palindrome_false
    
    # Move pointers
    incq    %rcx             # Move start pointer forward
    decq    %rdx             # Move end pointer backward
    
    # Check if we've finished comparing (pointers crossed)
    cmpq    %rdx, %rcx
    jge     is_palindrome_true  # If pointers have crossed, it's a palindrome
    
    # Otherwise, continue checking
    jmp     check_loop
    
is_palindrome_true:
    # Return 1 (true)
    movq    $1, %rax
    jmp     end
    
is_palindrome_false:
    # Return 0 (false)
    movq    $0, %rax
    
end:
    # Function epilogue
    movq    %rbp, %rsp
    popq    %rbp
    ret
    