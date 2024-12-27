; Purpose: Reverses a string, compares the reversed string with the original, 
;          and counts the number of matching characters.

data segment
    originalStr db 'acabada'   ; Original string
    matchCount db 0            ; Count of matching characters after comparison
data ends

extra segment
    reversedStr db 7 dup(?)    ; Reversed string will be stored here
extra ends

stack segment
    dw 128 dup(0)              ; Stack definition
stack ends

code segment
start:

    ; Set up segments
    mov ax, data
    mov ds, ax
    mov ax, extra
    mov es, ax
    cld                        ; Clear direction flag for forward processing

    mov matchCount, 0          ; Initialize match counter
    mov cx, 7                  ; Number of iterations (length of the string)

    ; Reverse the original string and store in reversedStr
    lea si, [originalStr]      ; Address of the original string
    lea di, [reversedStr+6]    ; Pointer to the end of reversedStr

reverseLoop:
    movsb                      ; Move one character
    dec di                     ; Adjust destination pointer for reverse order
    dec di                     ; Repeat to handle reverse positioning
    loop reverseLoop            ; Continue loop until all characters are reversed

    ; Compare the original and reversed strings
    mov cx, 7                  ; Reset the number of iterations
    lea si, [originalStr]      ; Pointer to the original string
    lea di, [reversedStr]      ; Pointer to the reversed string

compareLoop:
    cmpsb                      ; Compare characters
    je incrementMatch          ; If equal, increment matchCount
    jcxz endProgram            ; If loop ends, jump to program end
    loop compareLoop           ; Continue comparison loop

incrementMatch:
    inc matchCount             ; Increment match counter
    jcxz endProgram            ; If loop ends, jump to program end
    dec cx                     ; Decrement remaining character count
    cmp matchCount, 7          ; Check if all characters match
    je allMatch                ; If all match, proceed to allMatch
    jmp compareLoop            ; Otherwise, continue comparison

allMatch:
    inc matchCount             ; Increment matchCount again
    jmp endProgram             ; Jump to program end

endProgram:            
    mov ax, 4c00h 
    int 21h                    ; End program
code ends
end start
