.globl prefix_sum
.globl solve

prefix_sum:
    # Parameters:
    # %edi = n : 32 bit so uses %edi
    # %rsi = arr[]
    # %rdx = psum[]

    movl    $0, (%rdx)      # psum[0] = 0
    
    # for loop setup
    movl    $0, %ecx        # i = 0
    movq    %rdx, %r8       # preserve original psum array pointer
    
1:  # loop start
    cmpl    %edi, %ecx      # compare i with n
    jge     2f              # if i >= n, exit loop
    
    # %r8 is the pointer to psum[i]
    # it will get updated along with i before next iteration

    # psum[i+1] = psum[i] + arr[i]
    movl    (%r8), %eax      # load psum[i]
    movl    (%rsi,%rcx,4), %r9d  # load arr[i]
    addl    %r9d, %eax       # add them
    movl    %eax, 4(%r8)     # store in psum[i+1]
    
    incl    %ecx             # i++
    addq    $4, %r8          # updating psum[i] as well based on i increment
    jmp     1b               # continue loop unconditionally
    
2:  # loop end
    movq    %rdx, %rax       # return psum array
    ret

solve:
    # Parameters:
    # %rdi = arr[]  (array)
    # %esi = n      (length of the array)
    # %rdx = psar[] (array for comparison)
    
    # Initialize answer
    movl    $0, %r10d       # ans = 0
    
    # Outer loop setup
    movl    $0, %ecx        # i = 0
    
1:  # outer loop start
    movl    %esi, %r11d     # Load n
    cmpl    %r11d, %ecx     # compare i with n
    jg      5f              # if i > n, exit outer loop
    
    # Inner loop setup
    movl    %ecx, %r8d      # j = i + 1
    incl    %r8d
    
2:  # inner loop start
    movl    %esi, %r11d     # Load n
    cmpl    %r11d, %r8d     # compare j with n
    jg      4f              # if j > n, exit inner loop
    
    # Compare psar[i] with psar[j]
    movl    (%rdx,%rcx,4), %eax   # load psar[i]
    movl    (%rdx,%r8,4), %r9d    # load psar[j]
    cmpl    %r9d, %eax            # compare values
    jne     3f                     # if not equal, skip increment
    
    incl    %r10d                 # ans++
    
3:  # Skip increment point
    
    incl    %r8d                  # j++    
    jmp     2b                    # continue inner loop
    
4:  # inner loop continue
    incl    %ecx                  # i++    
    jmp     1b                    # continue outer loop
    
5:  # outer loop continue
    # Return answer
    movl    %r10d, %eax
    ret
