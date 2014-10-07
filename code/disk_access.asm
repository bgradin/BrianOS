;
; A simple boot sector program that demonstrates reading from drive sectors
;
[org 0x7c00]

mov ax, 0x0

mov [BOOT_DRIVE], dl		; BIOS stores our boot drive in dl, so it's
				; best to remember this for later.

mov bp, 0x8000			; Set our stack safely out of the way, at 0x8000
mov sp, bp

mov al, 5			; Read 5 sectors
mov bx, 0x9000			; To 0x0000:0x9000
mov dl, [BOOT_DRIVE]		; Read from boot drive
mov ch, 0x00			; Read from cylinder 0
mov dh, 0x00			; Read from head 0
mov cl, 0x02			; Read from sector 2 (after the boot sector)
call DiskLoad

mov ax, [0x9000]		; Print out the first loaded word, which
mov bl, 0x02			; we expect to be 0xdada, stored at address
mov dh, 0x00			; 0x9000
mov dl, 0x00
call PrintHex

mov ax, [0x9000+512]		; Also, print the first word from the 2nd
mov bl, 0x04			; loaded sector: should be 0xface
mov dh, 0x01
mov dl, 0x00
call PrintHex

jmp $

%include "includes/string.asm"
%include "includes/io.asm"
%include "includes/disk.asm"

BOOT_DRIVE: db 0

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55

; Spoof data for two sectors
times 256 dw 0xdada
times 256 dw 0xface