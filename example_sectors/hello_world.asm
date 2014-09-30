;
; A simple boot sector program that displays "Hello, world!"
;

mov ah, 0x0e		; int 10/ah = 0eh -> scrolling teletype BIOS routine

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ','
int 0x10
mov al, ' '
int 0x10
mov al, 'w'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

jmp $			; Jump to the current address (infinite loop)

times 510-($-$$) db 0	; When compiled, our program must fit into
			; 512 bytes with the last two bytes being the
			; magic number, so here, tell our assembler
			; to pad out out our program with enough zero
			; bytes (db 0) to bring us to the 510th byte.

dw 0xaa55		; Last two bytes (one word form the magic number
			; so BIOS knows we are a boot sector.