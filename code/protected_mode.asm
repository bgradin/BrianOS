;
; A boot sector that enters 32-bit protected mode and displays a string
;
[org 0x7c00]

mov bp, 0x9000		; Set the stack
mov sp, bp

mov ax, MSG_REAL_MODE
mov bl, 0x0f		; White on black
mov dh, 0x00		; Row 0
mov dl, 0x00		; Column 0
call PrintString

call SwitchTo32BitProtectedMode

jmp $			; Infinite loop

%include "includes/string.asm"
%include "includes/io.asm"
%include "includes/gdt.asm"
%include "includes/bitmode.asm"

[bits 32]

; This is where we arrive after switching to 32-bit protected mode
BeginProtectedMode:

mov eax, MSG_PROTECTED_MODE
mov bl, 0x02		; Green on black
mov dh, 0x01		; Row 1
mov dl, 0x00		; Column 0
call PrintString32

jmp $

MSG_REAL_MODE: 		db 'Started in 16-bit real mode...',0
MSG_PROTECTED_MODE: 	db 'Successfully switched to 32-bit protected mode',0

; Boot sector padding
times 510-($-$$) db 0
dw 0xaa55		; Magic number