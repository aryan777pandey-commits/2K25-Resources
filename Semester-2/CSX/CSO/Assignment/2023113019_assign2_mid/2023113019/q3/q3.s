    .globl solve

# Implementation of void solve(int arr[], int n, int result[]);
solve:
    # Function parameters:
    # %rdi - arr (pointer to input array)
    # %rsi - n (number of elements)
    # %rdx - result (pointer to result array)
    
    # Function prologue - setup stack frame
    pushq %rbp
    movq %rsp, %rbp
    
    # Allocate space for local variables
    subq $16, %rsp                   # Space for local variables
    movq %rsi, -8(%rbp)              # Save n
    movq $0, -16(%rbp)               # Stack top index = 0
    
    # Save callee-saved registers
    pushq %r12                       # Save r12 (will use for loop index i)
    pushq %r13                       # Save r13 (will use for temp operations)
    pushq %r14                       # Save r14 (will use for stack_top)
    pushq %r15                       # Save r15 (will use for stack array base)
    
    # Allocate stack array on the stack (n * 4 bytes)
    movq %rsi, %rax                  # Copy n to rax
    shlq $2, %rax                    # n * 4 (each element is 4 bytes)
    subq %rax, %rsp                  # Allocate space on stack
    andq $-16, %rsp                  # Align stack to 16 bytes
    movq %rsp, %r15                  # %r15 = stack array base address
    
    # Initialize all result elements to -1
    movq $0, %r12                    # i = 0
init_loop:
    cmpq %rsi, %r12                  # Compare i with n
    jge init_done                    # If i >= n, exit loop
    
    movl $-1, (%rdx,%r12,4)          # result[i] = -1
    incq %r12                        # i++
    jmp init_loop                    # Continue loop
init_done:
    
    # Process array from right to left (n-1 down to 0)
    movq %rsi, %r12                  # r12 = i = n
    decq %r12                        # i = n-1
    movq $0, %r14                    # r14 = stack_top = 0
    
process_loop:
    cmpq $0, %r12                    # Compare i with 0
    jl process_done                  # If i < 0, exit loop
    
    # While stack not empty and current element > stack top element
pop_loop:
    cmpq $0, %r14                    # Check if stack_top > 0
    jle pop_done                     # If stack empty, exit pop loop
    
    movl (%rdi,%r12,4), %eax         # eax = arr[i]
    movq %r14, %r13                  # Copy stack_top to r13
    decq %r13                        # r13 = stack_top - 1
    movl (%r15,%r13,4), %ecx         # ecx = stack[stack_top-1]
    cmpl %ecx, %eax                  # Compare arr[i] with stack[stack_top-1]
    jle pop_done                     # If arr[i] <= stack[stack_top-1], exit pop loop
    
    decq %r14                        # stack_top--
    jmp pop_loop                     # Continue popping
pop_done:
    
    # If stack not empty, set the next greater element
    cmpq $0, %r14                    # Check if stack_top > 0
    jle push_current                 # If stack empty, skip to push
    
    movq %r14, %r13                  # Copy stack_top to r13
    decq %r13                        # r13 = stack_top - 1
    movl (%r15,%r13,4), %ecx         # ecx = stack[stack_top-1]
    movl %ecx, (%rdx,%r12,4)         # result[i] = stack[stack_top-1]
    
push_current:
    # Push current element to stack
    movl (%rdi,%r12,4), %eax         # eax = arr[i]
    movl %eax, (%r15,%r14,4)         # stack[stack_top] = arr[i]
    incq %r14                        # stack_top++
    
    decq %r12                        # i--
    jmp process_loop                 # Continue processing
    
process_done:
    # Restore n
    movq -8(%rbp), %rsi              # Restore n from local variable
    
    # Restore callee-saved registers
    leaq -16(%rbp), %rsp             # Reset stack pointer to before register saves
    popq %r15                        # Restore r15
    popq %r14                        # Restore r14
    popq %r13                        # Restore r13
    popq %r12                        # Restore r12
    
    # Function epilogue - clean up and restore the stack
    movq %rbp, %rsp                  # Restore the stack pointer
    popq %rbp                        # Restore the base pointer
    ret                              # Return to caller
    