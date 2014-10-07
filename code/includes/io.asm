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

; PrintHex
;   Prints a hex value
;   Inputs:
;     eax: Hex value
;     bl: Color attribute
;     dh: Row
;     dl: Column
PrintHex:
push eax
push ebx
push ecx
push edx

mov byte [hex_value+0], 48	; Store '0'
mov byte [hex_value+1], 120	; Store 'x'

mov edx, 2

PrintHex_loop:
mov ecx, eax
and ecx, 0xF0000000	; Store highest four bits in ecx
shr ecx, 28		; Align bits right

mov ebx, [hex_table+ecx]; Get value from hex_table
mov byte [hex_value+edx], bl; Store character between '0' and 'F'

inc edx
shl eax, 4
jnz PrintHex_loop

mov ecx, 0x00
mov byte [hex_value+edx], 0; Store null byte on end

pop edx
pop ecx
pop ebx

mov eax, hex_value

call PrintString

pop eax
ret

hex_value: resb 11
hex_table: db '0123456789ABCDEF'