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
push edi
push eax
push eax

mov ecx, 0x00
not ecx			; ecx = -1 or 4,294,967,295

lea di, [eax]		; Load the address of the message
mov al, 0x00
cld			; Clear the direction flag
repne scasb		; Find value in al (ecx = -strlen - 2)
not ecx			; ecx = strlen + 1
dec ecx			; ecx = strlen

mov ah, 0x13		; int 10/ah = 13h -> display string
mov al, 0x01		; Write mode
mov bh, 0x00		; Display page number

pop ebp			; Pointer to string
int 0x10		; Print message

pop eax
pop edi
pop ebx
pop ecx
pop ebp
ret