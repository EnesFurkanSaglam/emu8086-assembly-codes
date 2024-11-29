; Program Description:
; This assembly program processes a string (`sentence`) to count occurrences of the substring "er".
; It searches for the character 'e' followed by 'r' and increments a counter (`count`) each time the substring is found.
; The process continues until all characters in the string have been checked.

org 100h

mov si, 0                ; Initialize index for the string
mov cx, 8                ; Set counter for the number of characters in the string

mov bh, 'e'              ; Load 'e' into BH for comparison
mov bl, 'r'              ; Load 'r' into BL for comparison

jmp loop_start           ; Jump to the main loop

loop_start:
    mov al, [sentence + si] ; Load the current character from the string into AL
    cmp al, bh              ; Compare the character with 'e'
    je found_e              ; If equal, jump to handle found 'e'
    jmp not_found           ; Otherwise, handle not found

found_e:
    inc si                  ; Move to the next character
    mov al, [sentence + si] ; Load the next character
    cmp al, bl              ; Compare with 'r'
    je found_er             ; If equal, jump to increment the count
    dec cx                  ; Decrement the character counter
    jcxz finish             ; If counter reaches zero, finish the program
    jmp loop_start          ; Otherwise, continue the loop

found_er:
    inc count               ; Increment the count of occurrences
    inc si                  ; Move to the next character
    dec cx                  ; Decrement the character counter
    jcxz finish             ; If counter reaches zero, finish the program
    jmp loop_start          ; Otherwise, continue the loop

not_found:
    dec cx                  ; Decrement the character counter
    inc si                  ; Move to the next character
    jcxz finish             ; If counter reaches zero, finish the program
    jmp loop_start          ; Otherwise, continue the loop

finish:
    ret                     ; Return from the program

sentence db 'erkekler'     ; The string to search for the substring "er"
count db 0                 ; Counter for occurrences of "er"
