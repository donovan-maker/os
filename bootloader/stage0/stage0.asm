[org 0x7C00]
[bits 16]

mov [BOOT_DISK], dl

mov bp, 0x7C00
mov sp, bp

mov bl, 0x55

; Print welcome_msg
mov si, welcome_msg
call printf

mov al, 0x0A
call print_char
mov al, 0x0D
call print_char

; Print copyright_msg
mov si, copyright_msg
call printf

mov ah, 0x02
mov al, 16 ; Read 16 sectors
mov ch, 0 ; Cylinder 0
mov cl, 0x02 ; Read from sector 2
mov dh, 0 ; Head 0
mov dl, [BOOT_DISK] ; Drive
mov bx, 0x8000

int 0x13
jc boot_fail ; Check if it was successful

mov al, 0x0A
call print_char
mov al, 0x0D
call print_char
mov si, fail_msg

jmp 0x8000

boot_fail:
    mov al, 0x0A
    call print_char
    mov al, 0x0D
    call print_char
    mov si, fail_msg
    call printf
    jmp $

%include "bootloader/stage0/include/print.asm"

welcome_msg: db "Welcome to the Atlas EFI Bootloader.", 0
copyright_msg: db "Atlas EFI Bootloader (c) donovan-maker Donovan Black 2024 (MIT License).", 0
fail_msg: db "Failed to boot.", 0

BOOT_DISK: db 0

times 510 - ($ - $$) db 0
dw 0xAA55 ; Boot sector signature