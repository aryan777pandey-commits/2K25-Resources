.global solve
.text

# rdi = n (meaning array size is 3n+1)
# rsi = pointer to array

solve:
    mov $0, %r8          # ones = 0
    mov $0, %r9          # twos = 0
    lea 1(%rdi, %rdi, 2), %rcx  # rcx = 3*n+1
    mov $0, %rdx         # loop counter

.loop:
    mov (%rsi, %rdx, 8), %rax  # Get current array element
    
    # Update twos: twos = twos | (ones & current)
    mov %r8, %r10
    and %rax, %r10
    or %r10, %r9
    
    # Update ones: ones = ones ^ current
    xor %rax, %r8
     
    # Get common bits between ones and twos
    mov %r8, %r10
    and %r9, %r10
    
    # Remove common bits from ones and twos
    not %r10
    and %r10, %r8
    and %r10, %r9
    
    inc %rdx
    cmp %rdx, %rcx
    jne .loop
    
    mov %r8, %rax        # Return the number that appears once
    ret
    