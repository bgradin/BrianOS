;
; A simple boot sector program that demonstrates the print string interrupt
;
[org 0x7c00]		; Origin

mov ax, 3
int 0x10		; clear screen by setting mode 3

mov ecx, 0x00
not ecx			; ecx = -1 or 4,294,967,295

mov al, 0x00
cld			; Clear the direction flag
lea di, [message]
repne scasb		; Find value in al (ecx = -strlen - 2)

not ecx			; ecx = strlen + 1
dec ecx

mov ah, 0x13		; int 10/ah = 13h -> display string
mov al, 0x01		; Write mode
mov bl, 0x02		; Attribute (color: 2 = green)
mov bh, 0x00		; Display page number
mov dx, 0x00		; Row = 0, column = 0

mov bp, message		; Pointer to string
int 0x10		; Hello, world!

jmp $			; Jump to the current address (infinite loop)

message: db 'Hello, world!',0

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55