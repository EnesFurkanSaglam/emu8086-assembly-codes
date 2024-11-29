; Program Description:
; This assembly program processes an array of numbers (`numbers`) to perform specific checks:
; 1. It compares each number with a threshold (`value`) and skips further checks for numbers smaller than the threshold.
; 2. For numbers greater than or equal to the threshold, it calculates the remainder when divided by `divisor`.
; 3. If the remainder matches a specific value (`bl`), a counter (`count`) is incremented.
; The process continues until all numbers are checked or the counter runs out.

org 100h

mov cx, 6            ; Initialize counter with the number of elements in the array
mov si, 0            ; Initialize index for the array
mov bl, 0            ; Initialize threshold value for comparison
mov dl, 0            ; Initialize temporary variable (unused in current logic)

jmp loop_start       ; Jump to the main loop

loop_start:
    mov ax, [numbers + si] ; Load the current number from the array into AX
    inc si                 ; Increment index to point to the next number
    inc si
    mov bl, value          ; Load the threshold value into BL
    cmp al, bl             ; Compare the number (lower byte of AX) with the threshold
    jl skip_check          ; If the number is less than the threshold, skip further checks
    dec cx                 ; Decrement the counter
    jcxz finish            ; If the counter reaches zero, finish the program
    jmp loop_start         ; Otherwise, continue to the next number

skip_check:
    mov dl, divisor        ; Load the divisor into DL
    idiv dl                ; Divide AX by DL, storing quotient in AL and remainder in AH
    cmp ah, bl             ; Compare the remainder with the threshold value
    je increment_count     ; If they match, jump to increment the count
    dec cx                 ; Decrement the counter
    jcxz finish            ; If the counter reaches zero, finish the program
    jmp loop_start         ; Otherwise, continue to the next number

increment_count:
    inc count              ; Increment the count for matching numbers
    dec cx                 ; Decrement the counter
    jcxz finish            ; If the counter reaches zero, finish the program
    jmp loop_start         ; Otherwise, continue processing

finish:
    ret                    ; Return from the program

numbers dw -1, -4, -16, -128, 4, 5 ; Array of numbers to process
value db 0                         ; Threshold value for comparison
divisor db 4                       ; Divisor for calculating remainder
count db 0                         ; Counter for numbers meeting the condition
