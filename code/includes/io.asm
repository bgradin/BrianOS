;;;; io.asm ;;;;
; Requires:
;   string.asm

; PrintString
;   Prints a string
;   Inputs:
;     eax: Address of string
;     bl: Color attribute
;     dh: Row
;     dl: Column
PrintString:
push ebp
push ecx
push ebx
push eax
push eax

call StringLength

mov ah, 0x13		; int 10/ah = 13h -> display string
mov al, 0x01		; Write mode
mov bh, 0x00		; Display page number

pop ebp			; Pointer to string
int 0x10		; Print message

pop eax
pop ebx
pop ecx
pop ebp
ret