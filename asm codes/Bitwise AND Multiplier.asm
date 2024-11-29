; Program Description:
; This assembly program multiplies pairs of values from two arrays (`array1` and `array2`).
; For each value, it applies a bitwise AND operation with the mask `10101010b` before multiplication.
; The results are stored in the `result` array.

org 100h

mov ax, 0000h             ; Clear AX register
mov bx, 0000h             ; Clear BX register

mov di, 6                 ; Initialize index for the result array
mov si, 0                 ; Initialize index for the source arrays
mov cx, 4                 ; Set counter for the number of elements to process

loop_start:               ; Main loop
    mov al, [array1 + si] ; Load the current value from array1 into AL
    and al, 10101010b     ; Apply bitwise AND with the mask
    mov bl, [array2 + si] ; Load the current value from array2 into BL
    and bl, 10101010b     ; Apply bitwise AND with the mask

    mul bl                 ; Multiply AL (from array1) by BL (from array2)
    mov [result + di], ax  ; Store the result in the result array

    inc si                 ; Increment the index for the source arrays
    dec di                 ; Decrement the index for the result array
    dec di                 ; (Two bytes are stored for each result)

    loop loop_start        ; Repeat until all elements are processed

ret                        ; Return from the program

array1 db 0A5h, 00Ah, 07h, 09h  ; First array of byte values
array2 db 06h, 0Bh, 04h, 08h    ; Second array of byte values
result dw 4 dup(?)              ; Result array to store multiplication results
