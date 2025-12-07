.globl  n_fact
.globl  solve

# Implementation of n_fact(int i, int r)
n_fact:
    # Function prologue - setup stack frame
    pushq   %rbp            # Save the old base pointer (%rbp) to the stack
    movq    %rsp, %rbp      # Set the current stack pointer (%rsp) as the new base pointer

    # Parameters:
    # %edi = i    # i is passed in %edi (first integer argument)
    # %esi = r    # r is passed in %esi (second integer argument)

    # Special case: if i == 0, return 1
    cmpl    $0, %edi        # Compare i (%edi) with 0
    jne     .check_base     # If i != 0, jump to check the regular base case
    movl    $1, %eax        # If i == 0, set return value to 1 (0! = 1)
    jmp     .return         # Jump to return point

    .check_base:
    # Base case: if i == r, return 1
    cmpl    %esi, %edi      # Compare i (%edi) with r (%esi)
    jne     .recurse        # If i != r, jump to the recursive case

    movl    $1, %eax        # If i == r, set return value to 1 (base case)
    jmp     .return         # Jump to return point

    .recurse:                  # Recursive case: return i * n_fact(i-1, r)
    pushq   %rdi            # Save the value of i (%edi) on the stack
    subl    $1, %edi        # Decrement i by 1 (i-1) for the recursive call
    call    n_fact          # Call n_fact(i-1, r)
    popq    %rdi            # Restore the original value of i from the stack
    imull   %edi, %eax      # Multiply i (%edi) with the result of the recursive call

    .return:
    # Function epilogue - clean up and restore the stack
    movq    %rbp, %rsp      # Restore the stack pointer to the base pointer (%rbp)
    popq    %rbp            # Pop the saved base pointer from the stack
    ret

# Implementation of solve(int n, int r)
solve:
    # Function prologue - set up stack frame
    pushq   %rbp           # Save old base pointer (%rbp) on stack
    movq    %rsp, %rbp     # Set current stack pointer (%rsp) as new base pointer

    # Parameters:
    # %edi = n    # n is passed in %edi (first integer argument)
    # %esi = r    # r is passed in %esi (second integer argument)

    # Save parameters on the stack for later use
    pushq   %rdi           # Save n (%rdi) on the stack for later
    pushq   %rsi           # Save r (%rsi) on the stack for later
    
    # Calculate n - r for the second parameter (n-r)
    movl    %edi, %eax     # Move n (%edi) to %eax
    subl    %esi, %eax     # Subtract r (%esi) from n (%eax), result is n-r
    movl    %eax, %esi     # Move n-r into %esi (second argument for n_fact)

    # Calculate numerator: n_fact(n, n-r)
    call    n_fact         # Call n_fact with (n, n-r) in registers (%edi, %esi)
    movl    %eax, %ebx     # Save result of n_fact(n, n-r) in %ebx (numerator)

    # Calculate denominator: n_fact(r, 1)
    popq    %rdi           # Restore original r (%rdi) from stack for second call
    movl    $1, %esi       # Set second parameter to 1, i.e., n_fact(r, 1)
    call    n_fact         # Call n_fact with (r, 1) in registers (%edi, %esi)
    
    # Perform division: result = n_fact(n, n-r) / n_fact(r, 1)
    movl    %ebx, %edx     # Move numerator (n_fact(n, n-r)) from %ebx to %edx
    movl    %eax, %ecx     # Move denominator (n_fact(r, 1)) from %eax to %ecx
    movl    %edx, %eax     # Move numerator to %eax (prepare for division)
    cltd                   # Sign extend %eax into %edx (for 64-bit division)
    idivl   %ecx           # Perform signed division (%eax = %eax / %ecx, remainder in %edx)
        
    # Clean up stack and return
    popq    %rdi           # Restore original r (%rdi) from stack
    movq    %rbp, %rsp     # Restore stack pointer to the base pointer (%rbp)
    popq    %rbp           # Restore old base pointer from stack
    ret                     # Return, result is in %eax (quotient of division)
