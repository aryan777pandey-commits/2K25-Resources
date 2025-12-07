.global solve
.text

# rdi is n
# rsi is arr, rdx is arr2

solve:
# using arr2 as prefix products
# init pref[0] = arr[0]
# i = 1
    mov (%rsi), %rbx
    mov %rbx, (%rdx)
    mov $1, %rbx
    jmp .calcprefix

    .calcprefix:
        mov %rbx, %rcx
        dec %rcx
#j = i-1
#temp = pref[j]
#temp *= arr[i]
#pref[i] = temp
#i++, compare and loop/exit
        mov (%rdx, %rcx, 8), %r9
        imul (%rsi, %rbx, 8), %r9
        mov %r9, (%rdx, %rbx, 8)
        inc %rbx
        cmp %rdi, %rbx
        jne .calcprefix
        mov %rdi, %rbx
        mov $1, %rcx
        jmp .calcans
#rcx is suffix product till now
#i = n
    .calcans:
#temp = 1, temp*= rcx, rcx*=arr[i-1],
#when i = 1 break (cant go to pref[1-2])
        mov $1, %r9
        imul %rcx, %r9
        imul -8(%rsi, %rbx, 8), %rcx
        mov $1, %r10
        cmp %rbx, %r10
        je .retans
#temp *= pref[i-2]
#ans[i]= temp
#i--
        mov %rbx, %r10
        sub $2, %r10
        imul (%rdx, %r10, 8), %r9
        inc %r10
        mov %r9, (%rdx, %r10, 8)
        dec %rbx
        jmp .calcans

    .retans:
#ans[0] = suf product till now, same arr used for ans and suf
        mov %rcx, (%rdx)
        mov %rdx, %rax
 