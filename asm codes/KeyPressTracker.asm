; Purpose: Tracks user key presses and displays a block at different positions based on repeated or new key presses.

org 100h

; Set initial cursor position
mov ah, 02h                ; Function to set cursor position
mov dh, 10h                ; Row position (starting point)
mov dl, 5h                 ; Column position
mov bh, 0                  ; Page number
int 10h

; Get initial key press
mov ah, 00h                ; Wait for key press
int 16h
mov temp, al               ; Store the initial key in 'temp'

; Display the initial block
mov ah, 09h                ; Write character with attribute
mov bh, 0                  ; Page number
mov cx, 3                  ; Number of characters to display
mov bl, 00110000b          ; Character with specific attribute
int 10h

; Get current cursor position
mov ah, 03h                ; Function to get cursor position
int 10h

mov cx, 4                  ; Loop counter (number of key presses to track)

loopStart:
    jcxz endProgram        ; If counter reaches zero, exit the program
    push cx                ; Save loop counter on stack

    ; Wait for a new key press
    mov ah, 00h            ; Wait for key press
    int 16h

    ; Check if the new key matches the previous key
    cmp temp, al
    je sameKeyPressed       ; If keys match, jump to 'sameKeyPressed'

    ; Update 'temp' with the new key
    mov temp, al

    ; Update cursor position and display block for new key
    mov ah, 03h            ; Get current cursor position
    int 10h

    mov ah, 02h            ; Set new cursor position
    mov dl, 5h             ; Column position remains the same
    inc dh                 ; Move one row down
    int 10h

    ; Display the block
    mov ah, 09h            ; Write character with attribute
    mov bh, 0              ; Page number
    mov cx, 3              ; Number of characters to display
    mov bl, 00110000b      ; Character with specific attribute
    int 10h

    jmp continueLoop

sameKeyPressed:
    ; Update cursor position and display block for repeated key
    mov ah, 03h            ; Get current cursor position
    int 10h

    mov ah, 02h            ; Set new cursor position
    inc dl                 ; Move three columns to the right
    inc dl
    inc dl
    int 10h

    mov ah, 09h            ; Write character with attribute
    mov bh, 0              ; Page number
    mov cx, 3              ; Number of characters to display
    mov bl, 00110000b      ; Character with specific attribute
    int 10h

continueLoop:
    pop cx                 ; Restore loop counter
    loop loopStart         ; Decrement counter and repeat

endProgram:
    ret                    ; Return to DOS

temp db 0                  ; Variable to store the last key pressed
