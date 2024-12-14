[bits 16]

print_char:
    mov ah, 0x0E
    int 0x10
    ret

printf:
.loop:
    lodsb ; Load a single byte from SI into AL
    cmp al, 0 ; Check if end of string
    je .done
    call print_char ; Print the character
    jmp .loop
.done:
    ret