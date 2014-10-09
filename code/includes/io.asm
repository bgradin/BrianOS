;;;; io.asm ;;;;
; Requires:
;   string.asm

section .data

hex_value: resb 11
hex_table: db '0123456789ABCDEF'

section .text

[bits 16]		; 16 bit subroutines

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

[bits 32]		; 32 bit subroutines

; PrintString32
;   32 bit subroutine to print a string
;   Inputs:
;     eax: Address of string
;     bl: Color attribute
;     dh: Row
;     dl: Column
PrintString32:
pusha
push eax

; Calculate offset of video memory for screen location
; location = 0xb8000 + 2 * (80 * row + column)
sub eax, eax
mov al, dh		; Store row in eax
mov ecx, 80
mul ecx			; eax = ecx * 80
and edx, 0x000000FF	; Clear edx except for the lowest order byte
add eax, edx		; eax = 80 * row + column
shl eax, 1		; eax = 2 * (80 * row + column)
add eax, 0xb8000

mov ch, bl		; Store color attribute in ch
mov edx, eax		; Store video memory location in edx
pop eax			; Restore address of string
sub ebx, ebx		; Clear ebx for use as counter

PrintString32_loop:
mov cl, [eax+ebx]	; Store char at string + offset into cl

cmp cl, 0		; if (cl == 0), at end of string, sp
je PrintString32_done	; jump to done state

mov [edx], cx		; Store char and attributes at current
			; character cell

inc ebx			; Increment counters
add edx, 2
jmp PrintString32_loop	; Keep printing

PrintString32_done:
popa
ret