;
; A simple boot sector program that demonstrates printing hex values
;
[org 0x7c00]		; Origin

mov ax, 0x03
int 0x10		; Clear screen

mov ax, 0x1234		; Use ax to store the address of our message
mov bl, 0x02		; Use bl to store the color attribute for green
mov dh, 0x00
mov dl, 0x00
call PrintHex

mov ax, 0xABCD
mov bl, 0x04		; 0x04 = red
mov dh, 0x01		; Row = 1
mov dl, 0x00		; Column = 0
call PrintHex

jmp $			; Jump to the current address (infinite loop)

%include "includes/string.asm"
%include "includes/io.asm"

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55