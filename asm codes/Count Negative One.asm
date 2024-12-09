org 100h                ; Set the origin to 100h (for .COM files)

mov bx, -1              ; Set BX to -1 (the value to search for)
mov cx, 6               ; Set CX to 6 (the number of elements to check)
mov si, 0               ; Initialize SI to 0 (index for the array)

jmp loop                ; Jump to the loop label

loop:                   ; Loop label
    mov ax, [sayi + si] ; Move the current array element into AX
    inc si              ; Increment the index (SI)
    cmp ax, bx          ; Compare the current element with -1
    je increment        ; If equal, jump to increment label
    dec cx              ; Decrement the count of elements left to check
    jcxz finish         ; If CX is zero, jump to finish
    jmp loop            ; Jump back to the start of the loop

increment:             ; Increment label
    inc find           ; Increase the count of found values
    dec cx             ; Decrement the count of elements left to check
    jcxz finish        ; If CX is zero, jump to finish
    jmp loop           ; Jump back to the start of the loop

finish:             ; Finish label
    ret             ; Return from the procedure

sayi dw -2, -1, -3, -1, 9, -1 ; Array of numbers (sayi)
find dw 0                     ; Counter for the number of occurrences of -1
