.globl findMajorityElement
    .text

findMajorityElement:
    # Initialize registers - use full 64-bit registers
    xorq %rax, %rax      # candidate = 0 (64-bit)
    xorl %ecx, %ecx      # count = 0 (32-bit is fine for count)
    xorl %r8d, %r8d      # i = 0 (32-bit index)
    
    # Step 1: Find a candidate for majority element
majority_loop:
    cmpl %r8d, %esi      # compare i with n
    jle verify_phase     # if i >= n, exit loop and verify
    
    # If count is 0, pick current element as candidate
    cmpl $0, %ecx
    jne check_element
    
    movq (%rdi,%r8,8), %rax  # candidate = nums[i] (note: 8 bytes offset)
    movl $1, %ecx            # count = 1
    jmp next_iteration
    
check_element:
    # If current element equals candidate, increment count
    # Otherwise decrement count
    movq (%rdi,%r8,8), %r9   # r9 = nums[i] (64-bit)
    cmpq %rax, %r9           # compare nums[i] with candidate
    jne decrement_count
    
    incl %ecx                # count++
    jmp next_iteration
    
decrement_count:
    decl %ecx                # count--
    
next_iteration:
    incl %r8d                # i++
    jmp majority_loop
    
    # Step 2: Verify the candidate
verify_phase:
    xorl %ecx, %ecx          # count = 0
    xorl %r8d, %r8d          # i = 0
    
verify_loop:
    cmpl %r8d, %esi          # compare i with n
    jle end                  # if i >= n, exit
    
    movq (%rdi,%r8,8), %r9   # r9 = nums[i] (64-bit)
    cmpq %rax, %r9           # compare nums[i] with candidate
    jne skip_count
    
    incl %ecx                # count++
    
skip_count:
    incl %r8d                # i++
    jmp verify_loop
    
end:
    # %rax already contains the majority element
    ret
    