.globl findPeak
    .text

findPeak:
    # Initialization
    xorl %eax, %eax      # Initialize return value
    xorl %ecx, %ecx      # left = 0
    movl %esi, %edx      # right = n
    subl $1, %edx        # right = n - 1
    
binary_search_loop:
    cmpl %edx, %ecx      # Compare left with right
    jg end_search        # If left > right, end search
    
    # Calculate mid = (left + right) / 2
    movl %ecx, %r8d      # r8d = left
    addl %edx, %r8d      # r8d = left + right
    shrl $1, %r8d        # r8d = (left + right) / 2
    
    # Get value at mid
    movslq %r8d, %r9     # Convert mid to 64-bit for indexing
    movswl (%rdi,%r9,2), %r10d     # r10d = nums[mid]
    
    # Check if mid is a peak
    
    # First check left neighbor if mid > 0
    cmpl $0, %r8d
    je check_right       # If mid is 0, only check right
    
    # Get left neighbor
    leal -1(%r8d), %r11d
    movslq %r11d, %r11
    movswl (%rdi,%r11,2), %r11d    # r11d = nums[mid-1]
    
    # If left neighbor > mid value, search left half
    cmpl %r10d, %r11d
    jg search_left_half
    
check_right:
    # Check right neighbor if mid < n-1
    movl %esi, %r12d
    subl $1, %r12d       # r12d = n-1
    cmpl %r12d, %r8d
    je check_peak        # If mid is n-1, we've checked all needed neighbors
    
    # Get right neighbor
    leal 1(%r8d), %r12d
    movslq %r12d, %r12
    movswl (%rdi,%r12,2), %r12d    # r12d = nums[mid+1]
    
    # If right neighbor > mid value, search right half
    cmpl %r10d, %r12d
    jg search_right_half
    
check_peak:
    # If we get here, mid is a peak (no neighbors are larger)
    movl %r10d, %eax     # Set return value to peak value
    jmp end_search
    
search_left_half:
    # Search left half
    leal -1(%r8d), %edx  # right = mid - 1
    jmp binary_search_loop
    
search_right_half:
    # Search right half
    leal 1(%r8d), %ecx   # left = mid + 1
    jmp binary_search_loop
    
end_search:
    # Return the peak value in %eax
    ret
    