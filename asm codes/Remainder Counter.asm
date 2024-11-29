
; Program Description:
; This assembly program processes an array of numbers (`numbers`) to count
; how many of them satisfy a specific condition (remainder of division by `divisor` equals `bl`).
; The result is stored in the `total` variable.

org 100h

process:
    mov ax, [numbers + si] ; Load the current number from the array into AX
    mov dl, divisor        ; Load the divisor value into DL
    idiv dl                ; Divide AX by DL, storing quotient in AL and remainder in AH
    cmp ah, bl             ; Compare the remainder (AH) with the value in BL
    je increment           ; If they are equal, jump to the increment section
    inc si                 ; Increment index to point to the next number
    inc si                 ; (Each number is 2 bytes since it's a word)
    dec cx                 ; Decrement the counter (CX)
    jcxz finish            ; If the counter is zero, end the loop
    jmp process            ; Otherwise, repeat the loop

increment:
    inc total              ; Increment the total count
    inc si                 ; Move to the next number in the array
    inc si
    dec cx                 ; Decrement the counter
    jcxz finish            ; If the counter reaches zero, end the loop
    jmp process            ; Otherwise, continue processing

finish:
    ret                    ; Return from the program

numbers dw -1, 1, 3, -17, 4, -4, 6  ; Array of numbers to process
number db 0                         ; Temporary variable (unused in current logic)
divisor db 4                        ; Divisor value
total db 0                          ; Total count of matching numbers





