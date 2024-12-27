; Purpose: Extracts vowels (a, e, i, o, u) from a given sentence and stores them in a new array.

data segment
    sentence DB 'youcandothis$'  ; The input sentence ending with '$'
    vowels DB 'aeiou'            ; Vowel characters to check against
data ends

extra segment
    newArray DB 50 DUP('$')      ; Array to store extracted vowels
extra ends

code segment

start:

    ; Initialize the data segment
    mov ax, data
    mov ds, ax

    ; Initialize the extra segment
    mov ax, extra
    mov es, ax

    ; Load addresses of variables
    lea si, sentence             ; Source: Input sentence
    lea di, newArray             ; Destination: Extracted vowels array
    lea bx, vowels               ; Address of vowels array

nextChar:
    mov al, [si]                 ; Load current character from sentence
    cmp al, '$'                  ; Check if end of sentence ('$')
    je finish                    ; If end, jump to finish
    push si                      ; Save current position in sentence
    lea si, vowels               ; Start checking vowels
    mov cx, 5                    ; Vowel array length (5 vowels)

checkVowel:
    mov dl, [si]                 ; Load current vowel
    cmp al, dl                   ; Compare character with vowel
    je addToNewArray             ; If match, jump to addToNewArray
    inc si                       ; Move to next vowel
    loop checkVowel              ; Repeat for all vowels
    pop si                       ; Restore original position in sentence
    inc si                       ; Move to next character in sentence
    jmp nextChar                 ; Repeat for next character

addToNewArray:
    pop si                       ; Restore original position in sentence
    mov es:[di], al              ; Add matched vowel to newArray
    inc di                       ; Move to next position in newArray
    inc si                       ; Move to next character in sentence
    jmp nextChar                 ; Repeat for next character

finish:
    mov ax, 4C00H                ; Exit program
    int 21H

code ends
end start
