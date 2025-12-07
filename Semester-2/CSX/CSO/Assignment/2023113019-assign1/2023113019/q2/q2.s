.section .text
.global rotate_right_2

rotate_right_2:
    # Prologue
    pushq %rbp
    movq %rsp, %rbp

    # Load arguments
    movq %rdi, %r8   # arr pointer (address of the array)
    movl %esi, %ecx  # n (size of the array)
    cmpl $2, %ecx
    jle .end_rotate  # If n ≤ 2, no need to rotate

    # Store last two elements
    movl -8(%r8, %rcx, 4), %eax  # Second last element
    movl -4(%r8, %rcx, 4), %edx  # Last element

    # Shift elements right by 2 (starting from end)
    movq %rcx, %rsi              # rsi = n
    subq $3, %rsi                # rsi = n - 3 (zero-based index)

.shift_loop:
    cmpq $0, %rsi
    jl .store_last_two           # If rsi < 0, stop shifting
    movl (%r8, %rsi, 4), %ebx    # Load arr[i]
    movl %ebx, 8(%r8, %rsi, 4)   # Store arr[i] at arr[i+2]
    decq %rsi
    jmp .shift_loop

.store_last_two:
    movl %eax, (%r8)             # Place second last element at arr[0]
    movl %edx, 4(%r8)            # Place last element at arr[1]

.end_rotate:
    # Epilogue
    popq %rbp
    ret
