; This program processes an array of integers, 
; computes their absolute values, divides each by 2, 
; and sums the results.

org 100h

mov si, 0                    ; Index for the current element in the arrays
mov cx, 6                    ; Counter for the number of elements
mov bl, 2                    ; Divisor for the division operation

jmp loop1                    ; Jump to the first loop

loop1:
    cmp cx, 0                ; Check if all elements have been processed
    je continue2             ; If cx is 0, go to continue2

    mov al, [numbers + si]   ; Load current number into AL
    cmp al, negative         ; Compare AL with the negative marker
    jl process_negative      ; If AL is negative, handle it
    mov [absolute + si], al  ; Store the absolute value
    jmp continue1            ; Continue to the next element

process_negative:
    neg al                  ; Negate AL to get the absolute value
    mov [absolute + si], al ; Store the absolute value

continue1:
    inc si                  ; Move to the next index
    dec cx                  ; Decrement the counter
    jmp loop1               ; Repeat the loop

continue2:
    mov cx, 6               ; Reset counter for the second loop
    mov si, 0               ; Reset index for the absolute array

loop2:
    cmp cx, 0               ; Check if all elements have been processed
    je continue3            ; If cx is 0, go to continue3

    mov al, [absolute + si] ; Load current absolute value into AL
    cbw                     ; Convert byte in AL to word in AX
    div bl                  ; Divide AX by BL (2)
    cmp ah, 0               ; Check remainder in AH
    je multiply_by_two      ; If remainder is 0, multiply by 2
    mul bl                  ; Multiply AL by BL (2)
    inc al                  ; Increment the result
    jmp write_result        ; Jump to write the result

multiply_by_two:
    mov al, [absolute + si] ; Load current absolute value into AL
    mul bl                  ; Multiply AL by BL (2)

write_result:
    mov [result + si], al   ; Store the result
    inc si                  ; Move to the next index
    dec cx                  ; Decrement the counter
    jmp loop2               ; Repeat the loop

continue3:
    mov cx, 6               ; Reset counter for the summation loop
    mov si, 0               ; Reset index for the result array
    mov al, 0               ; Initialize AL to 0 for summation

sum_loop:
    cmp cx, 0               ; Check if all elements have been processed
    je finish               ; If cx is 0, go to finish

    add al, [result + si]   ; Add the current result to AL
    inc si                  ; Move to the next index
    dec cx                  ; Decrement the counter
    jmp sum_loop            ; Repeat the loop

finish:
    mov [total], al         ; Store the final sum

ret

numbers db -12, 8, -6, -9, -13, -8  ; Input array of numbers
absolute db 0, 0, 0, 0, 0, 0        ; Array to store absolute values
result db 0, 0, 0, 0, 0, 0          ; Array to store results after division
negative db 0                       ; Marker for negative values
total db 0                          ; Variable to store the final sum
