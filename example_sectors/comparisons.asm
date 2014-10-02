;
; A simple boot sector program that demonstrates the print string interrupt
;
[org 0x7c00]		; Origin

mov ah, 0x0e		; int 10/ah = 0eh -> scrolling teletype BIOS routine

mov bx, 30

cmp bx, 4
jle lbl_a
cmp bx, 40
jl lbl_b
mov al, 'C'
jmp continue

lbl_a:
mov al, 'A'
jmp continue

lbl_b:
mov al, 'B'

continue:
int 0x10		; Print al

jmp $			; Jump to the current address (infinite loop)

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55