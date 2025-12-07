.section .text
.global find_min_max_diff

find_min_max_diff:
    # Function prologue
    pushq   %rbp
    movq    %rsp, %rbp
    
    # Check if array is empty
    cmpl    $0, %esi
    jle     empty_array
    
    # Initialize max and min with the first element
    movl    (%rdi), %eax     # max = arr[0]
    movl    %eax, %edx       # min = arr[0]
    
    # If array has only one element, max - min = 0
    cmpl    $1, %esi
    je      calculate_diff
    
    # Set up counter for loop
    movl    $1, %ecx         # i = 1
    
loop_start:
    # Check if we've processed all elements
    cmpl    %ecx, %esi
    jle     calculate_diff
    
    # Load the current element arr[i]
    movl    (%rdi,%rcx,4), %r8d  # r8d = arr[i]
    
    # Compare with current max
    cmpl    %eax, %r8d
    jle     check_min        # If arr[i] <= max, skip
    movl    %r8d, %eax       # Otherwise, update max = arr[i]
    
check_min:
    # Compare with current min
    cmpl    %edx, %r8d
    jge     continue_loop    # If arr[i] >= min, skip
    movl    %r8d, %edx       # Otherwise, update min = arr[i]
    
continue_loop:
    # Increment counter and continue
    incl    %ecx
    jmp     loop_start
    
calculate_diff:
    # Calculate max - min
    subl    %edx, %eax
    jmp     end
    
empty_array:
    # If array is empty, return 0
    movl    $0, %eax
    
end:
    # Function epilogue
    movq    %rbp, %rsp
    popq    %rbp
    ret
    