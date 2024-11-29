; Program Description:
; This assembly program processes an array of numbers (`numbers`) to perform specific checks:
; 1. It compares each number with a threshold (`value`).
; 2. If the number is greater than or equal to the threshold, it calculates the remainder when divided by `divisor`.
; 3. If the remainder matches a specific value (`bx`), a counter (`count`) is incremented.
; The process continues until all numbers are checked.

org 100h

mov cx, 4              ; Initialize counter with the number of elements in the array
mov si, 0              ; Initialize index for the array

loop_start:                ; Main loop
    mov ax, [numbers + si] ; Load the current number from the array into AX
    mov bx, value          ; Load the threshold value into BX
    cmp ax, bx             ; Compare the number (AX) with the threshold
    jl skip_check          ; If the number is less than the threshold, skip further checks
    jmp process_remainder  ; Jump to process the remainder check

loop loop_start         ; Continue looping

skip_check:             ; If the number is less than the threshold
    inc si              ; Increment index to point to the next number
    inc si
    dec cx              ; Decrement the counter
    jcxz finish         ; If the counter reaches zero, finish the program
    jmp loop_start      ; Otherwise, continue to the next number

process_remainder:      ; Process remainder calculation
    mov bx, divisor     ; Load the divisor into BX
    idiv bx             ; Divide AX by BX, storing quotient in AL and remainder in AH

    cmp ah, bx          ; Compare the remainder with the divisor
    inc si              ; Increment index for the next number
    inc si
    dec cx              ; Decrement the counter
    jcxz finish         ; If the counter reaches zero, finish the program
    je increment_count  ; If they match, increment the count
    jmp loop_start      ; Otherwise, continue to the next number

increment_count:       ; Increment the count for matching numbers
    inc count          ; Increment the count
    jmp loop_start     ; Jump back to the main loop

finish:                ; End of processing
    ret                ; Return from the program

numbers dw -1, -16, 16, -5 ; Array of numbers to process
value dw 0                 ; Threshold value for comparison
divisor dw 4               ; Divisor for calculating remainder
count db 0                 ; Counter for numbers meeting the condition
